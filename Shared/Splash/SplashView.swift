//
//  SplashView.swift
//  Shared
//
//  Created by mac on 2022/10/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    let login = SigninView()
    
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 86/255, green: 183/255, blue: 230/255), Color(red: 121/255, green: 211/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom)
    let containerWidth:CGFloat = UIScreen.main.bounds.width
    let containerHeight:CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center)
                {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.55 * containerWidth)
                    HStack(alignment: .center)
                    {
                        Image("Letter_o")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.183 * containerWidth)
                        Image("Letter_r")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.13 * containerWidth)
                        Image("Letter_o")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.183 * containerWidth)
                    }
                    .padding(EdgeInsets(top: 0.0446 * containerHeight, leading: 0, bottom: 0, trailing: 0))
                    Text("Speak Freely")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0.16 * containerHeight, leading: 0, bottom: 0, trailing: 0))
                    NavigationLink(destination: login, isActive: $isActive, label: { EmptyView() })
                }
                .background(background)
                .scaledToFill()
            }
            .onAppear(perform: {
                self.gotoLoginScreen(time: 3)
            })
        }
    }

    func gotoLoginScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.isActive = true
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
