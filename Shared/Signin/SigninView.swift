//
//  SigninView.swift
//  ORO
//
//  Created by mac on 2022/10/26.
//

import SwiftUI

struct SigninView: View {
    @State var selection: Int? = nil
    let main = MainView(viewRouter: MainRouter())
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
                        .frame(width: 0.352 * containerWidth)
                    HStack(alignment: .center)
                    {
                        Image("Letter_o")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.096 * containerWidth)
                        Image("Letter_r")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.065 * containerWidth)
                        Image("Letter_o")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 0.096 * containerWidth)
                    }
                    .padding(EdgeInsets(top: 0.022 * containerHeight, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    NavigationLink(destination: main.navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                            self.selection = 1
                        }) {
                            Text("Continue with Email")
                                .frame(minWidth: 0, maxWidth: 0.8 * containerWidth)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                        }
                        .background(.black.opacity(0))
                        .cornerRadius(8)
                    }
                   
                }
                .background(background)
                .scaledToFill()
                .padding(EdgeInsets(top: 0.1 * containerHeight, leading: 0, bottom: 0.2 * containerHeight, trailing: 0))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
