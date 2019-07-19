//
//  Service.swift
//  ContactsDemoApp
//
//  Created by Abhishek Gupta on 27/06/19.
//  Copyright © 2019 Abhishek Gupta. All rights reserved.
//

import Foundation

struct Constant {
    static let BASEURL = "http://gojek-contacts-app.herokuapp.com"
}

class Service: NSObject {
    
    static let searviceSharedInstance = Service()
    
    private override init() {}
    
    func getContactsListRecord(complition: @escaping([ContactsModel]?, Error?) -> ()){
        let urlString = "\(Constant.BASEURL)/contacts.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let err = error {
                complition(nil,err)
                print("Error in request \(error?.localizedDescription ?? "Error in request")")
            }else{
                guard let data = data else { return }
                do{
                    var arrayContactsList = [ContactsModel]()
                    let result = try JSONDecoder().decode([ContactsModel].self, from: data)
                    //print("Rasult:- \(result)")

                    for contact in result {
                        arrayContactsList.append(ContactsModel(first_name: contact.first_name!, last_name: contact.last_name!, profile_pic: contact.profile_pic!, favorite: contact.favorite!, id: contact.id!))
                    }
                    //print(arrayContactsList)
                    complition(arrayContactsList, nil)
                }catch let jsonError{
                    print("error in Json \(jsonError)")
                }
            }
            }.resume()
    }
}

protocol CancelableTask {
    func cancelTask()
}

extension URLSessionDataTask: CancelableTask {
    func cancelTask() {
        self.cancel()
    }
}
