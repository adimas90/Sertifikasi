//
//  UserViewModel.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 10/05/22.
//


import Foundation
import Combine
import FirebaseFirestore

class UserViewModel: ObservableObject {
   
  @Published var identitas_peminjam: IdentitasPeminjam
  @Published var modifiedUser = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(users: IdentitasPeminjam = IdentitasPeminjam(nama_lengkap: "", no_telp: 0, alamat: "", judul: "", deskripsi: "", halaman: 0, pengarang: "", foto: "", tanggal_dipinjam: Date(), tanggal_kembali: Date())) {
    self.identitas_peminjam = users
     
    self.$identitas_peminjam
      .dropFirst()
      .sink { [weak self] users in
        self?.modifiedUser = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addUser(_ users: IdentitasPeminjam) {
    do {
      let _ = try db.collection("users").addDocument(from: users)
    }
    catch {
      print(error)
    }
  }
   
  private func updateUsers(_ peminjam: IdentitasPeminjam) {
    if let documentId = peminjam.id {
      do {
        try db.collection("users").document(documentId).setData(from: peminjam)
      }
      catch {
        print(error)
      }
    }
  }
    
    
    
   
    private func updateOrAddUsers(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
    if let _ = identitas_peminjam.id {
      self.updateUsers(self.identitas_peminjam)
    }
    else {
        do{
            
            
            let idBook = try db.collection("users").addDocument(from: identitas_peminjam)
            idBook.setData([
                "nama_lengkap": nama_peminjam,
                "no_telp": Int(no_telp) ?? 0,
                "alamat": alamat
            ])
        }catch{
            print(error)
        }
    }
  }
   
  private func removeUsers() {
    if let documentId = identitas_peminjam.id {
      db.collection("users").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
    func handleDoneTappedUsers(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
        self.updateOrAddUsers(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
  }
   
  func handleDeleteTappedPeminjam() {
    self.removeUsers()
  }
   
}
