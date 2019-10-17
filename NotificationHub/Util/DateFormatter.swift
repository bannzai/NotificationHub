//
//  DateFormatter.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation


enum DateFormat: String {
    case yyyyMMddhhmmss = "yyyy-MM-dd'T'hh:mm:ss'Z'"
    case yyMMdd = "yyyy-MM-dd"
}

struct DateFormatter {
    private let dateFormatter: Foundation.DateFormatter
    let dateFormat: DateFormat
    let calendar: Calendar
    
    init(dateFormat: DateFormat) {
        let calendar = Calendar(identifier: .gregorian)
        self.dateFormat = dateFormat
        self.dateFormatter = {
            let formatter: Foundation.DateFormatter = Foundation.DateFormatter()
            formatter.dateFormat = dateFormat.rawValue
            formatter.calendar = calendar
            return formatter
        }()
        self.calendar = calendar
    }
    
    func date(from string: String) -> Date {
        guard let date = dateFormatter.date(from: string) else {
            fatalError("unexpected date format \(string)")
        }
        return date
    }
    
    func string(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    func dateComponents(from dateString: String) -> DateComponents {
        calendar.dateComponents(in: TimeZone.current, from: date(from: dateString))
    }
}

let APIDateformatter = DateFormatter(dateFormat: .yyyyMMddhhmmss)
let SectionTitleDateFormatter = DateFormatter(dateFormat: .yyMMdd)
