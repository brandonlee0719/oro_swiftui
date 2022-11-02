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
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack
                {
                    Spacer()
                    Button(action: {
                            
                        }) {
                            Text("Import")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .cornerRadius(8)
                    Spacer().frame(width:24)
                }
                    .background(.blue)
                List {
                    Section(header: Text("Folders (\(folders.count))")) {
                        ForEach(folders, id: \.id) { folderData in
                            FolderItem(
                                security: folderData.security,
                                title: folderData.title,
                                lastDate: folderData.lastDate,
                                records: folderData.records)
                        }
                    }

                }
            }
        }
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
        HStack(alignment: .center, spacing: 16)
        {
            ZStack {
                RoundedRectangle(cornerRadius:6, style: .continuous)
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                Image("folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 32)
                    .foregroundColor(.white)
                    .padding([.leading], security == 0 ? 5: 0)
                Image(systemName: security == 0 ? "play.fill" : "lock.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                    .padding([.leading], security == 0 ? 5: 0)
            }

            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(records) Records")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                        Text("Last edit: \(lastDate)")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    }
                    Spacer()
                }
            }
            
        }
    }
}
