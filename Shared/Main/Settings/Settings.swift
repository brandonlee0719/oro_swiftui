import SwiftUI

struct SettingView: View {
    @StateObject var viewRouter: MainRouter
    
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 86/255, green: 183/255, blue: 230/255), Color(red: 121/255, green: 211/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom)
    let containerWidth:CGFloat = UIScreen.main.bounds.width
    let containerHeight:CGFloat = UIScreen.main.bounds.height

    
    var body: some View {
        ZStack(alignment: .topLeading) {
                background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                            print("helloooooooooooooooooo")
                            viewRouter.currentPage = .record
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(8)
                    Spacer().frame(width:24)
                }
                HStack {
                    Text("Settings")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                HStack {
                    Image("setting_account")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Account")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                    Image("setting_arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .overlay( Divider()
                              .frame(maxWidth: .infinity, maxHeight:1)
                                .background(.white), alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Image("setting_general")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("General")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                    Image("setting_arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .overlay( Divider()
                              .frame(maxWidth: .infinity, maxHeight:1)
                                .background(.white), alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Image("setting_support")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Support")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .overlay( Divider()
                              .frame(maxWidth: .infinity, maxHeight:1)
                                .background(.white), alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Image("setting_privacy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Privacy Policy")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .overlay( Divider()
                              .frame(maxWidth: .infinity, maxHeight:1)
                                .background(.white), alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Image("setting_terms")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Terms & Conditions")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .overlay( Divider()
                              .frame(maxWidth: .infinity, maxHeight:1)
                                .background(.white), alignment: .bottom)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                HStack {
                    Image("setting_logout")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Log Out")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                    .frame(height: containerHeight * 64 / 896, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewRouter: MainRouter())
    }
}
