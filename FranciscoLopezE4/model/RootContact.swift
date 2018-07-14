//
//  RootContact.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 4/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import Foundation

class RootContact{
    
    var contact: [Contact] = []
    
    init(dictionary: [String:AnyObject]){
        let dicContacts = dictionary["contacts"] as? [[String:AnyObject]]
        if let contacts = dicContacts{
            for theContact in contacts{
                let newContact = Contact(dictionary: theContact)
                self.contact.append(newContact)
            }
        }
    }
}
