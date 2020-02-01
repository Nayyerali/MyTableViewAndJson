//
//  ViewController.swift
//  TableViewANdJsonParsing
//
//  Created by Nayyer Ali on 1/31/20.
//  Copyright © 2020 Nayyer Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
 
    var userDisease = [Disease]()
    var searchDisease = [String]()
    var SearchingDieases = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var diseaseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson ()
        diseaseTableView.dataSource = self
        diseaseTableView.delegate = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if SearchingDieases {
            return searchDisease.count
        } else {
        return userDisease.count
        }
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseTableViewCell") as! DiseaseTableViewCell
        if SearchingDieases {
            cell.diseasesTextField.text = searchDisease[indexPath.row]
        } else {
            cell.diseasesTextField.text = userDisease[indexPath.row].disease
        
        return cell
            
        }
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60.0
        }
    
    func downloadJson () {
        
        let url = URL(string: "https://raw.githubusercontent.com/Shivanshu-Gupta/web-scrapers/master/medical_ner/medicinenet-diseases.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                let abc = try JSONDecoder().decode([Disease].self, from: data!)
                    self.diseaseTableView.reloadData()
                for diseses in abc{
                    print(diseses.disease)
                    self.userDisease.append(diseses)
                }
                    DispatchQueue.main.async {
                    self.diseaseTableView.reloadData()
                    }
            } catch {
                print ("Data Not Found")
                }
            }
        }.resume()
    }
    
    // User input text

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // alphabetically search Disease
        searchDisease = userDisease.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        SearchingDieases = true
        diseaseTableView.reloadData()
        }
    }

