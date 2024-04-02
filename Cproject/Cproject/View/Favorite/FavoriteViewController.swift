//
//  FavoriteViewController.swift
//  Cproject
//
//  Created by 엄태양 on 4/2/24.
//

import UIKit
import Combine

final class FavoriteViewController: UIViewController {
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case favorite
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: DataSource = setDataSource()
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    private var viewModel: FavoriteViewModel = FavoriteViewModel()
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        viewModel.process(.fetchFavoriteDataFromAPI)
    }
    
    private func bindViewModel() {
        viewModel.state.$tableViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }.store(in: &subscriptions)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, viewModel in
            switch self?.currentSection[indexPath.section] {
                case .favorite:
                    return self?.favoriteCell(tableView, indexPath, viewModel)
                case .none:
                    return .init()
            }
        }
        
        return dataSource
    }
    
    private func favoriteCell(_ tableView: UITableView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UITableViewCell? {
        guard let viewModel = viewModel as? FavoriteItemTableViewCellViewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteItemTableViewCell.identifier, for: indexPath) as? FavoriteItemTableViewCell
        else { return nil }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func applySnapshot() {
        var snapShot: Snapshot = Snapshot()
        
        snapShot.appendSections([.favorite])
        
        if let favorites = viewModel.state.tableViewModel {
            snapShot.appendItems(
                favorites,
                toSection: .favorite
            )
        }
        
        dataSource.apply(snapShot)
    }
    
}

#Preview {
    FavoriteViewController()
}

