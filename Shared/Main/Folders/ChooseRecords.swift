//
//  ChooseRecords.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/16.
//

import SwiftUI

struct ChooseRecords: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var viewRouter = MainRouter()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selection: Int? = 0
    @State private var search: String = ""
    
    let folderName: String

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                           self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                    Spacer()
                    NavigationLink(destination: MainView(viewRouter: viewRouter, audioRecorder: audioRecorder).navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                                viewRouter.currentPage = .folder
                                self.selection = 1
                            }) {
                                Text("Save")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                            }
                    }
                }
                .padding()
                ZStack {
                    Image("folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 64)
                        .foregroundColor(.white)
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }.padding()
                Text(folderName)
                    .font(.system(size: 24))
                    .background(.white.opacity(0))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("No Records")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                Text("You can add Records to this Folder\nfrom your list")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    .padding()

                ScrollView {
                    VStack {
                        ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                            ChooseRecordItem(
                                audioURL: recording.fileURL,
                                createAt: recording.createdAt,
                                duration: recording.duration
                            )
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                }

            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct ChooseRecords_Previews: PreviewProvider {
    static var previews: some View {
        ChooseRecords(folderName: "Main Folder")
    }
}

struct ChooseRecordItem: View {

    let audioURL: URL
    let createAt: Date
    let duration: Float

    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack(alignment: .center)
        {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(audioURL.lastPathComponent)")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        Text("\(getTimeFromFloat(time: duration))")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                    }
                    Spacer()
                    VStack {
                        Text("\(getMonthNamFromDate(date: createAt))")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                        Text("\(getDayFromDate(date: createAt))")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    }
                }
            }
                .padding()
                .background(.white)
                .cornerRadius(8)
            Button(action: {
                
            }) {
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color(red: 0.831, green: 0.847, blue: 0.871))
            }
        }
    }
}
