//
//  ViewController.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 26/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewContactList: UITableView!
    var arrayContactList = [ContactsViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        HUD.show(on: self.view)
         getContacts()
    }
    
    func getContacts() {
        
        Service.searviceSharedInstance.getContactsListRecord { (contactslist, error) in
            if(error == nil){
                self.arrayContactList = contactslist?.map({return ContactsViewModel(contact: $0)}) ?? []
               //print(self.arrayContactList)
                DispatchQueue.main.async {
                    self.tableViewContactList.reloadData()
                }
                //print(contactslist!)
            }
            HUD.hide(from: self.view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailscreenidentifire"{
            //var detailViewController = segue.destination as! ContactDetailViewController
            //print(detailViewController)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as! ContactsTableViewCell
        //cell.lblFullName.text = String(arrayContactList[indexPath.row].first_name ?? "") + " " + String(arrayContactList[indexPath.row].last_name ?? "")
        cell.configure(arrayContactList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    /*func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        <#code#>
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! ContactsTableViewCell
        self.performSegue(withIdentifier: "detailscreenidentifire", sender: self)
    }
}

