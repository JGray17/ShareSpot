//
//  ViewController.swift
//  testing
//
//  Created by Joshua Gray on 3/25/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self

            // Automatically sign in the user.
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()


    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        // [END_EXCLUDE]
      }

}

