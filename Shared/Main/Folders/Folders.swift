import SwiftUI

struct FolderView: View {
    
    @State private var selection: Int? = 0
    @State private var search: String = ""

    let addFolder = AddFolder()
    @ObservedObject var folderManager = FolderManager()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack
                {
                    Spacer()
                    NavigationLink(destination: addFolder.navigationBarHidden(true), tag: 1, selection: $selection) {
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
                Text("Folders (\(folderManager.listFolders.count))")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 8, trailing: 24))
                ScrollView {
                    VStack {
                        ForEach(folderManager.listFolders, id: \.id) { folderData in
                            FolderItem(
                                security: folderData.security,
                                title: folderData.title,
                                updatedAt: folderData.updatedAt,
                                records: getRecordsCount(records: folderData.records))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                }
            }
        }
        .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }

    func getRecordsCount(records: String) -> Int {
        let recordsArr = records.components(separatedBy: ",")
        return recordsArr.count-1
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}

struct FolderItem: View {

    let security: String
    let title: String
    let updatedAt: String
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
                    Image(systemName: security.isEmpty ? "play.fill" : "lock.fill")
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
                            Text("Last edit: \(updatedAt)")
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
