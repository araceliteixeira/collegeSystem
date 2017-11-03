//
//  Schedule.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Schedule {
    
    private var scheduleId: Int
    private var classe: Classe
    private var weekday: String
    private var startHour: String
    private var endHour: String
    private var startDate: NSDate
    private var endDate: NSDate
    
    init(){
        scheduleId = 0
        classe = Classe()
        weekday = ""
        startHour = ""
        endHour = ""
        startDate = NSDate()
        endDate = NSDate()
    }
    
    init(_ scheduleId: Int, _ classe: Classe, _ weekday: String, _ startHour: String, _ endHour: String, _ startDate: String, _ endDate: String) {
        self.scheduleId = scheduleId
        self.classe = classe
        self.weekday = weekday
        self.startHour = startHour
        self.endHour = endHour
        self.startDate = Util.convertStringToDate(startDate)
        self.endDate = Util.convertStringToDate(endDate)
    }
    
    func getScheduleId() -> Int {
        return scheduleId
    }
    func setScheduleId(_ scheduleId: Int) {
        self.scheduleId = scheduleId
    }
    func getClasse() -> Classe {
        return classe
    }
    func setClasse(_ classe: Classe) {
        self.classe = classe
    }
    func getWeekday() -> String {
        return weekday
    }
    func setWeekday(_ weekday: String) {
        self.weekday = weekday
    }
    func getStartHour() -> String {
        return startHour
    }
    func setStartHour(_ startHour: String) {
        self.startHour = startHour
    }
    func getEndHour() -> String {
        return endHour
    }
    func setEndHour(_ endHour: String) {
        self.endHour = endHour
    }
    func getStartDate() -> String {
        return Util.convertDateToString(startDate)
    }
    func setStartDate(_ startDate: String) {
        self.startDate = Util.convertStringToDate(startDate)
    }
    func getEndDate() -> String {
        return Util.convertDateToString(endDate)
    }
    func setEndDate(_ endDate: String) {
        self.endDate = Util.convertStringToDate(endDate)
    }
    
}
