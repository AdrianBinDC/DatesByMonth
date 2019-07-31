import UIKit

//struct ScheduleDates {
//    var month: String
//    var dates: [Date]
//}

struct ScheduleDates {
    var month: Int
    var dates: [Date]
}



//extension Date {
//    static func dateDictionary(from arrayOfDates: [Date]) -> [String: [Date]] {
//        // declare a dictionary
//        return Dictionary(grouping: arrayOfDates) { date -> String in
//            // get the month as an int
//            let monthAsInt = Calendar.current.dateComponents([.month], from: date).month
//            // convert the int to a string...i think you probably want to return an int value and do the month conversion in your tableview or collection view
//            let monthName = DateFormatter().monthSymbols[(monthAsInt ?? 0) - 1]
//            // return the month string
//            return monthName
//        }
//    }
//}

extension Date {
    static func dateDictionary(from arrayOfDates: [Date]) -> [Int: [Date]] {
        // declare a dictionary
        return Dictionary(grouping: arrayOfDates) { date -> Int in
            // get the month as an Int
            let monthAsInt = Calendar.current.dateComponents([.month], from: date).month
            return monthAsInt ?? 0
        }
    }
}


// Utility method to generate dates
func createDate(month: Int, day: Int, year: Int) -> Date? {
    var components = DateComponents()
    components.month = month
    components.day = day
    components.year = year
    
    return Calendar.current.date(from: components)!
}

// generate array of sample dates
let dateArray: [Date] = {
    let months = Array(1...12)
    let days = Array(1...31)
    let years = [2019]
    
    var dateArray: [Date] = []
    
    while dateArray.count < 100 {
        let randomMonth = months.randomElement()
        let randomDay = days.randomElement()
        let randomYear = years.randomElement()
        
        if let month = randomMonth,
            let day = randomDay,
            let year = randomYear,
            let date = createDate(month: month,
                                  day: day,
                                  year: year) {
            dateArray.append(date)
        }
    }
    
    return dateArray
}()

let monthDictionary = Date.dateDictionary(from: dateArray)

var arrayOfStruct: [ScheduleDates] = []

monthDictionary.keys.forEach { key in
    let scheduleDate = ScheduleDates(month: key,
                                     dates: monthDictionary[key] ?? [])
    arrayOfStruct.append(scheduleDate)
}

arrayOfStruct = arrayOfStruct.sorted(by: { $0.month < $1.month })
