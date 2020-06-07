//
//  InterestListViewController.swift
//  Society
//
//  Created by Adam Oxley on 29/05/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class InterestListViewController: UIViewController {
    
    private var viewModel: InterestListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var selectedInterestItems: [InterestViewModel] = []
    @Published private(set) var renderedState: ViewControllerRenderedState = .pending

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var failureButton: UIButton!
    
    @IBAction func failureButtonTapped(_ sender: UIButton) {
        viewModel.list()
    }
    
    init(viewModel: InterestListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(InterestCollectionViewCell.self)
        collectionView.collectionViewLayout = ColumnFlowLayout(minColumnWidth: 120)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self

        viewModel.list()
        
        viewModel.$dataSource
            .receive(on: RunLoop.main)
            .sink() { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)
    }
    
    private func stateValueHandler(_ state: ViewModelLoadingState<HTTPError>) -> Void {
        switch state {
        case .loading:
            failureButton.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .complete:
            failureButton.isHidden = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            renderedState = .rendered
        case .error:
            failureButton.isHidden = false
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            renderedState = .failure
        }
    }
}

extension InterestListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell {
            cell.isSelected = true
        }
        
        selectedInterestItems.append(viewModel.dataSource[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell {
            cell.isSelected = false
        }
        
        let item = viewModel.dataSource[indexPath.row]
        guard let index = selectedInterestItems.firstIndex(of: item) else { return }
        selectedInterestItems.remove(at: index)
    }
}

extension InterestListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeue(InterestCollectionViewCell.self,
                                      configureFrom: viewModel.dataSource[indexPath.item],
                                      at: indexPath)
    }
}
