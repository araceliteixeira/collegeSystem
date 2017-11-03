//
//  Util.swift
//  College
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Util {
    static let dateFormatter = DateFormatter()
    static let dateFormat = "yyyy-MM-dd"
    
    static func convertStringToDate(_ stringDate: String) -> NSDate {
        if stringDate == "" {
            return NSDate()
        }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from:stringDate)! as NSDate
    }
    
    static func convertDateToString(_ date: NSDate) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from:date as Date)
    }
    
    static func pad(_ string: String, _ size: Int) -> String {
        var string = string
        let pad = size - string.characters.count
        if pad >= 0 {
            for _ in 0...(size - string.characters.count) {
                string += " "
            }
        }
        return string
    }
    
    static func pad(_ number: Int, _ size: Int) -> String {
        return pad(String(number), size)
    }
}
