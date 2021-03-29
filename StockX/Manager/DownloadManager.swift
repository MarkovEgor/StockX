//
//  DownloadManager.swift
//  StockX
//
//  Created by Egor Markov on 3/26/21.
//

import SwiftUI

class DownloadManager: ObservableObject {
    
    @Published var dataFetched = false
    
    var dataEntries = [DataEntry]()
    var dailyEntries = [DataEntry]()
    var weeklyEntries = [DataEntry]()
    var monthsEntries = [DataEntry]()
    var yearsEntries = [DataEntry]()
    
    
    init(stockSymbol: String) {
        fetchData(stockSymbol: stockSymbol)
    }
    
    func fetchData(stockSymbol: String) {
        
        dataFetched = false
        dataEntries = [DataEntry]()
        weeklyEntries = [DataEntry]()
        dailyEntries = [DataEntry]()
        
        downloadJSON(stockSymbol: stockSymbol) { (finished) in
            if finished {
                self.filterDataEntries()
                DispatchQueue.main.async {
                    withAnimation {
                        self.dataFetched = true
                    }
                }
            }
        }
    }
    
    private func downloadJSON(stockSymbol: String, handler: @escaping (_ status: Bool) -> ()) {
        if let url = URL(string: generateRequestURL(stockSymbol: stockSymbol)) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(TimeSeriesJSON.self, from: data)
                        for timeSeries in parsedJSON.timeSeries {
                            self.dataEntries.append(DataEntry(date: Date(timeSeries.key, dateFormat: "yyyy-MM-dd HH:mm:ss"), close: (timeSeries.value.close as NSString).doubleValue))
                        }
                        
                        if self.dataEntries.count == parsedJSON.timeSeries.count {
                            self.dataEntries.sort(by: {$0.date.compare($1.date) == .orderedAscending})
                            handler(true)
                        }
                        
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
    private func filterDataEntries() {
        
        guard let lastDateOfData = dataEntries.last?.date else { return }
        
        for entry in dataEntries {
            if Calendar.current.isDate(entry.date, equalTo: lastDateOfData, toGranularity: .day) {
                dailyEntries.append(entry)
            }
            
            if entry.date.isInLastNDays(lastDate: lastDateOfData, dayRange: 7) {
                weeklyEntries.append(entry)
            }
            
            if entry.date.isInLastNMonth(lastDate: lastDateOfData, dayRange: 1) {
                monthsEntries.append(entry)
            }
            
            if entry.date.isInLastNYears(lastDate: lastDateOfData, dayRange: 1) {
                yearsEntries.append(entry)
            }
        }
       
    }
}

