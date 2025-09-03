//
//  ViewController.swift
//  iOSAssignment
//
//  Created by Lingaswami Karingula on 01/09/25.
//

import UIKit

class ViewController: UIViewController{

    // MARK: - Properties
    private let repoListViewModel = RepoListViewModel()
    private let navigationBarView = UINavigationBar()
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private enum Layout {
        static let cellHeight: CGFloat = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoListViewModel.fetchRepos()
        setupUI()
        viewModelBinding()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.title = "Swift Repositories"
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 28)
        ]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    
    private func setupUI() {
        // TableView setup
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: "#24292e")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        
        // SearchBar setup
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor(hex: "#24292e")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        
        // Customize search text field rounded with border
        let textField = searchBar.searchTextField
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor(red: 0, green: 0.692, blue: 0.724, alpha: 1).cgColor
        textField.layer.cornerRadius = 13
        textField.clipsToBounds = true
        textField.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    func viewModelBinding() {
        // Update table when data changes
        repoListViewModel.onUpdate = {  [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Show toast if an error occurs
        repoListViewModel.onError = { [weak self] message in
            self?.showToast(message: message)
        }
    }
}

// MARK: - UITableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoListViewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        cell.repos = repoListViewModel.filteredRepos?[indexPath.row]
        return cell
    }
    
    /// Handles row selection → opens repository URL in Safari
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repoListViewModel.filteredRepos?[indexPath.row]
        if let urlString = repo?.html_url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.cellHeight
    }
}

// MARK: - UISearchBar Delegate
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        repoListViewModel.searchRepos(searchText)
    }
}

