//
//  ScreenNameViewController.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MoviesListViewModel!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "ScreenNameTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        addSearchBar()
        
        DispatchQueue.main.async {
            self.viewModel.getMovies()
        }
        
        viewModel.onLoadData = { [weak self] list in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onApiRequestFailure = {[weak self] alert in
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: alert.dismissButton, style: .cancel, handler: { action in
                    alertController.dismiss(animated: true)
                }))
                
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        
        viewModel.navigateToDetail = { [weak self] viewModel in
            DispatchQueue.main.async {
                self?.navigateToDetailViewController(with: viewModel)
            }
        }
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ScreenNameTableViewCell
        cell?.setData(data: viewModel.filteredArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let screenNameCell = cell as? ScreenNameTableViewCell else {return}
        screenNameCell.populateData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToMovieDetails(selectedIndex: indexPath.row)
    }
    
    func navigateToDetailViewController(with movieViewModel: DetailMovieViewModel) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailMovieViewController")
                as? DetailMovieViewController else {
            return
        }
        
        detailViewController.viewModel = movieViewModel
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    
    func addSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search by name"
        navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Clear the filter and show all items if cross button is pressed
            viewModel.clearFilter()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                searchBar.resignFirstResponder()
            }
        }else {
            filterMovies(searchText: searchText)
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterMovies(searchText: String) {
        viewModel.filterMoviesByName(searchText)
        tableView.reloadData()
    }
}
