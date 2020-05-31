//
//  DiscoverSearchController.swift
//  Society
//
//  Created by Adam Oxley on 25/02/2020.
//  Copyright © 2020 Adam Oxley. All rights reserved.
//

import UIKit

class DiscoverSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultsUpdater = self
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Type something here to search"
        searchBar.searchBarStyle = .minimal
    }
}

extension DiscoverSearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
    }
}
