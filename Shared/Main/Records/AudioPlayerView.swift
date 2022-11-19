//
//  AudioPlayerView.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/18.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var progress: CGFloat = 0.0
    @State private var playing: Bool = false
    @State var duration: Double = 0.0
    @State var formattedDuration: String = ""
    @State var formattedProgress: String = "00:00"
    var audioURL: URL

    var body: some View {
        VStack {
            VStack {
                GeometryReader { gr in
                    Capsule()
                        .stroke(Color(red: 0.847, green: 0.847, blue: 0.847), lineWidth: 2)
                        .background(
                            Capsule()
                                .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                                .frame(width: gr.size.width * progress, height: 8), alignment: .leading)
                }
                .frame( height: 8)
                HStack {
                    Text(formattedProgress)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    Spacer()
                    Text(formattedDuration)
                        .font(.system(size: 16))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .padding()
            .frame(height: 50, alignment: .center)
            .accessibilityElement(children: .ignore)
            .accessibility(identifier: "audio player")
            .accessibilityLabel(playing ? Text("Playing at ") : Text("Duration"))
            .accessibilityValue(Text("\(formattedProgress)"))

            //             the control buttons
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Button(action: {
                    let decrease = self.audioPlayer.currentTime - 15
                    if decrease < 0.0 {
                        self.audioPlayer.currentTime = 0.0
                    } else {
                        self.audioPlayer.currentTime -= 15
                    }
                }) {
                    Image(systemName: "gobackward.15")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:32, height:32)
                        .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                }.padding()

                Button(action: {
                    if audioPlayer.isPlaying {
                        playing = false
                        self.audioPlayer.pause()
                    } else if !audioPlayer.isPlaying {
                        playing = true
                        self.audioPlayer.play()
                    }
                }) {
                    Image(systemName: playing ?
                          "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:68, height:68)
                        .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                }.padding()

                Button(action: {
                    let increase = self.audioPlayer.currentTime + 15
                    if increase < self.audioPlayer.duration {
                        self.audioPlayer.currentTime = increase
                    } else {
                        // give the user the chance to hear the end if he wishes
                        self.audioPlayer.currentTime = duration
                    }
                }) {
                    Image(systemName: "goforward.15")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:32, height:32)
                        .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                }.padding()
                Spacer()
            }
        }
        .foregroundColor(.blue)
        .onAppear {
            initialiseAudioPlayer()
        }
    }

    func initialiseAudioPlayer() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]

        // init audioPlayer
//        let path = Bundle.main.path(forResource: "audioTest", ofType: "m4a")!
        
        self.audioPlayer = try! AVAudioPlayer(contentsOf: audioURL)
        self.audioPlayer.prepareToPlay()

        //I need both! The formattedDuration is the string to display and duration is used when forwarding
        formattedDuration = formatter.string(from: TimeInterval(self.audioPlayer.duration))!
        duration = self.audioPlayer.duration

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !audioPlayer.isPlaying {
                playing = false
            }
            progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
            formattedProgress = formatter.string(from: TimeInterval(self.audioPlayer.currentTime))!
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(audioURL: URL(string:"")!)
            .previewLayout(PreviewLayout.fixed(width: 500, height: 300))
            .previewDisplayName("Default preview")
        AudioPlayerView(audioURL: URL(string:"")!)
            .previewLayout(PreviewLayout.fixed(width: 500, height: 300))
            .environment(\.sizeCategory, .accessibilityExtraLarge)
    }
}
