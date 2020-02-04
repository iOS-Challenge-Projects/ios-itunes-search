//
//  SearchResultsTableViewController.swift
//  ios-itunes-search
//
//  Created by FGT MAC on 2/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itunesCell", for: indexPath)
        
        

        let result = searchResultsController.searchResults[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.creator
        return cell
    }

}

extension SearchResultsTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        var resultType: ResultType!
        
        switch segmentController.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .music
        case 2:
            resultType = .movie
        default:
            resultType = .none
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
