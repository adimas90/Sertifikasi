//
//  ProfileView.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ProfileView: View {
    @AppStorage("log_status") var log_status = true
    var body: some View {
        NavigationView{
            Form{
                
//                Section(header: Text("")){
//
//                }
                
                
                
                Section(header: Text("")){
                    Button(action: {
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        withAnimation{
                            log_status = false
                            
                        }
                    }){
                        HStack(alignment:.center){
                            Spacer()
                            HStack{
                    
        //                                .fixedSize(horizontalvertical: 20)
                                Text("Keluar").bold()
                            }
                            
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            
                            Spacer()
                               
                        }.padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                }
            }.navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
