//
//  NewBookViewController.swift
//  BookApp
//
//  Created by YeouTimothy on 2016/7/22.
//  Copyright © 2016年 YeouTimothy. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class NewBookViewController: UIViewController {
    
    var imageData:NSData?
    var downloadUrl:NSURL?
    
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var summaryTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var webTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func choosePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var imageYouChoose: UIImageView!
    
    @IBAction func saveAction(sender: AnyObject) {
        let dataRef = FIRDatabase.database().reference()
//        let bookPath = dataRef.child("Book").childByAutoId().key
        
        if nameTextField.text != nil && locationTextField.text != nil && publisherTextField.text != nil && phoneTextField.text != nil && webTextField.text != nil && downloadUrl != nil{
            var saveContentDict = [String:String]()
//            let saveContent = ["name": nameTextField.text, "publisherGlocation": locationTextField.text,"publisherPhone": phoneTextField.text,"bookUrl": webTextField.text, "publisher": publisherTextField.text, "photoUrl": String(downloadUrl!)]
            saveContentDict["name"] = nameTextField.text
            saveContentDict["publisherGlocation"] = locationTextField.text
            saveContentDict["publisherPhone"] = phoneTextField.text
            saveContentDict["bookUrl"] = webTextField.text
            saveContentDict["publisher"] = publisherTextField.text
            saveContentDict["photoUrl"] = String(downloadUrl!)
            dataRef.child("Book").child("0").setValue(["here": "test"])
        
            dataRef.child("Book").childByAutoId().setValue(saveContentDict)
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func addFromLibary(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let storage = FIRStorage.storage()
//        let storageRef = storage.referenceForURL("gs://joinme2theparty.appspot.com")
//        let profilePicRef = storageRef.child(user.uid + "/profile.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewBookViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageData = UIImagePNGRepresentation(image)
        imageYouChoose.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        
        
        let storageRef = FIRStorage.storage().reference()
        let bookRef = storageRef.child("\(nameTextField.text)/book.jpg")
        _ = bookRef.putData(imageData!, metadata: nil, completion: {
            (metadata, error) in
            if error != nil{
                print("upload error!")
            }else{
                self.downloadUrl = metadata?.downloadURL()
                print(self.downloadUrl)
                print(String(self.downloadUrl!))
                }
        })

    }
    
}


