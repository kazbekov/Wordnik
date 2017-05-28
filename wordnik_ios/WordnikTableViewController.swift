//
//  WordnikTableViewController.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit

class WordnikTableViewController: UITableViewController {
    
    var words = [[String:Any]]()
    var synonyms = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
        setUpSearch()
        setUpNavigationBar()
        

       
    }
    
    func blurEffect(){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wordnik"))
        self.tableView.backgroundView = imageView
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
    }
    
    func setUpSearch(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setUpNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourites", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func addTapped(){
        performSegue(withIdentifier: "fav", sender: nil)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.synonyms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.synonyms[indexPath.row]
        cell.textLabel?.textColor = .white

        return cell
    }
    
    func downloadWord(url: String){
        let urlGet = URL(string: url)
        URLSession.shared.dataTask(with:urlGet!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    self.words = []
                    self.words = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                    print(self.words)
                    if self.words.count != 0{
                        for word in self.words[0]["words"] as! [String]{
                            self.synonyms.append(word)
                        }
                    }
                    self.tableView.reloadData()
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as!  DetailViewController
                controller.word = synonyms[indexPath.row]
            }
        }
    }
 

}

extension WordnikTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.synonyms = []
        self.words = []
    self.tableView.reloadData()}
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let string = searchController.searchBar.text?.lowercased() else { return }
        let url = "http://api.wordnik.com:80/v4/word.json/\(string)/relatedWords?useCanonical=false&relationshipTypes=synonym&limitPerRelationshipType=10&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        
        downloadWord(url: url)
    }
}

extension WordnikTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {    }
}
