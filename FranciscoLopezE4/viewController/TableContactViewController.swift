//
//  HomeViewViewController.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 3/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import UIKit
import FirebaseUI
import Kingfisher


class TableContactViewController: UIViewController, FUIAuthDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // ========== Outlet ==============
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var logOut: UIBarButtonItem!
    
    // ============= VAR ===========
        var ref: DatabaseReference!
        var storageRef: StorageReference!
        var contactArray: [Contact] = []
    
    //
    
    
    //MARK:- LOGOUT
    // ========== LogOut ==================
    @IBAction func logOutTap(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            // hay que hacer logout
            do {
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            } catch {}
        } else {}
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // base de datos
        ref = Database.database().reference()
        
        //Almacenamiento de imagenes 
        storageRef = Storage.storage().reference()
       
        if let userLogged = Auth.auth().currentUser {
            userNameLbl.text = userLogged.displayName
            UserImageView.kf.setImage(with: userLogged.photoURL, placeholder: #imageLiteral(resourceName: "contact"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        readFromDB()
        
        self.tableView.reloadData()
    }

    
        // =========  aca leemos de la DB. ver como hacer para mostrar en la TABLEVIEW! ==========

    func readFromDB(){
        // if let userID = Auth.auth().currentUser?.uid{
        ref.child("contacts").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let values = snapshot.value as? NSDictionary{
                if let arrayContacts = values.allValues as? [[String:AnyObject]] {
                    print("\(arrayContacts)")
                    for item in arrayContacts{
                        let newContact = Contact(dictionary: item)
                        self.contactArray.append(newContact)
                    }
                    self.tableView.reloadData()
                }
            }
        })
    }


    
    // ========= Respuesta del singin ===== con esto se imprime el nombre y la foto del usuario.
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        userNameLbl.text = user?.displayName
        UserImageView.kf.setImage(with: user?.photoURL)
    }

    
    // ==== modelamos la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let item = contactArray[indexPath.row]
        if let contactCell = cell as? ContactTableViewCell{
            contactCell.setup(contact: item)
        }
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ContactDetailViewController{
            if let selectedRow = tableView.indexPathForSelectedRow {
                let selectedContact = contactArray[selectedRow.row]
                destination.myContact = selectedContact
            }
        }
    }
}
