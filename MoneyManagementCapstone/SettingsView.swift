//
//  SettingsView.swift
//  MoneyManagementCapstone
//
//  Created by user204344 on 4/8/22.
//

import SwiftUI

class ContentViewDelegate: ObservableObject {
    @Published var clickedItemType: String = ""
}

class DarkModeViewDelegate: ObservableObject {
    @Published var isDarkMode: Bool = false
}

struct SettingsView: View {
    
    @ObservedObject var delegate : ContentViewDelegate
    @ObservedObject var darkModeDelegate : DarkModeViewDelegate
    
    var body: some View {
        Form{
            Section(header: Text("Personal Settings")){
                Button(action: {
                    delegate.clickedItemType = "PersonalSettings"
                }){Text("My Profile")}
            }
            
            Section(header: Text("Action")){
                Toggle("Dark Mode", isOn:$darkModeDelegate.isDarkMode)
                Link("Privacy & Policy", destination: URL(string: "https://www.google.com")!)
                Button(action: {
                    delegate.clickedItemType = "LogOut"
                }){Text("Log Out")}
            }
            
            Section(header: Text("About")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                }
            }
        }
    }	
}
	
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(delegate: ContentViewDelegate(), darkModeDelegate: DarkModeViewDelegate())
    }
}
