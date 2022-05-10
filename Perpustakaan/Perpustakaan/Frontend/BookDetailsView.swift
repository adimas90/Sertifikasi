//
//  BookDetailsView.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import SwiftUI
import SDWebImageSwiftUI
 
struct BookDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
  @State var presentPinjamBookSheet = false
   
  var book: Book
//  var peminjam: IdentitasPeminjam
//  var peminjam: IdentitasPeminjam
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
    private func addButtonPinjam(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Pinjam Buku Ini")
      }
    }
   
  var body: some View {
    Form {
      Section(header: Text("Judul Buku")) {
            Text(book.judul_buku)
        }
        
      Section(header: Text("Deskripsi buku")) {
            Text(book.deskripsi)
      }
        Section(header: Text("Jumlah halaman")) {
          Text("\(book.halaman) halaman")
        }
       
      Section(header: Text("Pengarang")) {
        Text(book.pengarang)
      }
      Section(header: Text("Foto Buku")) {
          AnimatedImage(url: URL(string: book.foto)).resizable().frame(width: 300, height: 300)
      }
        Section() {
            Button(action: {
                self.presentPinjamBookSheet.toggle()
            }){
                HStack(alignment:.center){
                    Spacer()
                    HStack{
            
//                                .fixedSize(horizontalvertical: 20)
                        Text("Pinjam Buku Ini").bold()
                    }
                    
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                       
                }.padding()
                    .background(Color.green)
                    .cornerRadius(15)
            }

        }
    }
      
    .navigationBarTitle("Info Buku")
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.book.judul_buku)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      BookEditView(viewModel: BookViewModel(book: book), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
    
    
      }
    }
    .sheet(isPresented: self.$presentPinjamBookSheet) {
        PinjamAddView(
//            viewModelPinjam: PeminjamViewModel(),
            viewModel: BookViewModel(book:book), mode: .edit) { result in
            if case .success(let action) = result, action == .delete {
              self.presentationMode.wrappedValue.dismiss()
            }
        }
        }
  }
}
 
struct BookDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(judul_buku: "", deskripsi: "", pengarang: "", halaman: 0, foto: "", status: true)
//      let peminjam = IdentitasPeminjam(nama_lengkap: "", no_telp: 0, alamat: "")
    return
      NavigationView {
        BookDetailsView(book: book)
      }
  }
}
