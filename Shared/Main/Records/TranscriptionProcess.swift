//
//  TranscriptionProcess.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/19.
//

import SwiftUI

struct TranscriptionProcess: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isProgress: Bool
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack{
            Spacer().frame(height: 130)
            Text("Audio Record")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                .padding()
            Text("this action will start the audio \ntranscription, do you want to proceed?")
                .font(.system(size: 14))
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                .padding()
            Spacer()
            
            Button(action: {
                isProgress.toggle()
                dismiss()
            }) {
                Text("Yes, Transcribe")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
            }
                .background(Color(red: 0.337, green: 0.718, blue: 0.902))
                .cornerRadius(8)
                .padding()
            
            Button(action: {
                isShowing.toggle()
                dismiss()
            }) {
                Text("No")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
            }
                .background(.red)
                .cornerRadius(8)
                .padding()
            Spacer().frame(height: 40)
        }
    }
}

struct TranscriptionProcess_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptionProcess(isProgress: .constant(true), isShowing: .constant(true))
    }
}
