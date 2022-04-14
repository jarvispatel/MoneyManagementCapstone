//
//  ContentView.swift
//  MoneyManagementCapstone
//
//Created by Rutvik
import SwiftUI

class ContentView: UIViewController{
    

struct  ContentView: View {
    
    @State var email = ""
    var body: some View{
        NavigationView{
            
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            
          VStack{
                    TextField("Email Address", text: $email).padding()
                    SecureField("EMail Address",text:$email)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                        
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Sign In")
        }
    }
}


}
