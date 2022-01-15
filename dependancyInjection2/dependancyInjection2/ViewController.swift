//
//  ViewController.swift
//  dependancyInjection2
//
//  Created by Ebrahim  Mo Gedamy on 4/2/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

protocol EmailAccounts {
    var name : String{get}
    var domain : String {get}
    var lastEmailReceived : Date {get}
}

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet var myTableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.data = models()
    }
    
    var data = [EmailAccounts]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell{
            cell.textLabel?.text = "\(data[indexPath.row].name)\n\(data[indexPath.row].domain)"
            cell.detailTextLabel?.text = "\(data[indexPath.row].lastEmailReceived)"
            return cell
        }else{return UITableViewCell()}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func models() -> [EmailAccounts] {
        let models : [EmailAccounts] = [Gmails(),Yahoo(),Outlook()]
        
        return models
    }
    
    @IBAction func doneBuTapped(_ sender: UIButton) {
        ///project 1
        //        let movie = Movie(title: "I origin", genre: "Sciencetific")
        //        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailsViewController", creator: { (coder) in
        //            print("success")
        //            return DetailsViewController(coder: coder, movie: movie)
        //        })else{
        //            print("I origin movie doesn't exist")
        //            return}
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class Gmails : EmailAccounts{
    var name: String {
        return "Ebrahim"
    }
    
    var domain: String{
        return "gmail.com"
    }
    
    var lastEmailReceived: Date{
        return Date()
    }
}

class Yahoo : EmailAccounts{
    var name: String {
        return "Ebrahim"
    }
    
    var domain: String{
        return "yahoo.com"
    }
    
    var lastEmailReceived: Date{
        return Date()
    }
}

class Outlook : EmailAccounts{
    var name: String {
        return "Ebrahim"
    }
    
    var domain: String{
        return "outlook.com"
    }
    
    var lastEmailReceived: Date{
        return Date()
    }
}

