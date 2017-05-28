//
//  DetailViewController.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var definitions = [[String: Any]]()
    var word = "NO"
    var words = [[String:Any]]()
    var synonyms = [String]()
    var favArray = [[String]]()
    let defaults = UserDefaults.standard

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.array(forKey: "fav") != nil{
            favArray = defaults.array(forKey: "fav") as! [[String]]
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addFav))
        wordLabel.text = word
        let url = "http://api.wordnik.com:80/v4/word.json/\(word)/definitions?limit=200&partOfSpeech=verb&includeRelated=true&useCanonical=false&includeTags=false&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        let url2 = "http://api.wordnik.com:80/v4/word.json/\(word)/relatedWords?useCanonical=false&relationshipTypes=synonym&limitPerRelationshipType=10&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        downloadDefenitions(url: url)
        downloadWord(url: url2)

    }
    
    func addFav(){
        favArray.append(["\(word)", "\(descriptionLabel.text!)"])
        defaults.set(favArray, forKey: "fav") 
    }
    
    func downloadDefenitions(url: String){
        let urlGet = URL(string: url)
        URLSession.shared.dataTask(with:urlGet!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    self.definitions = []
                    self.definitions = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
                    print(self.definitions)
                    if self.definitions.count != 0{
                        self.descriptionLabel.text = self.definitions[0]["text"] as? String
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return synonyms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = synonyms[indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }

}
