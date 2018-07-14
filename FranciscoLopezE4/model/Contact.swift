//
//  Contact.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 4/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import Foundation

class Contact{
    
    var name: String
    var surname: String
    var phone: String
    var mail: String
    var company: String
    var image: String
    
    public init (name: String, surname: String, phone: String, mail: String, company: String, image: String){
        self.name = name
        self.surname = surname
        self.phone = phone
        self.mail = mail
        self.company = company
        self.image = image
        
        
    }
    
    init(dictionary: [String:AnyObject]){
        self.name = dictionary["name"] as? String ?? "noName"
        self.surname = dictionary["surname"] as? String ?? "noSurname"
        self.phone = dictionary["phone"] as? String ?? "0"
        self.mail = dictionary["mail"] as? String ?? "noMail"
        self.company = dictionary["company"] as? String ?? "noCompany"
        self.image = dictionary["image"] as? String ?? "noImage"
    }
    
    func getName() -> String {
        return name + " " + surname
    }
}
