//
//  SettingsViewController.swift
//  MoneyManagementCapstone
//
//  Created by user204344 on 4/8/22.
//

import UIKit
import SwiftUI
import Combine
import Firebase

class SettingsViewController: UIViewController {
    	
    private var cancellable: AnyCancellable!
    private var darkModecancellable: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = ContentViewDelegate()
        let darkModeDelegate = DarkModeViewDelegate()
        
        let controller = UIHostingController(rootView: SettingsView(delegate: delegate, darkModeDelegate: darkModeDelegate))
        
        addChild(controller)
        view.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        controller.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
        self.cancellable = delegate.$clickedItemType.sink { clickedItem in
            if clickedItem == "PersonalSettings" {
                let level2VC = self.storyboard?.instantiateViewController(identifier: "profile_screen") as! ProfileViewController
                level2VC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(level2VC, animated: true)
            } else if clickedItem == "LogOut" {
                let firebaseAuth = Auth.auth()
                   do {
                     try firebaseAuth.signOut()
                   } catch let signOutError as NSError {
                     print("Error signing out: %@", signOutError)
                   }
            }
        }
        
        self.darkModecancellable = darkModeDelegate.$isDarkMode.sink{ isDarkModeOn in
            
            let window = UIApplication.shared.windows[0]
            
            if isDarkModeOn {
                window.overrideUserInterfaceStyle = .dark
            }else{
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
}
