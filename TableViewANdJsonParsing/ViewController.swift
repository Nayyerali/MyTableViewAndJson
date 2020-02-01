//
//  ViewController.swift
//  TableViewANdJsonParsing
//
//  Created by Nayyer Ali on 1/31/20.
//  Copyright © 2020 Nayyer Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
 
    var Diseases = [Disease]()
    
    var searchDiseases = [Disease]()
    
    
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
            return searchDiseases.count
        } else {
            return Diseases.count
        }
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseTableViewCell") as! DiseaseTableViewCell
        if SearchingDieases {
            cell.diseasesTextField.text = searchDiseases[indexPath.row].disease
        } else {
            cell.diseasesTextField.text = Diseases[indexPath.row].disease
        }
        return cell
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
                   // self.diseaseTableView.reloadData()
                for diseses in abc{
                    print(diseses.disease)
                    self.Diseases.append(diseses)
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
        searchDiseases = Diseases
        searchDiseases = Diseases.filter({$0.disease.prefix(searchText.count) == searchText})
        SearchingDieases = true
        diseaseTableView.reloadData()
        }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        SearchingDieases = false
        searchBar.text = ""
        diseaseTableView.reloadData()
    }
}

