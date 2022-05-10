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
                    Image(systemName: "books.vertical")
                    Text("Katalog")
                }
            ListBukuDipinjam()
                .tabItem {
                    Image(systemName: "arrow.up.doc.on.clipboard")
                    Text("Pinjaman")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
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
