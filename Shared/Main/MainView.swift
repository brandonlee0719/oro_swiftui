
import SwiftUI

struct MainView: View {
    
    @StateObject var viewRouter: MainRouter
    
    @State var showPopUp = false

    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 76/255, green: 76/255, blue: 76/255), Color(red: 41/255, green: 41/255, blue: 41/255)]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                switch viewRouter.currentPage {
                    case .record:
                        RecordView()
                    case .audiogram:
                        AudiogramView()
                    case .folder:
                        FolderView()
                    case .setting:
                        SettingView(viewRouter: viewRouter)
                }
                if(viewRouter.currentPage != .setting) {
                    ZStack {
                        if showPopUp {
                            RecordMenu(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .record, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_record", tabName: "Records")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .audiogram, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_audiogram", tabName: "Audiograms")
                            ZStack {
                                
                                Image("Btn_center")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5 , height: geometry.size.width/5)
                                    .foregroundColor(.blue)
                                    .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                                Image("Logo")
                                    .resizable()
                                    .padding(16)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5 , height: geometry.size.width/5)
                                    .foregroundColor(.blue)
                                    .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                            }
                                .offset(y: -geometry.size.height/8/2-6)
                                .onTapGesture {
                                    withAnimation {
                                        showPopUp.toggle()
                                    }
                                }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .folder, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_folder", tabName: "Folders")
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .setting, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_setting", tabName: "Settings")
                        }
                             .frame(width: geometry.size.width, height: geometry.size.height/896*100)
                            .background(
                                Image("Bg_tab")
                                    .resizable()
                                    .scaledToFill()
                            )
                    }
                }
            }
               .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: MainRouter())
    }
}

struct RecordMenu: View {
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color("DarkPurple"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            ZStack {
                Circle()
                    .foregroundColor(Color("DarkPurple"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
        }
            .transition(.scale)
    }
}

struct TabBarIcon: View {
    
    @StateObject var viewRouter: MainRouter
    let assignedPage: Page
    
    let width, height: CGFloat
    let iconName, tabName: String

    var body: some View {
        VStack {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
                .opacity(viewRouter.currentPage == assignedPage ? 1: 0.6)
            Text(tabName)
                .font(.footnote)
                .foregroundColor(.white)
                .opacity(viewRouter.currentPage == assignedPage ? 1: 0.6)
            Spacer()
        }
            .padding(.horizontal, -4)
            .onTapGesture {
                viewRouter.currentPage = assignedPage
            }
    }
}
