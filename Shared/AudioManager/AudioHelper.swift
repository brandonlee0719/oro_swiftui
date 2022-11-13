//
//  AudioHelper.swift
//  ORO
//
//  Created by MAC on 2022/11/12.
//

import Foundation

func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}

func getTimeFromFloat(time:Float) -> String {
    let second: Int = Int(time) % 60
    let minute: Int = (Int(time) - Int(time) % 60) % 60
    let str_second = second < 10 ? "0\(second)" : "\(second)"
    let str_minute = minute<10 ? "0\(minute)" : "\(minute)"
    return "\(str_minute):\(str_second)"
}

func getMonthNamFromDate(date:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    let monthString = dateFormatter.string(from: date)
    return "\(monthString.prefix(3))"
}

func getDayFromDate(date:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd"
    let dateString = dateFormatter.string(from: date)
    return "\(dateString)"
}
