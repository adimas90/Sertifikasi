//
//  Book.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Book: Identifiable, Codable {
  @DocumentID var id: String?
  var judul_buku: String
  var deskripsi: String
  var pengarang: String
  var halaman: Int
  var foto: String
  var status: Bool
 
   
  enum CodingKeys: String, CodingKey {
    case id
    case judul_buku
    case deskripsi
    case pengarang
    case halaman 
    case foto
    case status
    
  }
}
