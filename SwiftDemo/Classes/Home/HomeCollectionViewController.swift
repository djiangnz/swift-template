//
//  HomeCollectionViewController.swift
//  SwiftDemo
//
//  Created by djiang on 10/10/21.
//

import Controls
import ReSwift
import UIKit

class HomeCollectionViewController: DiffableCollectionViewController<HomeCollectionViewModel, HomeCollectionViewState> {
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: Self.listLayout)
        viewModel = HomeCollectionViewModel()
    }

    private var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brand.background
        self.title = "Test Title"
        configureSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { $0.select { $0.homeState }.skip(when: ==) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

extension HomeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowModel = viewModel.viewState.collection.itemModel(at: indexPath)
        switch rowModel {
        case .cell1(let cellViewModel):
            return HomeCollectionCell1.create(in: collectionView, for: indexPath, with: cellViewModel)
        case .cell2(let cellViewModel):
            return HomeCollectionCell1.create(in: collectionView, for: indexPath, with: cellViewModel)
        }
    }
}

extension HomeCollectionViewController: StoreSubscriber {
    func newState(state: HomeState) {
        self.viewModel.viewState = viewModel.buildViewState(state)
        print(state.isSearching)
        self.applySnapshot()
    }
}

extension HomeCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        store.dispatch(HomeActionUpdateSearch(isSearching: true, query: searchController.searchBar.text))
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Searching..."
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension HomeCollectionViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        store.dispatch(HomeActionUpdateSearch(isSearching: false, query: nil))
    }
}
