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
    
    @State private var records: [RecordData] = [
        RecordData(
            playStatus: 0,
            title: "Audio Record",
            detail: "My Voice with Helium",
            duration: "02:04",
            month: "Jun",
            date:"02"),
        RecordData(
            playStatus: 0,
            title: "Audio Record",
            detail: "My Voice with Helium",
            duration: "02:04",
            month: "Jun",
            date:"02"),
        RecordData(
            playStatus: 0,
            title: "Audio Record",
            detail: "My Voice with Helium",
            duration: "02:04",
            month: "Jun",
            date:"02"),
        RecordData(
            playStatus: 0,
            title: "Audio Record",
            detail: "My Voice with Helium",
            duration: "02:04",
            month: "Jun",
            date:"02"),
    ]

    var body: some View {
        VStack {
            HStack()
            {
                Spacer()
                Button("Import", action: {})
                Spacer().frame(width:24)
            }
                .frame(width:.infinity, height:48, alignment: .bottom)
            List {
                Section(header: Text("June 2021")) {
                    ForEach(records, id: \.id) { recordData in
                        RecordItem(
                            playStatus: recordData.playStatus,
                            title: recordData.title,
                            detail: recordData.detail,
                            duration: recordData.duration,
                            month: recordData.month,
                            date: recordData.date)
                    }
                }

                Section(header: Text("May 2021")) {
                    ForEach(records, id: \.id) { recordData in
                        RecordItem(
                            playStatus: recordData.playStatus,
                            title: recordData.title,
                            detail: recordData.detail,
                            duration: recordData.duration,
                            month: recordData.month,
                            date: recordData.date)
                    }
                }

            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}

struct RecordItem: View {

    let playStatus: Int // 0: stop, 1: play
    let title: String
    let detail: String
    let duration: String
    let month: String
    let date: String

    var body: some View {
        HStack(alignment: .center, spacing: 16)
        {
            ZStack {
                RoundedRectangle(cornerRadius:6, style: .continuous)
                    .foregroundColor(Color(red: 238/255, green: 248/255, blue: 252/255, opacity: 1.0))
                    .frame(width: 64, height: 64)
                Circle()
                    .foregroundColor(Color(red: 86/255, green: 183/255, blue: 230/255, opacity: 1.0))
                    .frame(width: 40, height: 40)
                Image(systemName: playStatus == 0 ? "play.fill" : "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding([.leading], playStatus == 0 ? 5: 0)
            }

            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(detail)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        Text(duration)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.337, green: 0.718, blue: 0.902))
                    }
                    Spacer()
                    VStack {
                        Text(month)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                        Text(date)
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(Color(red: 0.576, green: 0.62, blue: 0.678))
                    }
                }
            }
            
        }
    }
}
