//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/28/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchViewControllerDelegate: class {
    func homeView(view: SearchViewController, needsPerfom actions: SearchViewController.Action)
}

final class SearchViewController: UIViewController {

    enum Action {
        case data(lat: Double, long: Double, name: String)
    }

    // MARK: - Properties
    var viewModel: SearchViewModel = SearchViewModel()
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
    weak var delegate: SearchViewControllerDelegate?

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configSearchBar()
        configTableView()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        viewModel.fetchData { _ in
            self.tableView.reloadData()
        }
    }

    // MARK: - Private functions
    private func configSearchBar() {
        searchBar.placeholder = "Search "
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }

    private func configTableView() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadDataSearch(key: String) {
        viewModel.isSearching = true
        viewModel.getDataSearch(keySearch: key) { [weak self] result in
            guard let this = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    this.tableView.reloadData()
                case .failure(let error):
                    this.alert(msg: error.localizedDescription, handler: nil)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForSearch(at: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = HomeViewController()
        vc.viewModel = viewModel.viewModelForHome(at: indexPath)
        delegate?.homeView(view: self, needsPerfom: .data(lat: viewModel.viewModelForHome(at: indexPath).lat,
                                                          long: viewModel.viewModelForHome(at: indexPath).lon,
                                                          name: viewModel.viewModelForHome(at: indexPath).name))
        navigationController?.popViewController(animated: true)
      //  navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadDataSearch(key: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.fetchData { _ in
                self.tableView.reloadData()
                self.viewModel.isSearching = false
            }
        }
    }
}

// MARK: - SearchTableViewCellDelegate
extension SearchViewController: SearchTableViewCellDelegate {
    func searchView(view: SearchTableViewCell, needsPerfom actions: SearchTableViewCell.Action) {
        guard let indexPath = tableView.indexPath(for: view) else { return }
        switch actions {
        case .save:
            viewModel.saveSearchToRealm(at: indexPath)
        case .delete:
            viewModel.removeSearchFromRealm(at: indexPath)
        }
        tableView.reloadData()
    }
}
