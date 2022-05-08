//
//  IdentitasUser.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct IdentitasPeminjam: Identifiable, Codable {
  @DocumentID var id: String?
  var nama_lengkap: String
  var no_telp: Int
  var alamat: String
  var judul: String
    var deskripsi: String
    var halaman: Int
    var pengarang: String
    var foto: String
    var tanggal_dipinjam: Date
    var tanggal_kembali: Date
   
  enum CodingKeys: String, CodingKey {
    case id
    case nama_lengkap
    case no_telp
    case alamat
      case judul
      case deskripsi
      case halaman
      case pengarang
      case foto
      case tanggal_dipinjam
      case tanggal_kembali
  }
}
