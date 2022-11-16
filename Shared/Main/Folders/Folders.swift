import SwiftUI

struct FolderData {
    let id = UUID()
    let security: Int
    let title: String
    let lastDate: String
    let records: Int
}

struct FolderView: View {
    
    @State private var folders: [FolderData] = [
        FolderData(
            security: 0,
            title: "Favorites",
            lastDate: "12.06.2022",
            records: 26),
        FolderData(
            security: 0,
            title: "Favorites",
            lastDate: "12.06.2022",
            records: 12),
        FolderData(
            security: 1,
            title: "Work records",
            lastDate: "12.06.2022",
            records: 56),
        FolderData(
            security: 0,
            title: "Kids",
            lastDate: "12.06.2022",
            records: 2),
        FolderData(
            security: 0,
            title: "Trash",
            lastDate: "12.06.2022",
            records: 45),
        FolderData(
            security: 1,
            title: "Work records",
            lastDate: "12.06.2022",
            records: 56),
        FolderData(
            security: 0,
            title: "Kids",
            lastDate: "12.06.2022",
            records: 2),
        FolderData(
            security: 0,
            title: "Trash",
            lastDate: "12.06.2022",
            records: 45),
    ]

    @State private var selection: Int? = 0
    @State private var search: String = ""

    let newFolder = NewFolder()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack
                {
                    Spacer()
                    NavigationLink(destination: newFolder.navigationBarHidden(true), tag: 1, selection: $selection) {
                        Button(action: {
                            self.selection = 1
                        }) {
                            Image("add_folder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                    }
                    Spacer().frame(width:24)
                }
                HStack{
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(red: 0.596, green: 0.635, blue: 0.643))
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 8))
                    TextField(
                        "Search",
                        text: $search
                    )
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 12))
                }
                    .background(.white)
                    .cornerRadius(8)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Text("Folders (\(folders.count))")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 8, trailing: 24))
                ScrollView {
                    VStack {
                        ForEach(folders, id: \.id) { folderData in
                            FolderItem(
                                security: folderData.security,
                                title: folderData.title,
                                lastDate: folderData.lastDate,
                                records: folderData.records)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                }
            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}

struct FolderItem: View {

    let security: Int // 0: open, 1: security
    let title: String
    let lastDate: String
    let records: Int

    var body: some View {
        Button(action: {
            print("------------>")
        }) {
            HStack(alignment: .center)
            {
                ZStack {
                    Image("folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 64)
                        .foregroundColor(.white)
                    Image(systemName: security == 0 ? "play.fill" : "lock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.white)
                }.padding()

                VStack {
                    HStack {
                        Text(title)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(records) Records")
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                            Text("Last edit: \(lastDate)")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
        .background(.white)
        .cornerRadius(8)
    }
}
