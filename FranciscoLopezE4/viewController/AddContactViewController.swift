//
//  AddContactViewController.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 4/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import Kingfisher



class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FUIAuthDelegate{
    
    //definimos la var REF
    var storageRef: StorageReference!
    var ref: DatabaseReference!
    var contactDict: Contact?
    
    
    @IBOutlet weak var phoneTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var surnameTxtFld: UITextField!
    @IBOutlet weak var mailTxtFld: UITextField!
    @IBOutlet weak var companyTxtFld: UITextField!
    
    
    @IBAction func saveBtn(_ sender: Any) {
        if let userID = Auth.auth().currentUser?.uid{
            if let contactName = nameTxtFld.text, let contactSurname = surnameTxtFld.text, let contactMail = mailTxtFld.text, let contactCompany = companyTxtFld.text, let contactPhone = phoneTxtFld.text{
            
        self.ref.child(userID).child(contactName + " " + contactSurname).child("name").setValue(contactName)
        self.ref.child(userID).child(contactName + " " + contactSurname).child("surname").setValue(contactSurname)
        self.ref.child(userID).child(contactName + " " + contactSurname).child("mail").setValue(contactMail)
        self.ref.child(userID).child(contactName + " " + contactSurname).child("company").setValue(contactCompany)
        self.ref.child(userID).child(contactName + " " + contactSurname).child("phone").setValue(contactPhone)
      //  self.ref.child(userID).child(contactName + " " + contactSurname).child("image").setValue(contactImage)
           
            }
            dismiss(animated: true, completion: nil)
        }
    }
    

    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBAction func galeryButtonTapp(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ref database
        ref = Database.database().reference().child("contacts")
        
        //ref storage
        storageRef = Storage.storage().reference()
        readFromStorage()
        
    }
    
    //     leemos el storage de las fotos
    func readFromStorage(){
        if let contactName = nameTxtFld.text, let contactSurname = surnameTxtFld.text{
            let imageRef = storageRef.child("\(contactName+contactSurname+".jpg")")
            imageRef.getData(maxSize: 1 * 1024 * 1024) {(data, error) in
                if let dataValue = data {
                    let theImage = UIImage(data: dataValue)
                    self.contactImageView.image = theImage
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            contactImageView.image = image
            if let contactName = nameTxtFld.text, let contactSurname = surnameTxtFld.text{
                let imageRef = storageRef.child("\(contactName+contactSurname+".jpg")")

                if let imageDataJPEG = UIImageJPEGRepresentation(image, 0.5){
                    imageRef.putData(imageDataJPEG)
                }
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
