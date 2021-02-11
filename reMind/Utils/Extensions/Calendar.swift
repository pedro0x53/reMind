//
//  Calendar.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

extension Calendar {
    func getDateString(byAdding days: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        let today = Date()
        if days == 0 {
            return formatter.string(from: today)
        }

        let newDate = Calendar.current.date(byAdding: .day, value: days, to: today)!
    
        return formatter.string(from: newDate)
    }
}
