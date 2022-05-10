//
//  PeminjamViewModel.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import Foundation
import Combine
import FirebaseFirestore

class PeminjamViewModel: ObservableObject {
   
  @Published var identitas_peminjam: IdentitasPeminjam
  @Published var modifiedPeminjam = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(peminjam: IdentitasPeminjam = IdentitasPeminjam(nama_lengkap: "", no_telp: 0, alamat: "", judul: "", deskripsi: "", halaman: 0, pengarang: "", foto: "", tanggal_dipinjam: Date(), tanggal_kembali: Date())) {
    self.identitas_peminjam = peminjam
     
    self.$identitas_peminjam
      .dropFirst()
      .sink { [weak self] peminjam in
        self?.modifiedPeminjam = true
      }
      .store(in: &self.cancellables)
  }
   
  private var db = Firestore.firestore()
   
  private func addPeminjam(_ peminjam: IdentitasPeminjam) {
    do {
      let _ = try db.collection("identitas_peminjam").addDocument(from: peminjam)
    }
    catch {
      print(error)
    }
  }
   
  private func updatePeminjam(_ peminjam: IdentitasPeminjam) {
    if let documentId = peminjam.id {
      do {
        try db.collection("identitas_peminjam").document(documentId).setData(from: peminjam)
      }
      catch {
        print(error)
      }
    }
  }
    
    
    
   
    private func updateOrAddPeminjam(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
    if let _ = identitas_peminjam.id {
      self.updatePeminjam(self.identitas_peminjam)
    }
    else {
        do{
            
            
            let idBook = try db.collection("identitas_peminjam").addDocument(from: identitas_peminjam)
            idBook.setData([
                "nama_lengkap": nama_peminjam,
                "no_telp": Int(no_telp) ?? 0,
                "alamat": alamat,
                "judul":judul,
                "deskripsi":deskripsi,
                "pengarang":pengarang,
                "halaman": Int(halaman) ?? 0,
                "foto":foto,
                "tanggal_dipinjam": tanggal_dipinjam,
                "tanggal_kembali": tanggal_kembali,
            ])
        }catch{
            print(error)
        }
    }
  }
   
  private func removePeminjam() {
    if let documentId = identitas_peminjam.id {
      db.collection("identitas_peminjam").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
    func handleDoneTappedPeminjam(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
        self.updateOrAddPeminjam(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
  }
   
  func handleDeleteTappedPeminjam() {
    self.removePeminjam()
  }
   
}
