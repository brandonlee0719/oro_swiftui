import SwiftUI

struct AudiogramData {
    let id = UUID()
    let security: Int
    let title: String
    let lastDate: String
    let records: Int
}

struct AudiogramView: View {
    
    @State private var audios: [AudiogramData] = [
        AudiogramData(
            security: 0,
            title: "Favorites",
            lastDate: "12.06.2022",
            records: 26),
        AudiogramData(
            security: 0,
            title: "Favorites",
            lastDate: "12.06.2022",
            records: 12),
        AudiogramData(
            security: 1,
            title: "Work records",
            lastDate: "12.06.2022",
            records: 56),
        AudiogramData(
            security: 0,
            title: "Kids",
            lastDate: "12.06.2022",
            records: 2),
        AudiogramData(
            security: 0,
            title: "Trash",
            lastDate: "12.06.2022",
            records: 45),
    ]
    @State private var search: String = ""

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
                                .foregroundColor(.blue)
                        }
                        .cornerRadius(8)
                    Spacer().frame(width:24)
                }
                HStack{
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(red: 0.596, green: 0.635, blue: 0.643))
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                    TextField(
                        "Search",
                        text: $search
                    )
                    .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
                }
                    .background(.white)
                    .cornerRadius(8)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Text("Audiograms (24)")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 8, trailing: 24))
                 List {
                     Section(header: Text("audios (\(audios.count))")) {
                    
                        ForEach(audios, id: \.id) { AudiogramData in
                            AudiogramItem(
                                security: AudiogramData.security,
                                title: AudiogramData.title,
                                lastDate: AudiogramData.lastDate,
                                records: AudiogramData.records)
                        }
                     }
                 }
                 .padding(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 0))
            }
        }
            .background(Color(red: 0.949, green: 0.957, blue: 0.98))
    }
}

struct AudiogramView_Previews: PreviewProvider {
    static var previews: some View {
        AudiogramView()
    }
}

struct AudiogramItem: View {

    let security: Int // 0: open, 1: security
    let title: String
    let lastDate: String
    let records: Int

    var body: some View {
        HStack(alignment: .center)
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
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            
        }
        
            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
             .cornerRadius(8)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}
