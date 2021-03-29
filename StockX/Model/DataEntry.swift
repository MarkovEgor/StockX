//
//  DataEntry.swift
//  StockX
//
//  Created by Egor Markov on 3/24/21.
//

import SwiftUI

struct DataEntry: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let close: Double
}

let sampleData = [
    DataEntry(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, close: 2.33),
    DataEntry(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, close: 17.319),
    DataEntry(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, close: 13.94),
    DataEntry(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, close: 20.4882)
]
