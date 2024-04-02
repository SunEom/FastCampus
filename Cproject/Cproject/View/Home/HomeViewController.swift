//
//  HomeViewController.swift
//  Cproject
//
//  Created by 엄태양 on 3/29/24.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case banner
        case horizontalProductItem
        case thinSeparateLine
        case category
        case separateLine1
        case couponButton
        case vertialProductItem
        case separateLine2
        case theme
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var dataSource: DataSource = setDataSource()
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = setCompositionalLayout()
    private var viewModel: HomeViewModel = .init()
    private var subscriptions = Set<AnyCancellable>()
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    
    private var didTapCouponDownload: PassthroughSubject<Void, Never> =
    PassthroughSubject<Void, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        collectionView.collectionViewLayout = compositionalLayout
        
        viewModel.process(action: .loadData)
        viewModel.process(action: .loadCoupon)
        viewModel.process(action: .loadCategory)
    }
    
    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.currentSection[section] {
                case .banner:
                    return HomeBannerCollectionViewCell.bannerLayout()
                    
                case .horizontalProductItem:
                    return HomeProductCollectionViewCell.horizontalProductItemLayout()
                    
                case .thinSeparateLine:
                    return HomeThinSeparateLineCollectionViewCell.setSeparateLayout()
                    
                case .category:
                    return HomeCategoryCell.setCategoryLayout()
                    
                case .separateLine1, .separateLine2:
                    return HomeSeparateLineCollectionViewCell.separateLineLayout()
                    
                case .couponButton:
                    return HomeCouponButtonCollectionViewCell.couponButtonItemLayout()
                    
                case .vertialProductItem:
                    return HomeProductCollectionViewCell.verticalProductItemLayout()
                    
                case .theme:
                    return HomeThemeCollectionViewCell.themeLayout()
                    
                case .none:
                    return nil
                    
            }
        }
    }
    
    private func bindingViewModel() {
        viewModel.state.$collectionViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }.store(in: &subscriptions)
        
        didTapCouponDownload.receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.viewModel.process(action: .didTapCouponButton)
            }.store(in: &subscriptions)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = DataSource(collectionView: collectionView, cellProvider: {[weak self] collectionView, indexPath, viewModel in
            
            switch self?.currentSection[indexPath.section] {
                case .banner:
                    return self?.bannerCell(collectionView, indexPath, viewModel)
                    
                case .horizontalProductItem, .vertialProductItem:
                    return self?.productCell(collectionView, indexPath, viewModel)
                    
                case .thinSeparateLine:
                    return self?.thinSeparatorLineCell(collectionView, indexPath, viewModel)
                    
                case .category:
                    return self?.categoryCell(collectionView, indexPath, viewModel)
                    
                case .couponButton:
                    return self?.couponButtonCell(collectionView, indexPath, viewModel)
                    
                case .separateLine1, .separateLine2:
                    return self?.separatorLineCell(collectionView, indexPath, viewModel)
                    
                case .theme:
                    return self?.themeCell(collectionView, indexPath, viewModel)

                case .none:
                    return UICollectionViewCell()
            }
        })
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader,
                  let viewModel = self?.viewModel.state.collectionViewModels.themeViewModels.headerViewModel
            else { return nil }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeThemeHeaderView.identifier, for: indexPath) as? HomeThemeHeaderView
            headerView?.setViewModel(viewModel)
            
            return headerView
        }
        
        return dataSource
    }

    private func applySnapshot() {
        var snapShot: Snapshot = Snapshot()
        snapShot.appendSections([.banner, .horizontalProductItem, .thinSeparateLine, .category, .separateLine1, .couponButton, .vertialProductItem, .separateLine2, .theme])
        
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {
            snapShot.appendItems(
                bannerViewModels,
                toSection: .banner
            )
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels {
            snapShot.appendItems(
                horizontalProductViewModels,
                toSection: .horizontalProductItem
            )
        }
        
        snapShot.appendItems(
            viewModel.state.collectionViewModels.thinSeparateLineViewModels,
            toSection: .thinSeparateLine
        )
        
        snapShot.appendItems(
            viewModel.state.collectionViewModels.categoryViewModels,
            toSection: .category
        )
        
        snapShot.appendItems(
            viewModel.state.collectionViewModels.separateLine1ViewModel,
            toSection: .separateLine1
        )
        
        if let couponViewModels = viewModel.state.collectionViewModels.couponViewModels {
            snapShot.appendItems(
                couponViewModels,
                toSection: .couponButton
            )
        }
        
        snapShot.appendItems(
            viewModel.state.collectionViewModels.separateLine2ViewModel,
            toSection: .separateLine2
        )

        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapShot.appendItems(
                verticalProductViewModels,
                toSection: .vertialProductItem
            )
        }
        
        if let themeViewModels = viewModel.state.collectionViewModels.themeViewModels.items {
            snapShot.appendItems(
                themeViewModels,
                toSection: .theme
            )
        }
        
        dataSource.apply(snapShot)
    }
    
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeBannerCollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCollectionViewCell.identifier, for: indexPath) as? HomeBannerCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func productCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeProductCollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.identifier, for: indexPath) as? HomeProductCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func categoryCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeCategoryCell {
        guard let viewModel = viewModel as? HomeCategoryCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.identifier, for: indexPath) as? HomeCategoryCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func couponButtonCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeCouponButtonCollectionViewCell {
        guard let viewModel = viewModel as? HomeCouponButtonCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCouponButtonCollectionViewCell.identifier, for: indexPath) as? HomeCouponButtonCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel, didTapCouponDownload)
        return cell
    }
    
    private func thinSeparatorLineCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeThinSeparateLineCollectionViewCell {
        guard let viewModel = viewModel as? HomeThinSeparateLineCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThinSeparateLineCollectionViewCell.identifier, for: indexPath) as? HomeThinSeparateLineCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func separatorLineCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeSeparateLineCollectionViewCell {
        guard let viewModel = viewModel as? HomeSeparateLineCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSeparateLineCollectionViewCell.identifier, for: indexPath) as? HomeSeparateLineCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func themeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> HomeThemeCollectionViewCell {
        guard let viewModel = viewModel as? HomeThemeCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThemeCollectionViewCell.identifier, for: indexPath) as? HomeThemeCollectionViewCell
        else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        let favoriteStoryBoard: UIStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        if let favoriteVIewController: UIViewController = favoriteStoryBoard.instantiateInitialViewController() {
            navigationController?.pushViewController(favoriteVIewController, animated: true)
        }
    }
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
