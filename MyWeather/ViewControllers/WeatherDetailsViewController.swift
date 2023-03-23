//
//  WeatherDetailsViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 14.12.2022.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    //MARK: - Public Properties
    var weather: Weather!
    
    //MARK: - Private Properties
    private var hourWeather: [Hour] = []
    private var weekendWeather: [ForecastDay] = []
    private var windInfo: CityWeatherData?
    private var daySpecs: [DaySpec] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var collectionView: UICollectionView!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCollectionView()
        createDataSource()
    }
    
    //MARK: - Private Methods
    private func getData() {
        let forecast = weather.forecast
        let forecastDay = forecast.forecastday.first
        hourWeather = forecastDay?.hour ?? []
        weekendWeather.append(forecast.forecastday[1])
        weekendWeather.append(forecast.forecastday[2])
        windInfo = weather.current
        WeatherSpecs.allCases.map { daySpecs.append(DaySpec(description: $0.rawValue, value: WeatherSpecs.getInfo(for: $0, from: weather)))
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        collectionView.register(CityInfoCell.self, forCellWithReuseIdentifier: CityInfoCell.reuseId)
        collectionView.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.reuseId)
        collectionView.register(WeekInfoCell.self, forCellWithReuseIdentifier: WeekInfoCell.reuseId)
        collectionView.register(WindDescriptionCell.self, forCellWithReuseIdentifier: WindDescriptionCell.reuseId)
        collectionView.register(DaySpecsCell.self, forCellWithReuseIdentifier: DaySpecsCell.reuseId)
    }
    
    // MARK: - Manage the Data
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) {
            collectionView, indexPath, weather in
            
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
                
            case .weekWeather:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekInfoCell.reuseId, for: indexPath) as? WeekInfoCell else {
                    return WeekInfoCell()
                }
                cell.configure(with: weather as! ForecastDay)
                return cell
                
            case .windDescription:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindDescriptionCell.reuseId, for: indexPath) as? WindDescriptionCell else {
                    return WindDescriptionCell()
                }
                cell.configure(with: weather as! CityWeatherData)
                return cell
                
            case .daySpecs:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaySpecsCell.reuseId, for: indexPath) as? DaySpecsCell else {
                    return DaySpecsCell()
                }
                
                let spec = self.daySpecs[indexPath.row]
                cell.configure(with: spec.description, and: spec.value)
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return Header() }
            guard let item = self.dataSource?.itemIdentifier(for: indexPath) else { return Header() }
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else { return Header() }
            
            sectionHeader.title.text = section.rawValue
            
            return sectionHeader
        }
        
        dataSource?.apply(generateSnapshot(), animatingDifferences: true)
    }
    
    private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([Section.currentWeather])
        snapshot.appendItems([weather], toSection: .currentWeather)
        
        snapshot.appendSections([Section.hourWeather])
        snapshot.appendItems(hourWeather, toSection: .hourWeather)
        
        snapshot.appendSections([Section.weekWeather])
        snapshot.appendItems(weekendWeather, toSection: .weekWeather)
        
        snapshot.appendSections([Section.windDescription])
        snapshot.appendItems([windInfo], toSection: .windDescription)
        
        snapshot.appendSections([Section.daySpecs])
        snapshot.appendItems(daySpecs, toSection: .daySpecs)
        
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
            case .weekWeather:
                return self.createWeekInfoSection()
            case .windDescription:
                return self.textDescriptionOdDaySection()
            case .daySpecs:
                return self.daySpecsSection()
            }
        }
        
        layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseId)

        return layout
    }
    
    private func createDayInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: -10, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
    
    private func createHourInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                               heightDimension: .absolute(110))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 30, leading: 8, bottom: 0, trailing: 8)
        
        return layoutSection
    }
    
    private func createWeekInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSection.boundarySupplementaryItems = [header]
        
        layoutSection.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseId)
        ]
        
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
    
    private func daySpecsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 8, trailing: 0)
        
        return layoutSection
    }
}

extension WeatherDetailsViewController {
    enum Section: String, Hashable, CaseIterable {
        case currentWeather
        case hourWeather
        case weekWeather = "Weather for 2 days"
        case windDescription
        case daySpecs
    }
}

