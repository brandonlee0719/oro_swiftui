//
//  SigninView.swift
//  Shared
//
//  Created by mac on 2022/10/25.
//

import SwiftUI

struct SigninView: View {
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 86/255, green: 183/255, blue: 230/255), Color(red: 121/255, green: 211/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom);
    let containerWidth:CGFloat = UIScreen.main.bounds.width;
    let containerHeight:CGFloat = UIScreen.main.bounds.height;
    var body: some View {
        ZStack {
            background
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center)
            {
                
                Text("Signin")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0.16 * containerHeight, leading: 0, bottom: 0, trailing: 0))
            }
            .background(background)
            .scaledToFill()
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
