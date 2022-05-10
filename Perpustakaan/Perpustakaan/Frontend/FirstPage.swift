//
//  FirstPage.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 08/05/22.
//

import SwiftUI

struct FirstPage: View {
    @AppStorage("log_status") var log_status = false
    var body: some View {
        if log_status{
            TabViewController()
        }else{
            LoginPage()
        }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
