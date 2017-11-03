//
//  Course.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Course {
    
    private var courseId: Int
    private var name: String
    private var head: Employee
    private var creditHour: Int
    private var program: Program
    
    init(){
        courseId = 0
        name = ""
        head = Employee()
        creditHour = 0
        program = Program()
    }
    
    init(_ courseId: Int, _ name: String, _ head: Employee, _ creditHour: Int, _ program: Program) {
        self.courseId = courseId
        self.name = name
        self.head = head
        self.creditHour = creditHour
        self.program = program
    }
    
    func getCourseId() -> Int {
        return courseId
    }
    func setCourseId(_ courseId: Int) {
        self.courseId = courseId
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
    func getCreditHour() -> Int {
        return creditHour
    }
    func setCreditHour(_ creditHour: Int) {
        self.creditHour = creditHour
    }
    func getProgram() -> Program {
        return program
    }
    func setProgram(_ program: Program) {
        self.program = program
    }
    }
