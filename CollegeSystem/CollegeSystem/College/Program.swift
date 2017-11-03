//
//  Program.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Program {
    
    private var programId: Int
    private var name: String
    private var head: Employee
    private var department: Department
    
    init(){
        programId = 0
        name = ""
        head = Employee()
        department = Department()
    }
    
    init(_ programId: Int, _ name: String, _ head: Employee, _ department: Department) {
        self.programId = programId
        self.name = name
        self.head = head
        self.department = department
    }
    
    func getProgramId() -> Int {
        return programId
    }
    func setProgramId(_ programId: Int) {
        self.programId = programId
    }
    func getName() -> String {
        return name
    }
    func setName(_ name: String) {
        self.name = name
    }
    func getHead() -> Employee {
        return head
    }
    func setHead(_ head: Employee) {
        self.head = head
    }
    func getdepartment() -> Department {
        return department
    }
    func setdepartment(_ department: Department) {
        self.department = department
    }
}
