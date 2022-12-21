
import SwiftUI
import AVFAudio

struct MainView: View {
    
    @StateObject var viewRouter: MainRouter
    @ObservedObject var audioRecorder: AudioRecorder

    @State private var showingRecording = false
    let background = LinearGradient(gradient: Gradient(colors: [Color(red: 76/255, green: 76/255, blue: 76/255), Color(red: 41/255, green: 41/255, blue: 41/255)]), startPoint: .top, endPoint: .bottom)

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                switch viewRouter.currentPage {
                    case .record:
                        RecordView(audioRecorder: audioRecorder)
                    case .audiogram:
                        AudiogramView()
                    case .folder:
                        FolderView()
                    case .setting:
                        SettingView(viewRouter: viewRouter)
                }
                if(viewRouter.currentPage != .setting) {
                    ZStack(alignment: .leading) {
                        if (audioRecorder.recording) {
                            RecordMenu(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }
                        HStack {

                        }
                            .frame(width: geometry.size.width, height:showingRecording ? geometry.size.height/896*400 : 0)
                            .offset(y: -6)
                            .shadow(color: .black, radius: 1, x: -1, y: -1)
                            .background(.gray)
                            .cornerRadius(20)
                            .animation(.linear)
                        HStack {
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .record, width: geometry.size.width/3, height: geometry.size.height/28, iconName: "tab_record", tabName: "Records")
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .audiogram, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_audiogram", tabName: "Audiograms")
                            ZStack {
                                Image("Btn_center")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5 , height: geometry.size.width/5)
                                    .foregroundColor(.blue)
                                if(audioRecorder.recording) {
                                    Image(systemName: "stop.fill")
                                        .resizable()
                                        .padding(16)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.white)
                                        .frame(width: geometry.size.width/7 , height: geometry.size.width/7)
                                } else {
                                    Image("Logo")
                                        .resizable()
                                        .padding(16)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width/5 , height: geometry.size.width/5)
                                }
                            }
                                .offset(y: -geometry.size.height/8/2-6)
                                .onTapGesture {
                                    if(audioRecorder.recording == false) {
                                        // self.audioRecorder.startRecording()
                                        showingRecording.toggle()
                                    } else {
                                        // self.audioRecorder.stopRecording()
                                        showingRecording.toggle()
                                    }
                                }
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .folder, width: geometry.size.width/3, height: geometry.size.height/28, iconName: "tab_folder", tabName: "Folders")
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .setting, width: geometry.size.width/5, height: geometry.size.height/28, iconName: "tab_setting", tabName: "Settings")
                        }
                            .frame(width: geometry.size.width, height: geometry.size.height/896*100)
                            .background(
                                Image("Bg_tab")
                                    .resizable()
                                    .scaledToFill()
                            )
                            .offset(y: getNavPosition(height: geometry.size.height))
                        
                    }
                }
            }
               .edgesIgnoringSafeArea(.bottom)
               .onAppear(perform: enableBuiltInMic)
        }
    }

    private func getNavPosition(height: CGFloat) -> CGFloat {
        if(showingRecording) {
            return height/896*200 - height/8/2 + 6
        } else {
            return 0
        }
    }
    
    private func enableBuiltInMic() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            print("Permission granted")
        case AVAudioSession.RecordPermission.denied:
            print("Pemission denied")
        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                print("Mic permission is Good")
            })
        @unknown default:
            print("Unknown Error")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: MainRouter(), audioRecorder: AudioRecorder())
    }
}

struct RecordMenu: View {
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
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
