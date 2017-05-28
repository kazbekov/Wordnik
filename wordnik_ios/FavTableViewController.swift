//
//  FavTableViewController.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var favArray = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.array(forKey: "fav") != nil {
            favArray = defaults.array(forKey: "fav") as! [[String]]
            print(favArray[0][0])
            tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavTableViewCell
        
        if favArray.count != 0{
            cell.wordLabel.text = favArray[indexPath.row][0]
            cell.descriptionLabel.text = favArray[indexPath.row][1]
        }

        // Configure the cell...

        return cell
    }


}
