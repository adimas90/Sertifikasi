//
//  TabViewController.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI

struct TabViewController: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Text("Katalog")
                }
            ListBukuDipinjam()
                .tabItem {
                    Text("Pinjaman")
                }
            
            ProfileView()
                .tabItem {
                    Text("Profil")
                }
        }
    }
}

struct TabViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
