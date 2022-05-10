//
//  ContentView.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
 
struct ContentView: View {
     
    @StateObject var viewModel = BooksViewModel()
    @State var presentAddBookSheet = false
     
    private var addButton: some View {
      Button(action: { self.presentAddBookSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func bookRowView(book: Book) -> some View {
      NavigationLink(destination: BookDetailsView(book: book)) {
        VStack(alignment: .leading) {
            HStack {
                AnimatedImage(url: URL(string: book.foto
                                      )).resizable().frame(width: 65, height: 65).clipShape(Circle())
                 
                VStack(alignment: .leading, spacing: 10) {
                    Text(book.judul_buku)
                        .fontWeight(.bold)
                    Text(book.pengarang)
                }
            }
        }
      }
    }
     
    var body: some View {
      NavigationView {
          
        List {
          ForEach (viewModel.books) { book in
              bookRowView(book: book)
          }
          .onDelete() { indexSet in
            viewModel.removeBooks(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("List Buku")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("BooksListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddBookSheet) {
          BookEditView()
        }
      }
    }
  }
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
