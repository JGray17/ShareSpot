//
//  SwiftUIView.swift
//  ShareSpot
//
//  Created by Joshua Gray on 4/8/21.
//

import UIKit

class SwiftUIView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func importImage (_ sender: AnyObject){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){}
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        var image: UIImage!
        image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        myImage.image = image
        //}
        
        //else {
            //Print Error
        //}
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



