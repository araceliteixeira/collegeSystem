//
//  DepartmentEmployee.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class DepartmentEmployee {
    
    private var department: Department
    private var employee: Employee
    
    init() {
        department = Department()
        employee = Employee()
    }
    
    init(_ department: Department, _ employee: Employee) {
        self.department = department
        self.employee = employee
    }
    func getDepartment() -> Department {
        return department
    }
    func setDepartment(_ department: Department) {
        self.department = department
    }
    func getEmployee() -> Employee {
        return employee
    }
    func setEmployee(_ employee: Employee) {
        self.employee = employee
    }
}
