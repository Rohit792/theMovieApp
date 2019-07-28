//
//  ViewController.swift
//  flimApp
//
//  Created by Mac on 28/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import dynamicLybrary



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var TXTSearch: UITextField!
    @IBOutlet weak var VCSearch: UIView!
    @IBOutlet weak var VCNotFound: UIView!
    
    @IBOutlet weak var tableVew: UITableView!
    
    var arrayMovie : [[String:Any]] = []
    var arraySearch : [[String:Any]] = []

    var isSearched = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        UISetUp()
        initialisation()
        getData()
        
        
    }

    func UISetUp()
    {
        tableVew.isHidden = false
        VCNotFound.isHidden = true
        
        VCSearch.layer.cornerRadius = 10
        VCNotFound.dropShadow()
    }
    
    
    func initialisation()
    {
        
        arrayMovie.removeAll()
        arraySearch.removeAll()
        
        
        isSearched = -1
        
        tableVew.delegate = self
        tableVew.dataSource = self
        
        TXTSearch.delegate = self
        
        tableVew.register(UINib(nibName: "movieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell")
        
        tableVew.reloadData()
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        TXTSearch.resignFirstResponder()
        
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let searchText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        tableVew.isHidden = false
        VCNotFound.isHidden = true
        isSearched = -1
        
        
        if searchText == ""
        {
            arraySearch.removeAll()
            tableVew.reloadData()
            
            return true
        }
        
        let predicate = NSPredicate(format: "title contains[cd] %@", searchText)
        arraySearch = arrayMovie.filter { predicate.evaluate(with: $0) }
        
        
        
        if arraySearch.count == 0 {

            isSearched = 1
        
            tableVew.isHidden = true
            VCNotFound.isHidden = false
        }

        
        tableVew.reloadData()

        return true
    }
    
    func getData()
    {

        let movieObj = videoData(name: "Black")
        
        
        // API Call from dynamic Library
        movieObj.getAPIData(onSuccess: { jsonResult in
            
            DispatchQueue.main.async {

                self.arrayMovie = jsonResult["items"] as! [[String:Any]]
                
                
               
                let predicate1 = NSPredicate(format: "release_date contains[cd] %@","2017")
                let predicate2 = NSPredicate(format: "release_date contains[cd] %@","2018")
                let predicate = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])

                let sortedArray = self.arrayMovie.filter { predicate.evaluate(with: $0) }

                
                
                let sortObj = SortingMovies()
                let arrayToSort = sortObj.sort(byRatting: sortedArray) // Sorting from Static library

                self.arrayMovie.removeAll()
                
                
                self.arrayMovie = arrayToSort.mutableCopy() as! [[String : Any]]

                

                self.tableVew.reloadData()
//                print(jsonResult)
            }
            
        }) { (error, strError) in
            
            DispatchQueue.main.async {

                self.showAlert(message: strError    )
                print(error as Any)
            }
        }
    }
    
    
    
    //use:

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arraySearch.count != 0
        {
            return arraySearch.count
        }
        return arrayMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : movieTableViewCell! = tableVew.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? movieTableViewCell
        
        var dirD : [String : Any] = [:]
        
        if arraySearch.count != 0
        {
            dirD = arraySearch[indexPath.row]
        }
        else
        {
            dirD = arrayMovie[indexPath.row]
        }
        
        
        cell.LBtitle.text   = dirD["title"] as? String
        cell.LBRatting.text = "\(dirD["vote_average"] as? String ?? "")"
        cell.LBYear.text    = dirD["release_date"] as? String
        
        cell.VCContainer.dropShadow()

        return cell
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 83
    }
    
    
    
    
}

