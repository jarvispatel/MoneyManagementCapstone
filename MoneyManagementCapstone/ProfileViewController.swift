//
//  ProfileViewController.swift
//  MoneyManagementCapstone
//
//  Created by user204344 on 4/8/22.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    private let storage = Storage.storage().reference()
    
    var isEditingEnable: Bool = false
    
    var profileImageUrl: String = ""
    
//    fileprivate var aView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        ref = Database.database().reference()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
        editProfileButton.layer.cornerRadius = 10
        
        fetchProfileData(userId: "dsfuiybs4sus5")
        
        changeEditable(isEditable: false)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            profileImageView.isUserInteractionEnabled = true
            profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if isEditingEnable {
            presentPhotoActionSheet()
        }
    }
    
    @IBOutlet weak var editProfileBtn: UIButton!
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present (vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present (vc, animated: true)
    }
    
    func changeEditable(isEditable: Bool) {
        isEditingEnable = isEditable
        
        if isEditable {
            firstName.isUserInteractionEnabled = true
            lastName.isUserInteractionEnabled = true
            emailAddress.isUserInteractionEnabled = true
            editIcon.alpha = 1
            editProfileBtn.setTitle("SAVE PROFILE", for: .normal)
        } else {
            firstName.isUserInteractionEnabled = false
            lastName.isUserInteractionEnabled = false
            emailAddress.isUserInteractionEnabled = false
            editIcon.alpha = 0
            editProfileBtn.setTitle("EDIT PROFILE", for: .normal)
        }
    }
    
    func updateProfileData(userId : String){
        self.showSpinner(onView: self.view)
        
        var values = ["first_name": firstName.text,
                    "email_address": emailAddress.text,
                    "last_name": lastName.text]
        if !profileImageUrl.isEmpty {
            values["profile_image_url"] = profileImageUrl
        }
        
        ref.child("Users/\(userId)").updateChildValues(values as [AnyHashable : Any], withCompletionBlock: { (error, snapshot) in
                if error != nil {
                    print("oops, an error")
                } else {
                    print("completed")
                }
            self.removeSpinner()
            })
    }
    
    @objc func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBOutlet weak var editIcon: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBAction func touchUpInsideEditProfile(_ sender: UIButton) {
        if isEditingEnable{
            updateProfileData(userId: "dsfuiybs4sus5")
        }
        
        isEditingEnable = !isEditingEnable
        changeEditable(isEditable: isEditingEnable)
    }
    
  /*  func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.color = .blue
        ai.center = aView!.center
        ai.startAnimating()
        
        DispatchQueue.main.async {
            self.aView?.addSubview(ai)
            self.view.addSubview(self.aView!)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.aView?.removeFromSuperview()
            self.aView = nil
               }
    }
 */
    
    func fetchProfileData(userId : String){
        
        self.showSpinner(onView: self.view)
        
        ref.child("Users/\(userId)").getData(completion:  { error, snapshot in
            
            self.removeSpinner()
            
            guard error == nil else {print(error!.localizedDescription)
                return;
            }
            
            let value = snapshot.value as? NSDictionary
            let email_address = value?["email_address"] as? String ?? ""
            let first_name = value?["first_name"] as? String ?? ""
            let last_name = value?["last_name"] as? String ?? ""
            let profile_image_url = value?["profile_image_url"] as? String ?? ""
            
            self.firstName.text = first_name
            self.lastName.text = last_name
            self.emailAddress.text = email_address
            
            do {
                let url = URL(string: profile_image_url)
                let data = try Data(contentsOf: url!)
                self.profileImageView.image = UIImage(data: data)
                self.profileImageUrl = profile_image_url
            }catch{
                print(error)
            }
        });
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle:.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { (UIAlertAction) in
                                                self.presentCamera()
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { (UIAlertAction) in
                                              self.presentPhotoPicker()
                                            }))
        present(actionSheet, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else {return}
        
        guard let imageData = selectedImage.pngData() else {return}
        
        self.showSpinner(onView: self.view)
        
        storage.child("images/\(fileUrl.lastPathComponent)").putData(imageData, metadata: nil, completion: {_, error in
            
            guard error == nil else {
                self.removeSpinner()
                print("Failed to upload")
                return
            }
            
            self.profileImageView.image = selectedImage
            
            self.storage.child("images/\(fileUrl.lastPathComponent)").downloadURL(completion: { url, error in
                
                self.removeSpinner()
                
                guard let url = url, error == nil else { return }
                self.profileImageUrl = url.absoluteString
            })
        })
    }
}
