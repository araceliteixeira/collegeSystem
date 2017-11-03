//
//  Classe.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class Classe {
    
    private var classeId: Int
    private var course: Course
    private var instructor: Employee
    
    init(){
        classeId = 0
        course = Course()
        instructor = Employee()
    }
    
    init(_ classeId: Int, _ course: Course, _ instructor: Employee) {
        self.classeId = classeId
        self.course = course
        self.instructor = instructor
    }
    
    func getClasseId() -> Int {
        return classeId
    }
    func setClasseId(_ classeId: Int) {
        self.classeId = classeId
    }
    func getCourse() -> Course {
        return course
    }
    func setCourse(_ course: Course) {
        self.course = course
    }
    func getInstructor() -> Employee {
        return instructor
    }
    func setInstructor(_ instructor: Employee) {
        self.instructor = instructor
    }
}
