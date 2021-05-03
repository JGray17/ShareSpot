//
//  ViewController.swift
//  testing
//
//  Created by Joshua Gray on 3/25/21.
//

import UIKit
import GoogleSignIn
import FirebaseStorage


class ViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    let delegate = UIApplication.shared.delegate as! AppDelegate
    var userID = String()
    @IBOutlet var signInButton: GIDSignInButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var label: UILabel?
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIREBASE PICTURE STUFF
        label?.numberOfLines = 0
        label?.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String, let url = URL(string: urlString) else { return }
        
        print("email as seen in viewcontroller = \(delegate.userEmail)")
        let components = delegate.userEmail.components(separatedBy: "@")
        userID = components[0]
        
        var link_split = urlString.components(separatedBy: "/o/")
        var initUserID = link_split[1]
        link_split = initUserID.components(separatedBy: "%")
        initUserID = link_split[0]
        
        label?.text = "Image posted by " + initUserID + ".\nFind the image at:\n" + urlString
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async{
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        })
        
        task.resume()
        // END FIREBASE STUFF
        
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
    }
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func didTapUploadButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{ return }
        
        guard let imageData = image.pngData() else{ return }
        
        // upload image data, get download URL, save download URL to userdefaults
        storage.child("\(self.userID)/file.png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storage.child("\(self.userID)/file.png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                
                DispatchQueue.main.async{
                    self.label?.text = "Image posted by " + self.userID + ".\nFind the image at:\n" + urlString
                    self.imageView.image = image
                }
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.setValue(urlString, forKey: "url")
            })
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }

}


