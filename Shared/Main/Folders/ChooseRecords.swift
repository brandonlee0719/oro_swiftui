//
//  ChooseRecords.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/16.
//

import SwiftUI

struct ChooseRecords: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selection: Int? = 0
    @State private var search: String = ""

    @State private var folderName: String = "New Folder Name"

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
                    // NavigationLink(destination: newFolder.navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                                self.selection = 1
                            }) {
                                Text("Next")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                            }
                    // }
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
                Text("Main Folder")
                    .font(.system(size: 24))
                    .background(.white.opacity(0))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .multilineTextAlignment(.center)
                    .padding()
                Text("No Records")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct ChooseRecords_Previews: PreviewProvider {
    static var previews: some View {
        ChooseRecords()
    }
}
