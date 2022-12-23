//
//  WeatherDetailsViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    enum Section: Hashable, CaseIterable {
        case currentWeather
        case hourWeather
        case weekendWeather
        case textDescriptionOfDay
    }
    
    var weather: Weather!
    private var hourWeather: [Hour] = []
    private var weekendWeather: [ForecastDay] = []
    private var windInfo: [CityWeatherData] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCollectionView()
        createDataSource()
    }
    
    private func getData() {
        let forecast = weather.forecast
        let forecastDay = forecast.forecastday.first
        hourWeather = forecastDay?.hour ?? []
        weekendWeather.append(forecast.forecastday[1])
        weekendWeather.append(forecast.forecastday[2])
        windInfo.append(weather.current)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(CityInfoCell.self, forCellWithReuseIdentifier: CityInfoCell.reuseId)
        collectionView.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.reuseId)
        collectionView.register(WeekendInfoCell.self, forCellWithReuseIdentifier: WeekendInfoCell.reuseId)
        collectionView.register(TextDescriptionOfDayCell.self, forCellWithReuseIdentifier: TextDescriptionOfDayCell.reuseId)
        
    }
    
    // MARK: - Manage the data
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView){ (collectionView, indexPath, weather) -> UICollectionViewCell? in
            
            let sections = Section.allCases[indexPath.section]
            
            switch sections {
            case .currentWeather:
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
                
            case .weekendWeather:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekendInfoCell.reuseId, for: indexPath) as? WeekendInfoCell else {
                    return WeekendInfoCell()
                }
                cell.configure(with: weather as! ForecastDay)
                return cell
                
            case .textDescriptionOfDay:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextDescriptionOfDayCell.reuseId, for: indexPath) as? TextDescriptionOfDayCell else {
                    return TextDescriptionOfDayCell()
                }
                cell.configure(with: weather as! CityWeatherData)
                return cell
            }
        }
        dataSource?.apply(generateSnapshot(), animatingDifferences: true)
    }
    
    private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        let headerCityInfoWeather = [weather!]
        
        snapshot.appendSections([Section.currentWeather])
        snapshot.appendItems(headerCityInfoWeather, toSection: .currentWeather)
        
        snapshot.appendSections([Section.hourWeather])
        snapshot.appendItems(hourWeather, toSection: .hourWeather)
        
        snapshot.appendSections([Section.weekendWeather])
        snapshot.appendItems(weekendWeather, toSection: .weekendWeather)
        
        snapshot.appendSections([Section.textDescriptionOfDay])
        snapshot.appendItems(windInfo, toSection: .textDescriptionOfDay)
        
        return snapshot
    }
    
    // MARK: - Setup Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            
            switch section {
            case .currentWeather:
                return self.createDayInfoSection()
            case .hourWeather:
                return self.createHourInfoSection()
            case .weekendWeather:
                return self.createWeekendInfoSection()
            case .textDescriptionOfDay:
                return self.textDescriptionOdDaySection()
            }
        }
        return layout
    }
    
    private func createDayInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/4))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: -70, leading: 0, bottom: 0, trailing: 0)
        
        return layoutSection
    }
    
    private func createHourInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 25, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
    
    private func createWeekendInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/8))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 50, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
    
    private func textDescriptionOdDaySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/8))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
}








