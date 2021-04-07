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
        
        imageView.backgroundColor = .secondarySystemBackground
        button.backgroundColor = .systemGray
        button.setTitle("Take Picture", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        // [END_EXCLUDE]
      }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

}

extension ViewController: UIImagePickerControllerDelegate,
                         UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
                return
            }
        
        imageView.image = image
    }
  

}

