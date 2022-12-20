import SwiftUI

struct RecordData {
    let id = UUID()
    let playStatus: Int
    let title: String
    let detail: String
    let duration: String
    let month: String
    let date: String
}

struct RecordView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    @State private var search: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                // HStack
                // {
                //     Spacer()
                //     Button(action: {
                            
                //         }) {
                //             Text("Import")
                //                 .font(.system(size: 16))
                //                 .foregroundColor(.blue)
                //         }
                //         .cornerRadius(8)
                //     Spacer().frame(width:24)
                // }
                // HStack{
                //     Image(systemName: "magnifyingglass")
                //         .resizable()
                //         .aspectRatio(contentMode: .fit)
                //         .frame(width: 16, height: 16)
                //         .foregroundColor(Color(red: 0.596, green: 0.635, blue: 0.643))
                //         .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 8))
                //     TextField(
                //         "Search",
                //         text: $search
                //     )
                //     .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 12))
                // }
                //     .background(.white)
                //     .cornerRadius(8)
                //     .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Text("Recordings (\(audioRecorder.recordings.count))")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 10, leading: 24, bottom: 0, trailing: 24))
                ScrollView {
                    VStack {
                        if(audioRecorder.uploading) {
                            ProgressView()
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                            RecordItem(
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

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(audioRecorder: AudioRecorder())
    }
}

struct RecordItem: View {

    let audioURL: URL
    let createAt: Date
    let duration: Float

    @ObservedObject var audioPlayer = AudioPlayer()
    
    @State private var selection: Int? = 0
    
    var body: some View {
        NavigationLink(destination: RecordPlayer(audioURL: audioURL).navigationBarHidden(true), tag: 1, selection: $selection) {
            Button(action: {
                self.selection = 1
            }) {
                HStack(alignment: .center)
                {
                
                        ZStack {
                            RoundedRectangle(cornerRadius:6, style: .continuous)
                                .foregroundColor(Color(red: 238/255, green: 248/255, blue: 252/255, opacity: 1.0))
                                .frame(width: 64, height: 64)
                            Circle()
                                .foregroundColor(Color(red: 86/255, green: 183/255, blue: 230/255, opacity: 1.0))
                                .frame(width: 40, height: 40)
                            Image(systemName: audioPlayer.isPlaying == false ? "play.fill": "stop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                                .padding([.leading], audioPlayer.isPlaying == false ? 5: 0)
                        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
                    VStack {
                        HStack {
                            Text("Audio Record")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                            Spacer()
                            NavigationLink(destination: RecordEdit().navigationBarHidden(true), tag: 2, selection: $selection) {
                                Button(action: {
                                    self.selection = 2
                                }) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                                        .padding()
                                }
                            }
                        }
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
                        .padding(.trailing, 16)
                    }
                }
                .background(.white)
                .cornerRadius(8)
            }
        }
    }
}

