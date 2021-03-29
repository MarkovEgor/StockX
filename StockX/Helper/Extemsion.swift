//
//  Extemsion.swift
//  StockX
//
//  Created by Egor Markov on 3/26/21.
//

import Foundation

extension Date {
    init(_ dateString:String, dateFormat: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = dateFormat
        dateStringFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    func isInLastNDays(lastDate: Date, dayRange n: Int) -> Bool {
        let startDate = Calendar.current.date(byAdding: .day, value: -n, to: Date())!
        return (min(startDate, lastDate) ...  max(startDate, lastDate)).contains(self)
    }
    
    func isInLastNMonth(lastDate: Date, dayRange n: Int) -> Bool {
        let startDate = Calendar.current.date(byAdding: .month, value: -n, to: Date())!
        return (min(startDate, lastDate) ...  max(startDate, lastDate)).contains(self)
    }
    
    func isInLastNYears(lastDate: Date, dayRange n: Int) -> Bool {
        let startDate = Calendar.current.date(byAdding: .year, value: -n, to: Date())!
        return (min(startDate, lastDate) ...  max(startDate, lastDate)).contains(self)
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
