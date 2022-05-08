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
        Button(action: {
            GIDSignIn.sharedInstance.signOut()
            try? Auth.auth().signOut()
            withAnimation{
                log_status = false
            }
        }) {
            Text("Sign Out")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
