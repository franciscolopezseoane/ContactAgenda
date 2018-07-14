//
//  ContactTableViewCell.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 4/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import UIKit
import Kingfisher

class ContactTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contacImage: UIImageView!
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var contactPhoneLbl: UILabel!
    
    func setup(contact: Contact){

//        let theImage = contact.image
//        let theUrl = URL(string: theImage)
//        contacImage.kf.setImage(with: theUrl, placeholder: #imageLiteral(resourceName: "contact"), options: nil, progressBlock: nil, completionHandler: nil)
        
      //  contacImage.image = 
        contactNameLbl.text = contact.getName()
        contactPhoneLbl.text = "\(contact.phone)"
    }

}
