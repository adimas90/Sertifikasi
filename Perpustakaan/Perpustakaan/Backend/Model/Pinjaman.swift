//
//  Pinjaman.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Pinjaman: Identifiable, Codable {
  @DocumentID var id: String?
    var identitas_peminjam : [IdentitasPeminjam]?
    var identitas_buku : [Book]?
    var tanggal_dipinjam: Date
    var tanggal_kembali: Date
   
  enum CodingKeys: String, CodingKey {
    case id
    case identitas_peminjam
    case tanggal_dipinjam
    case tanggal_kembali
  }
}
