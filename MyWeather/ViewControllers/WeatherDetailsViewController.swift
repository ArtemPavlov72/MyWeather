//
//  WeatherDetailsViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case cityInfo
    }
    
    var city: Weather!
    var dataSource: UICollectionViewDiffableDataSource<Section, Weather>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(CityInfoCell.self, forCellWithReuseIdentifier: CityInfoCell.reuseId)
    }
    
    // MARK: - Manage the data
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Weather>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, city: Weather) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCell.reuseId, for: indexPath) as? CityInfoCell
            cell?.configure(with: city)
            return cell
        }
        )
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Weather>()
        let sections: [Section] = Section.allCases
        snapshot.appendSections([sections[0]])
        snapshot.appendItems(Array(arrayLiteral: city))
        dataSource?.apply(snapshot)
    }
    
    // MARK: - Setup Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            
            switch section {
            case .cityInfo:
                return self.createCategorySection()
            }
        }
        return layout
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(350),
                                                     heightDimension: .estimated(150))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        return layoutSection
    }
}






