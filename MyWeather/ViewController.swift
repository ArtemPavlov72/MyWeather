//
//  ViewController.swift
//  MyWeather
//
//  Created by Artem Pavlov on 10.12.2022.
//

import UIKit

class WeatherController: UITableViewController {

    private let cellID = "weatherCell"
   // private var cytiesList: [TaskList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
      //  taskLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
    //    let taskList = taskLists[indexPath.row]
     //   cell.configure(with: taskList)
        return cell
    }


}

