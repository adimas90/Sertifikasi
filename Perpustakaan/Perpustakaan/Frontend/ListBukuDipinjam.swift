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
                 
                VStack(alignment: .leading, spacing: 15) {
                    
                    Spacer()
                    
                    
                    Text(">> Detail Peminjaman :")
                        .font(.title3)
                        .foregroundColor(.black)
                        .bold()
                    
                    
                    AnimatedImage(url: URL(string: peminjam.foto)).resizable().frame(width: 300, height: 200)
                    
                    Text("Identitas Peminjam :")
                        .bold()
                        .foregroundColor(Color.green)
                    
                    
                    VStack(alignment: .leading){
                        Text(peminjam.nama_lengkap)
                            .fontWeight(.bold)
                        Text(peminjam.alamat)
                    }
                    
                    
                    
                    Text("info Buku :")
                        .bold()
                        .foregroundColor(Color.green)
                    
                    VStack(alignment: .leading, spacing: 7){
                        Text("\(peminjam.judul)")
                            .fontWeight(.bold)
                        Text(peminjam.pengarang)
                        Text("\(peminjam.halaman) Halaman")
                    }
                    
                    
                    
                    Text("Tanggal :")
                        .bold()
                        .foregroundColor(Color.green)
                    
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Tanggal Pinjam: \(peminjam.tanggal_dipinjam, formatter: dateFormatter)")
                        
                        Text("Tanggal Kembali: \(peminjam.tanggal_kembali, formatter: dateFormatter)")
                        
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
        .navigationBarTitle("List Buku Dipinjam")
        
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

