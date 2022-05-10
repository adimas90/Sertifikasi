//
//  RiwayatTransaksiViewModel.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 10/05/22.
//


import Foundation
import Combine
import FirebaseFirestore

class RiwayatTransaksiViewModel: ObservableObject {
   
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
   
  private func addRiwayat(_ users: IdentitasPeminjam) {
    do {
      let _ = try db.collection("riwayat_transaksi").addDocument(from: users)
    }
    catch {
      print(error)
    }
  }
   
  private func updateRiwayat(_ peminjam: IdentitasPeminjam) {
    if let documentId = peminjam.id {
      do {
        try db.collection("riwayat_transaksi").document(documentId).setData(from: peminjam)
      }
      catch {
        print(error)
      }
    }
  }
    
    
    
   
    private func updateOrAddRiwayat(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
    if let _ = identitas_peminjam.id {
      self.addRiwayat(self.identitas_peminjam)
    }
    else {
        do{
            
            
            let idBook = try db.collection("riwayat_transaksi").addDocument(from: identitas_peminjam)
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
                "tanggal_kembali": tanggal_kembali
            ])
        }catch{
            print(error)
        }
    }
  }
   
  private func removeRiwayat() {
    if let documentId = identitas_peminjam.id {
      db.collection("riwayat_transaksi").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
    func handleDoneTappedRiwayat(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
        self.updateOrAddRiwayat(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
  }
   
  func handleDeleteTappedRiwayat() {
    self.removeRiwayat()
  }
   
}

