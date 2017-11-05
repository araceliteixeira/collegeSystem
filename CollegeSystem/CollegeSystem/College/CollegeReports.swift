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
    func instructorsByClassesReport() -> [(String, String, String, String)] {
        var report: [(String, String, String, String)] = []
        for c in college.getClasses() {
            if getAverageGradeOfClasse(c) != 0 {
                let instructor = c.getInstructor().getName()
                let classId = c.getClasseId()
                let course = c.getCourse().getName()
                let average = getAverageGradeOfClasse(c)
                report.append((instructor, String(classId), course, "\(average)"))
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
    func studentsByCountryReport() -> [(String, String)] {
        var report: [(String, String)] = []
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
            report.append((String(describing: c), "\(count)"))
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
    func coursesByWorstAverageReport() -> [(String, String)] {
        var report: [(String, String)] = []
        var elements: [(Course, Int)] = []
        for c in college.getCourses() {
            elements.append((c, getAverageGradeOfClassesInCourse(c)))
        }
        elements = elements.sorted(by: {$0.1 < $1.1})
        report.append((elements[0].0.getName(), "\(elements[0].1)"))
        report.append((elements[1].0.getName(), "\(elements[1].1)"))
        report.append((elements[2].0.getName(), "\(elements[2].1)"))
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
    func classesByInscructorsPerWeekReport() -> [(String, String, String)]  {
        var report: [(String, String, String)] = []
        for i in college.getEmployees() {
            for e in schedulesPerInstructor(i) {
                report.append((i.getName(), e.0, "\(e.1)"))
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
    func studentsByBestAverageReport() -> [(String, String, String)] {
        var report: [(String, String, String)] = []
        for p in college.getPrograms() {
            var elements = getAverageGradeOfEachSudentInProgram(p).sorted(by: {$0.1 > $1.1})
            report.append((p.getName(), elements[0].0.getName(), "\(elements[0].1)"))
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
