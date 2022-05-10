//
//  PeminjamsViewModel.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore
 
class PeminjamsViewModel: ObservableObject {
  @Published var identitas_peminjams = [IdentitasPeminjam]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribePeminjam()
  }
   
  func unsubscribePeminjam() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribePeminjam() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("transaksi_pinjam").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.identitas_peminjams = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: IdentitasPeminjam.self)
        }
      }
    }
  }
   
  func removeBooks(atOffsets indexSet: IndexSet) {
    let books = indexSet.lazy.map { self.identitas_peminjams[$0] }
    books.forEach { book in
      if let documentId = book.id {
        db.collection("transaksi_pinjam").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}

