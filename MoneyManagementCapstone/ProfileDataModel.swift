//
//  ProfileDataModel.swift
//  MoneyManagementCapstone
//
//  Created by user204344 on 4/15/22.
//

import Foundation

class ProfileDataModel {
    
    var email_address:String
    var first_name:String
    var last_name:String
    var profile_image_url:String
    
    init(email_address: String, first_name: String,
         last_name: String, profile_image_url: String) {
        self.email_address = email_address
        self.first_name = first_name
        self.last_name = last_name
        self.profile_image_url = profile_image_url
    }
}
