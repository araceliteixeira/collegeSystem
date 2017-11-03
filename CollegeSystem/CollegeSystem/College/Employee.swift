//
//  Employee.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Employee {
    
    private var employeeId: Int
    private var name : String
    private var mainFunction: Function
    private var startDate: NSDate
    private var endDate: NSDate
    
    init(){
        employeeId = 0
        name = ""
        mainFunction = Function.Staff
        startDate = NSDate()
        endDate = NSDate()
    }
    init(_ employeeId: Int, _ name: String, _ mainFunction: Function, _ startDate: String, _ endDate: String) {
        self.employeeId = employeeId
        self.name = name
        self.mainFunction = mainFunction
        self.startDate = Util.convertStringToDate(startDate)
        self.endDate = Util.convertStringToDate(endDate)
    }
    convenience init(_ employeeId: Int, _ name: String, _ mainFunction: Int, _ startDate: String, _ endDate: String) {
        self.init(employeeId, name, Function(rawValue: mainFunction)!, startDate, endDate)
    }
    
    func getEmployeeId() -> Int {
        return employeeId
    }
    
    func setEmployeeId(_ employeeId: Int) {
        self.employeeId = employeeId
    }
    
    func getName() -> String {
        return name
    }

    func setName(_ name: String) {
        self.name = name
    }
    
    func getMainFunction() -> Function {
        return mainFunction
    }
    
    func setMainFunction(_ mainFunction: Function) {
        self.mainFunction = mainFunction
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
