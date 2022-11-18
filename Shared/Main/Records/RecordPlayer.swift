//
//  RecordPlayer.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/18.
//

import SwiftUI
import SwiftUIGIF

struct RecordPlayer: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selection: Int? = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                           self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                                .padding()
                        }
                    Spacer()
                    NavigationLink(destination: RecordEdit().navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                                self.selection = 1
                            }) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                                    .padding()
                            }
                    }
                }
                .padding()
                Image("folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 310, height: 310)
                    .foregroundColor(.white)
                    .padding()
                VStack {
                    Text("My First Record")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Text("Folder: Work Records")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                }.padding()
                AudioPlayerView().padding()
                HStack {
                    Button(action: {
                           
                    }) {
                        HStack {
                            Image("audio_text_inactive")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                                .padding()
                            Text("Transcribe\nAudio")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                        }
                    }
                    Spacer()
                    Button(action: {
                           
                    }) {
                        HStack {
                            Text("Create\nAudiogram")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                            Image("audio_active")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                                .padding()
                        }
                    }
                }.padding()
            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct RecordPlayer_Previews: PreviewProvider {
    static var previews: some View {
        RecordPlayer()
    }
}
