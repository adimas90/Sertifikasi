//
//  PinjamAddView.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI
import SDWebImageSwiftUI
 
enum Moder {
  case new
  case edit
}
 
enum Actionr {
  case delete
  case done
  case cancel
}
 
struct PinjamAddView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
  @State var nama_peminjam:String = ""
  @State var alamat:String = ""
  @State var no_telp:String = ""
    @State var tanggal_dipinjam = Date()
    @State var tanggal_kembali = Date().addingTimeInterval(604800)
 
   
  @ObservedObject var viewModel = BookViewModel()
  @ObservedObject var viewModelPeminjam = PeminjamViewModel()
    @ObservedObject var viewModelUsers = UserViewModel()
    @ObservedObject var viewModelRiwayat = RiwayatTransaksiViewModel()
  var mode: Moder = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
      Button(action: {
          self.handleCancelTapped()
          
      }) {
      Text("Batal")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTappedPeminjam(nama_peminjam: Nama(), no_telp: NoTelp(), alamat: Alamat(), judul: Judul(), deskripsi: Deskripsi(), halaman: Halaman(), pengarang: Pengarang() , foto: Foto(), tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali )
        
    }) {
      Text(mode == .new ? "Selesai" : "Simpan")
    }
//    .disabled(!viewModel.modified)
  }
    
    
    
    

    
    
    func getNama(value: String) -> String{

        return String(value)
    }
    
    func Nama() -> String {
        var judul : String = ""
        
        judul = nama_peminjam
        
        return getNama(value: judul)
        
    }
    
    
    func getAlamat(value: String) -> String{

        return String(value)
    }
    
    func Alamat() -> String {
        var judul : String = ""
        
        judul = alamat
        
        return getNama(value: judul)
        
    }
    
    
    
    func getNoTelp(value: String) -> String{

        return String(value)
    }
    
    func NoTelp() -> String {
        var judul : String = ""
        
        judul = no_telp
        
        return getNoTelp(value: judul)
        
    }
    

    
    
    
    func getJudul(value: String) -> String{

        return String(value)
    }
    
    func Judul() -> String {
        var judul : String = ""
        
        judul = viewModel.book.judul_buku
        
        return getJudul(value: judul)
        
    }
    
    
    
    
    func getDeskripsi(value: String) -> String{

        return String(value)
    }
    
    func Deskripsi() -> String {
        var judul : String = ""
        
        judul = viewModel.book.deskripsi
        
        return getDeskripsi(value: judul)
        
    }
    
    func getHalaman(value: String) -> String{

        return String(value)
    }
    
    func Halaman() -> String {
        var judul : String = ""
        
        judul = String("\(viewModel.book.halaman)")
        
        return getNama(value: judul)
        
    }
    
    
    
    func getFoto(value: String) -> String{

        return String(value)
    }
    
    func Foto() -> String {
        var judul : String = ""
        
        judul = viewModel.book.foto
        
        return getFoto(value: judul)
        
    }
    
    func getPengarang(value: String) -> String{

        return String(value)
    }
    
    func Pengarang() -> String {
        var judul : String = ""
        
        judul = viewModel.book.pengarang
        
        return getFoto(value: judul)
        
    }
    

    
//    func getHalaman(value: Int) -> String{
//
//        return String(value)
//    }
//
//    func Halaman() -> String {
//        var judul : Int = 0
//
//        judul = viewModel.book.halaman
//
//        return getFoto(value: judul)
//
//    }
    
//    func exampleDates() {
//        // create a second Date instance set to one day in seconds from now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//
//        // create a range from those two
//        let range = Date.now...tomorrow
//    }
    
    
  var body: some View {
    NavigationView {
      Form {
          
          Section(header: Text("Nama")) {
            TextField("Nama", text: $nama_peminjam)
                  .disableAutocorrection(true)
          }
          
          Section(header: Text("Alamat")) {
            TextField("Alamat", text: $alamat)
                  .disableAutocorrection(true)
          }
          
          Section(header: Text("Nomor Telfon")) {
            TextField("Nomor Telfon", text: $no_telp)
                  .disableAutocorrection(true)
          }
          
          Section(header: Text("Tanggal Pinjam")) {
              DatePicker("Dipinjam", selection: $tanggal_dipinjam, in: ...Date() , displayedComponents: .date)
          }.disabled(true)
          
          Section(header: Text("Tanggal Kembali")) {
              DatePicker("Kembali", selection: $tanggal_kembali, in: Date()... , displayedComponents: .date)
          }.disabled(true)

          
          
        
        Section(header: Text("Judul Buku")) {
          TextField("Judul Buku", text: $viewModel.book.judul_buku)
                .disableAutocorrection(true)
                .disabled(true)
        }
          
          Section(header: Text("Deskripsi Buku")) {
              TextEditor(text: $viewModel.book.deskripsi)
                    .disableAutocorrection(true)
                    .disabled(true)
          }
          
        
          
          Section(header: Text("Jumlah Halaman")) {
            TextField("Jumlah Halaman", value: $viewModel.book.halaman, formatter: NumberFormatter())
                  .disableAutocorrection(true)
                  .disabled(true)
          }
         
        Section(header: Text("Pengarang")) {
          TextField("Pengarang", text: $viewModel.book.pengarang)
                .disableAutocorrection(true)
                .disabled(true)
        }
 
        Section(header: Text("Foto Buku")) {
            AnimatedImage(url: URL(string: viewModel.book.foto)).resizable().frame(width: 300, height: 300)
        }
        
      }
      .navigationTitle(mode == .new ? "Tambah Buku" : viewModel.book.judul_buku)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
        ActionSheet(title: Text("Apakah kamu yakin?"),
                    buttons: [
                      .destructive(Text("Hapus Buku"),
                                   action: { self.handleDeleteTapped() }),
                      .cancel()
                    ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
    func handleDoneTappedPeminjam(nama_peminjam: String, no_telp: String, alamat: String, judul: String, deskripsi: String, halaman: String, pengarang: String, foto: String, tanggal_dipinjam: Date, tanggal_kembali: Date) {
        
        self.viewModelPeminjam.handleDoneTappedPeminjam(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
        
        self.viewModelUsers.handleDoneTappedUsers(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
        
        self.viewModelRiwayat.handleDoneTappedRiwayat(nama_peminjam: nama_peminjam, no_telp: no_telp, alamat: alamat, judul: judul, deskripsi: deskripsi, halaman: halaman, pengarang: pengarang, foto: foto, tanggal_dipinjam: tanggal_dipinjam, tanggal_kembali: tanggal_kembali)
        
    self.dismiss()
  }
    
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct PinjamAddView_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(judul_buku: "", deskripsi: "", pengarang: "", halaman: 0, foto: "", status: true)
    let bookViewModel = BookViewModel(book: book)
    return PinjamAddView(viewModel: bookViewModel, mode: .edit)
  }
}
