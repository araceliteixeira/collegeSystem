//
//  Department.swift
//  College
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Department {
    
    private var departmentId: Int
    private var name: String
    private var head: Employee
    
    init(){
        departmentId = 0
        name = ""
        head = Employee()
    }
    
    init(_ departmentId: Int, _ name: String, _ head: Employee) {
        self.departmentId = departmentId
        self.name = name
        self.head = head
    }
    
    func getDepartmentId() -> Int {
        return departmentId
    }
    func getName() -> String {
        return name
    }
    func getHead() -> Employee {
        return head
    }
    func setDepartmentId(_ departmentId:Int) {
        self.departmentId = departmentId
    }
    func setName(_ name:String) {
        self.name = name
    }
    func setHead(_ head:Employee) {
        self.head = head
    }
}
