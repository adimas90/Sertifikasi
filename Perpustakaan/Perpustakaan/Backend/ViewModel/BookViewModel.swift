//
//  BookViewModel.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import Foundation
import Combine
import FirebaseFirestore
 
class BookViewModel: ObservableObject {
   
  @Published var book: Book
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(book: Book = Book(judul_buku: "", deskripsi: "", pengarang: "", halaman: 0, foto: "", status: true)) {
    self.book = book
     
    self.$book
      .dropFirst()
      .sink { [weak self] book in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addBook(_ book: Book) {
    do {
      let _ = try db.collection("buku").addDocument(from: book)
    }
    catch {
      print(error)
    }
  }
   
  private func updateBook(_ book: Book) {
    if let documentId = book.id {
      do {
        try db.collection("buku").document(documentId).setData(from: book)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddBook() {
    if let _ = book.id {
      self.updateBook(self.book)
    }
    else {
        do{
            
            let idBook = try db.collection("buku").addDocument(from: book)
            idBook.setData([
                "judul_buku": book.judul_buku,
                "deskripsi": book.deskripsi,
                "pengarang": book.pengarang,
                "halaman": 2000,
                "foto": book.foto,
                "status": true
                
              
            ])
        }catch{
            print(error)
        }
    }
  }
   
  private func removeBook() {
    if let documentId = book.id {
      db.collection("buku").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  func handleDoneTapped() {
    self.updateOrAddBook()
  }
   
  func handleDeleteTapped() {
    self.removeBook()
  }
   
}
