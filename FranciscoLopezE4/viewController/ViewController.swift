//
//  ViewController.swift
//  FranciscoLopezE4
//
//  Created by Francisco Lopez on 2/7/18.
//  Copyright © 2018 Francisco Lopez. All rights reserved.
//

import UIKit
import FirebaseUI
import Kingfisher


class ViewController: UIViewController, FUIAuthDelegate {

    var authUI: FUIAuth?
    
    @IBOutlet weak var loginButton: UIButton!
 
    
    // revisamos si el usuario esta logueado y lo mandamos directamente al home
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toHome", sender: self)
            }else{
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 15
        
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()]
        self.authUI?.providers = providers
        
        if let currentUser = Auth.auth().currentUser {
           
            loginButton.setTitle("LOGIN", for: .normal)
        }
    }
    
    @IBAction func buttonTap(_ sender: Any) {
            if let authViewController = self.authUI?.authViewController() {
                present(authViewController, animated: true, completion: nil)
            }
        }
    }


