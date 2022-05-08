//
//  ListBukuDipinjam.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI

import SwiftUI
import Firebase
import SDWebImageSwiftUI
 
struct ListBukuDipinjam: View {
     
    @StateObject var viewModelPeminjam = PeminjamsViewModel()
    @State var presentAddBookSheet = false
     
    private var addButton: some View {
      Button(action: { self.presentAddBookSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
     
    private func bookRowView(peminjam: IdentitasPeminjam) -> some View {
//      NavigationLink(destination: PeminjamDetaiView(peminjam: peminjam)) {
        VStack(alignment: .leading) {
            HStack {
                AnimatedImage(url: URL(string: peminjam.foto
                                      )).resizable().frame(width: 65, height: 65).clipShape(Circle())
                 
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading){
                        Text(peminjam.nama_lengkap)
                            .fontWeight(.bold)
                        Text(peminjam.alamat)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Pengarang: \(peminjam.judul)")
                            .fontWeight(.bold)
                        Text(peminjam.pengarang)
                        Text("Halaman : \(peminjam.halaman)")
                    }

                    
                    VStack(alignment: .leading) {
                        Text("Tanggal Pinjam: \(peminjam.tanggal_dipinjam, formatter: dateFormatter)")
                            .foregroundColor(Color.black)
                        Text("Tanggal Kembali: \(peminjam.tanggal_kembali, formatter: dateFormatter)")
                            .foregroundColor(Color.black)
                    }
    
                    
                }
                

            }
        }
//      }
    }
     
    var body: some View {
      NavigationView {
          
        List {
            ForEach (viewModelPeminjam.identitas_peminjams) { peminjam in
              bookRowView(peminjam: peminjam)
          }
          .onDelete() { indexSet in
            viewModelPeminjam.removeBooks(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("List Buku")
        
        .onAppear() {
          print("BooksListView appears. Subscribing to data updates.")
          self.viewModelPeminjam.subscribePeminjam()
        }
      }
    }
  }
 
struct ListBukuDipinjam_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

