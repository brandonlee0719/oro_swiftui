//
//  RecordEdit.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/18.
//

import SwiftUI

struct RecordEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selection: Int? = 0

    let containerWidth:CGFloat = UIScreen.main.bounds.width
    let containerHeight:CGFloat = UIScreen.main.bounds.height

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.white)
                            .frame(width: 175, height: 175, alignment: .center)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                        VStack {
                            Image("Logo_blue")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(height: 118, alignment: .center)
                    }
                        .padding(EdgeInsets(top: 0.075 * containerHeight, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                VStack {
                    Text("My First Record")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        .padding(EdgeInsets(top: 0.044 * containerHeight, leading: 0, bottom: 1, trailing: 0))
                    Text("Folder: Work Records")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                }
                Button(action: {
                           
                    }) {
                        HStack {
                            VStack {
                                Image("audio_active")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(height: 24, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                            Text("Make Audiogram")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 32, leading: 40, bottom: 0, trailing: 0))
                    }
                Button(action: {
                           
                    }) {
                        HStack {
                            VStack {
                                Image("new_folder")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(height: 24, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                            Text("Make Audiogram")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 32, leading: 40, bottom: 0, trailing: 0))
                    }
                Button(action: {
                           
                    }) {
                        HStack {
                            VStack {
                                Image("edit")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(height: 24, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                            Text("Edit")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 32, leading: 40, bottom: 0, trailing: 0))
                    }
                Button(action: {
                           
                    }) {
                        HStack {
                            VStack {
                                Image("share")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(height: 24, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                            Text("Share")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 32, leading: 40, bottom: 0, trailing: 0))
                    }
                Button(action: {
                           
                    }) {
                        HStack {
                            VStack {
                                Image("delete")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(height: 24, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                            Text("Delete")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 32, leading: 40, bottom: 0, trailing: 0))
                    }
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("Close")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        }
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                    }
            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct RecordEdit_Previews: PreviewProvider {
    static var previews: some View {
        RecordEdit()
    }
}
