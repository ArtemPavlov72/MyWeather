//
//  WeatherDetailsViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    enum Section: Hashable, CaseIterable {
        case cityInfo
        case hourWeather
    }
    
    var cityWeather: Weather!
    var hourWeather: [Hour] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forecast = cityWeather.forecast
        let forecastDay = forecast.forecastday.first
        hourWeather = forecastDay?.hour ?? []
        
        setupCollectionView()
        createDataSource()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        collectionView.register(CityInfoCell.self, forCellWithReuseIdentifier: CityInfoCell.reuseId)
        collectionView.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.reuseId)
    }
    
    // MARK: - Manage the data
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView){ (collectionView, indexPath, weather) -> UICollectionViewCell? in
           
            let sections = Section.allCases[indexPath.section]
            switch sections {
            case .cityInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCell.reuseId, for: indexPath) as? CityInfoCell else {
                    return CityInfoCell()
                 }
                cell.configure(with: weather as! Weather)
                return cell
            case .hourWeather:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCell.reuseId, for: indexPath) as? HourInfoCell else {
                    return HourInfoCell()
                 }
               
                cell.configure(with: weather as! Hour)
                return cell
            }
        }
        dataSource?.apply(generateSnapshot(), animatingDifferences: true)
    }
    
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
           
        let headerCityInfoWeather = [cityWeather!]
        
        snapshot.appendSections([Section.cityInfo])
        snapshot.appendItems(headerCityInfoWeather, toSection: .cityInfo)
        
        let hourCityInfoWeather = hourWeather
        snapshot.appendSections([Section.hourWeather])
        snapshot.appendItems(hourCityInfoWeather, toSection: .hourWeather)
        
        return snapshot
    }
    
    // MARK: - Setup Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            
            switch section {
            case .cityInfo:
                return self.createDayInfoSection()
            case .hourWeather:
                return self.createHourInfoSection()
            }
        }
        return layout
    }
    
    func createDayInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: -30, leading: 0, bottom: 0, trailing: 0)
        
        return layoutSection
    }
    
    func createHourInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                                     heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
}








