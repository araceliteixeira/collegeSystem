//
//  GradeAux.swift
//  CollegeProject
//
//  Created by MacStudent on 2017-10-06.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class GradeAux {
    
    private var gradeAuxId: Int
    private var letter: String
    private var pointsStart: Int
    private var pointsEnd: Int
    
    init(){
        gradeAuxId = 0
        letter = ""
        pointsStart = 0
        pointsEnd = 0
    }
    
    init(_ gradeAuxId: Int, _ letter: String, _ pointsStart: Int, _ pointsEnd: Int) {
        self.gradeAuxId = gradeAuxId
        self.letter = letter
        self.pointsStart = pointsStart
        self.pointsEnd = pointsEnd
    }
    
    func getGradeAuxId() -> Int {
        return gradeAuxId
    }
    func getLetter() -> String {
        return letter
    }
    func getPointsStart() -> Int {
        return pointsStart
    }
    func getPointsEnd() -> Int {
        return pointsEnd
    }
    func setGradeAuxId(_ gradeAuxId:Int) {
        self.gradeAuxId = gradeAuxId
    }
    func setLetter(_ letter:String) {
        self.letter = letter
    }
    func setPointsStart(_ pointsStart:Int) {
        self.pointsStart = pointsStart
    }
    func setPointsEnd(_ pointsEnd:Int) {
        self.pointsEnd = pointsEnd
    }
}

class Grade {
    static let grades: [GradeAux] = [
        GradeAux(1, "A+", 94, 100),
        GradeAux(2, "A", 87, 93),
        GradeAux(3, "A-", 80, 86),
        GradeAux(4, "B+", 77, 79),
        GradeAux(5, "B", 73, 76),
        GradeAux(6, "B-", 70, 72),
        GradeAux(7, "C+", 67, 69),
        GradeAux(8, "C", 63, 66),
        GradeAux(9, "C-", 60, 62),
        GradeAux(10, "D", 50, 59),
        GradeAux(11, "F", 0, 49),
        ]
    static func getLetter(_ grade: Int) -> String {
        var letter = ""
        for g in grades {
            if grade >= g.getPointsStart() && grade <= g.getPointsEnd() {
                letter = g.getLetter()
            }
        }
        return letter
    }
    static func getAverageGrade(_ letter: String) -> Int {
        var grade = 0
        for g in grades {
            if letter == g.getLetter() {
                grade = (g.getPointsStart() + g.getPointsEnd()) / 2
            }
        }
        return grade
    }
}



