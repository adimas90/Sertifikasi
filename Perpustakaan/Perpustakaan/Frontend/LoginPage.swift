//
//  LoginPage.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPage: View {
    // loading
    @State var isLoading: Bool = false
    @AppStorage("log_status") var log_status = false
    var body: some View {
        VStack{
            Image("onboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: getRect().height/3)
                .background(
                    Circle()
                        .fill(Color("brown"))
                        .scaleEffect(3)
                
                )
            
            VStack(spacing: 20){
                Text("Peminjaman buku yang mudah dan cepat dengan sebuah aplikasi")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.8))
                    .kerning(1.1)
//                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button{
                    handleLogin()
                } label: {
                    HStack(spacing: 15){
                        Image("google")
                            .resizable()
                            .frame(width: 20, height: 20)
                            
                            
                        Text("Masuk dengan Google")
                            .fontWeight(.medium)
                            .font(.title3)
                            .kerning(1.1)
                            
                        
                    }.foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Capsule().strokeBorder(Color.gray, lineWidth: 0.5)
                                        
                        
                        ).background(Color.white)
                        .cornerRadius(28)
                        
                    
                }
                
                Spacer()
                
                Text(getAttributedString(string:"Dengan membuat akun, kamu menyetujui kebijakan layanan kami"))
                    .font(.body.bold())
                    .foregroundColor(.gray)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .padding(.top, 30)
            //
        }
        .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment: .top)
        .overlay(
            ZStack{
                if isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
    }
    func getAttributedString(string: String) -> AttributedString{
        var attributedString = AttributedString(string)
        if let range = attributedString.range(of: "kebijakan layanan kami"){
            attributedString[range].foregroundColor = .black
            attributedString[range].font = .body.bold()
        
        }
        return attributedString
    }
    
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [self] user, err in
            if let error = err {
                isLoading = false
                // ...
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                  isLoading = false
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential){ result, err in
                isLoading = false
                if let error = err {
                    // ...
                    return
                  }
                guard let user = result?.user else{
                    return
                }
                print(user.displayName ?? "success")
                withAnimation {
                    log_status = true
                }
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
    // retrieving
    
    func getRootViewController() -> UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
