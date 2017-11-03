//
//  CollegeReports.swift
//  College
//
//  Created by MacStudent on 2017-10-11.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation

class CollegeReports {
    private var college: College
    
    init() {
        college = College()
        college.createCollege()
    }
    
    /*
     - Instructors by classes and average student grades
     
     SELECT e.name as 'Instructor',
     cl.class_id as 'Class ID',
     co.name as 'Course',
     (AVG(sc.grade_assig + sc.grade_test + sc.grade_project)) DIV 3 as 'Average Grade'
     FROM employee e INNER JOIN class cl ON (e.employee_id = cl.instructor_id)
     INNER JOIN student_class sc ON (sc.class_id = cl.class_id)
     INNER JOIN course co ON (cl.course_id = co.course_id)
     WHERE sc.grade_project is not null
     GROUP BY e.employee_id, cl.class_id, co.name;
    */
    func instructorsByClasses() -> String {
        var report = Util.pad("Instructor", 18) + " | " + Util.pad("Class Id",10) + " | " + Util.pad("Course", 40) + " | Average Grade\n"
        for c in college.getClasses() {
            if getAverageGradeOfClasse(c) != 0 {
                let instructor = c.getInstructor().getName()
                let classId = c.getClasseId()
                let course = c.getCourse().getName()
                let average = getAverageGradeOfClasse(c)
                report += Util.pad(instructor, 18) + " | " + Util.pad(classId, 10) + " | " + Util.pad(course, 40) + " | \(average) \n"
            }
        }
        return report
    }
    
    func getAverageGradeOfClasse(_ classe: Classe) -> Int {
        var sum = 0
        var count = 0
        for sc in college.getStudentClasses() {
            if sc.getClasse().getClasseId() == classe.getClasseId() {
                if sc.getGradeAssig() != nil && sc.getGradeTest() != nil && sc.getGradeProject() != nil {
                    sum += (sc.getGradeAssig()! + sc.getGradeTest()! + sc.getGradeProject()!) / 3
                    count += 1
                }
            }
        }
        if count == 0 {
            return 0
        }
        return sum / count
    }
    
    /*
     - Number of students by country
     
     SELECT c.name as 'Country',
     COUNT(s.student_id) as 'Number of Students'
     FROM country c INNER JOIN student s ON (c.country_id = s.origincountry_id)
     GROUP BY c.country_id
     ORDER BY count(s.student_id) DESC;

    */
    func studentsByCountry() -> String {
        var report = Util.pad("Country", 15) + "| Number of Students\n"
        var countries: [Country] = []
        for s in college.getStudents() {
            if !countries.contains(s.getOriginCountry()) {
                countries.append(s.getOriginCountry())
            }
        }
        for c in countries {
            var count = 0
            for s in college.getStudents() {
                if s.getOriginCountry() == c {
                    count += 1
                }
            }
            report += Util.pad(String(describing: c), 15) + "| \(count)\n"
        }
        return report
    }
    
    /*
     - Top 3 courses with worst average grades
     
     SELECT co.name as 'Course',
     AVG(sc.grade_assig + sc.grade_test + sc.grade_project) DIV 3 as Grade
     FROM course co INNER JOIN class cl ON (co.course_id = cl.course_id)
     INNER JOIN student_class sc ON (cl.class_id = sc.class_id)
     WHERE sc.grade_project is not null
     GROUP BY co.course_id
     ORDER BY Grade ASC
     LIMIT 3;
    */
    func coursesByWorstAverage() -> String {
        var report = Util.pad("Course", 40) + "| Grade\n"
        var elements: [(Course, Int)] = []
        for c in college.getCourses() {
            elements.append((c, getAverageGradeOfClassesInCourse(c)))
        }
        elements = elements.sorted(by: {$0.1 < $1.1})
        report += Util.pad(elements[0].0.getName(), 40) + "| \(elements[0].1)\n"
        report += Util.pad(elements[1].0.getName(), 40) + "| \(elements[1].1)\n"
        report += Util.pad(elements[2].0.getName(), 40) + "| \(elements[2].1)\n"
        return report
    }
    
    func getAverageGradeOfClassesInCourse(_ course: Course) -> Int {
        var sum = 0
        var count = 0
        for sc in college.getStudentClasses() {
            if sc.getClasse().getCourse().getCourseId() == course.getCourseId() {
                if sc.getGradeAssig() != nil && sc.getGradeTest() != nil && sc.getGradeProject() != nil {
                    sum += (sc.getGradeAssig()! + sc.getGradeTest()! + sc.getGradeProject()!) / 3
                    count += 1
                }
            }
        }
        if count == 0 {
            return 0
        }
        return sum / count
    }
    
    /*
     - Number of classes per instructor per weekday
     
     SELECT e.name as 'Instructor',
     sd.weekday as 'Weekday',
     count(cl.class_id) as 'Number of classes'
     FROM employee e
     INNER JOIN class cl ON (e.employee_id = cl.instructor_id)
     INNER JOIN schedule sd ON (cl.class_id = sd.class_id)
     WHERE sd.start_date >= '2017-09-01' AND sd.end_date <= '2017-12-31'
     GROUP BY e.employee_id, sd.weekday
     ORDER BY count(cl.class_id);
    */
    func classesByInscructorsPerWeek() -> String  {
        var report = Util.pad("Instructor", 18) + " | " + Util.pad("Weekday",12) + " | Number of classes\n"
        for i in college.getEmployees() {
            for e in schedulesPerInstructor(i) {
                report += Util.pad(i.getName(), 18) + " | " + Util.pad(e.0, 12) + " |  \(e.1)\n"
            }
        }
        return report
    }
    
    func schedulesPerInstructor(_ instructor: Employee) -> [(String, Int)] {
        var elements: [(String, Int)] = []
        for s in college.getSchedules() {
            if s.getClasse().getInstructor().getEmployeeId() == instructor.getEmployeeId() {
                var count = 1
                if let index = elements.index(where: {$0.0 == s.getWeekday()}) {
                    let e = elements.remove(at: index)
                    count += e.1
                }
                elements.append((s.getWeekday(), count))
                
            }
        }
        return elements
    }
    
    /*
     - Top student with best average grade by program
     
     SELECT t.Program, t.Student, MAX(t.Grade) as 'Best Average Grade'
     FROM (
     SELECT p.name as Program,
     st.name as Student,
     AVG(sc.grade_assig + sc.grade_test + sc.grade_project) DIV 3 as Grade
     FROM program p
     INNER JOIN course co ON (p.program_id = co.program_id)
     INNER JOIN class cl ON (co.course_id = cl.course_id)
     INNER JOIN student_class sc ON (cl.class_id = sc.class_id)
     INNER JOIN student st ON (st.student_id = sc.student_id)
     GROUP BY p.program_id, st.student_id
     ORDER BY Grade DESC
     ) t
     GROUP BY t.Program;
    */
    func studentsByBestAverage() -> String {
        var report = Util.pad("Program", 20) + "| " + Util.pad("Student", 20) + "| Best Average Grade\n"
        for p in college.getPrograms() {
            var elements = getAverageGradeOfEachSudentInProgram(p).sorted(by: {$0.1 > $1.1})
            report += Util.pad(p.getName(), 20) + "| " + Util.pad(elements[0].0.getName(), 20) + "| \(elements[0].1)\n"
        }
        return report
    }

    func getAverageGradeOfEachSudentInProgram(_ program: Program) -> [(Student, Int)] {
        var elements: [(Student, Int)] = []
        for s in college.getStudents() {
            var student: Student?
            var sum = 0
            var count = 0
            for sc in college.getStudentClasses() {
                if sc.getClasse().getCourse().getProgram().getProgramId() == program.getProgramId()
                    && sc.getStudent().getStudentId() == s.getStudentId() {
                    student = s
                    if sc.getGradeAssig() != nil && sc.getGradeTest() != nil && sc.getGradeProject() != nil {
                        sum += (sc.getGradeAssig()! + sc.getGradeTest()! + sc.getGradeProject()!) / 3
                        count += 1
                    }
                    
                }
            }
            if student != nil {
                var element = (student!, 0)
                if count != 0 {
                    element.1 = sum / count
                }
                elements.append(element)
            }
        }
        return elements
    }

}
