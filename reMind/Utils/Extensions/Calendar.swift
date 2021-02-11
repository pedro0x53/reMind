//
//  Calendar.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

extension Calendar {
    func getTodayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        let today = Date()
    
        return formatter.string(from: today)
    }

    func getTomorowDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    
        return formatter.string(from: tomorrow)
    }
}
