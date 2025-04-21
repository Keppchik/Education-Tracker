//
//  HomeModel.swift
//  Education tracker
//
//  Created by Иван Кретов on 21.04.2025.
//

import Foundation

struct TaskItem {
    var id = UUID()
    var title: String
    var date: Date
    var isDone: Bool = false
}

func formatDateHourMin(_ date: Date, locale: String = "en_US") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.locale = Locale(identifier: locale)
    return dateFormatter.string(from: date)
}

func formatDateDayMonth(_ date: Date, locale: String = "en_US") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM"
    dateFormatter.locale = Locale(identifier: locale)
    return dateFormatter.string(from: date)
}

enum SectionEnum {
    case today
    case tomorrow
    case later
}
