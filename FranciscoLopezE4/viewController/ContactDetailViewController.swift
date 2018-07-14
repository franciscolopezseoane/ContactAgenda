//
//  ContactDetailViewController.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 4/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class ContactDetailViewController: UIViewController {

    var myContact: Contact?
    var storageRef: StorageReference!
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = Storage.storage().reference()
        
        
        if let oneContact = myContact{
            companyLbl.text = oneContact.company
            phoneLbl.text = oneContact.phone
            mailLbl.text = oneContact.mail
            contactNameLbl.text = "\(oneContact.name + " " + oneContact.surname)"
            //contactImage.image = oneContact.image.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
