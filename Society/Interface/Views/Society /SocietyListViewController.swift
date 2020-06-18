//
//  SocietyListViewController.swift
//  Society
//
//  Created by Adam Oxley on 03/06/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit
import Combine

class SocietyListViewController: UIViewController {
    
    private var viewModel: SocietyListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var renderedState: ViewControllerRenderedState = .pending
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var failureButton: UIButton!
    
    @IBAction func failureButtonTapped(_ sender: UIButton) {
        viewModel.list()
    }
    
    init(viewModel: SocietyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SocietyCollectionViewCell.self)
        collectionView.collectionViewLayout = ColumnFlowLayout(minColumnWidth: 340, columnHeight: 60)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
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

extension SocietyListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeue(SocietyCollectionViewCell.self,
                                      configureFrom: viewModel.dataSource[indexPath.item],
                                      at: indexPath)
    }
}

extension SocietyListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewModel = viewModel.detailViewModel(at: indexPath.row) else {
            print("done fucked up")
            print(indexPath.row)
            return
        }

        let viewController = SocietyViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
