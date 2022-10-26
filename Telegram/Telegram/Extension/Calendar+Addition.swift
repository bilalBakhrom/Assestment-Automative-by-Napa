//
//  Calendar+Addition.swift
//  Telegram
//
//  Created by Bilal M. on 26/10/2022.
//

import Foundation

extension Calendar {
    private var now: Date { return Date() }
    
    public func isDateInThisWeek(_ date: Date) -> Bool {
        isDate(date, equalTo: now, toGranularity: .weekOfMonth)
    }
    
    public func isDateInThisMonth(_ date: Date) -> Bool {
        isDate(date, equalTo: now, toGranularity: .month)
    }
    
    public func isDateInNextWeek(_ date: Date) -> Bool {
        guard let nextWeek = self.date(byAdding: DateComponents(weekOfYear: 1), to: now) else {
            return false
        }
        
        return isDate(date, equalTo: nextWeek, toGranularity: .weekOfYear)
    }
    
    public func isDateInNextMonth(_ date: Date) -> Bool {
        guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: now) else {
            return false
        }
        
        return isDate(date, equalTo: nextMonth, toGranularity: .month)
    }
    
    public func isDateInFollowingMonth(_ date: Date) -> Bool {
        guard let followingMonth = self.date(byAdding: DateComponents(month: 2), to: now) else {
            return false
        }
        
        return isDate(date, equalTo: followingMonth, toGranularity: .month)
    }
}
