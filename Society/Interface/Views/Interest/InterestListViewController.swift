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
    private var cancellable = [AnyCancellable]()

    @IBOutlet weak var collectionView: UICollectionView!

    init(viewModel: InterestListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = .init()
        collectionView.register(InterestCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        viewModel.fetch()
        
        viewModel.$dataSource.sink() { _ in
            self.collectionView.reloadData()
        }.store(in: &cancellable)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InterestListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped item at indexPath \(indexPath)")
    }
}

extension InterestListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(InterestCollectionViewCell.self,
                                      configureFrom: viewModel.dataSource[indexPath.item],
                                      at: indexPath)
    }
}
