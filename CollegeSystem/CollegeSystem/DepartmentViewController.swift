//
//  DepartmentViewController.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtHead: UITextField!
    @IBOutlet weak var txtPrograms: UITextField!
    @IBOutlet weak var txtInstructors: UITextField!
    @IBOutlet weak var txtStaff: UITextField!
    @IBOutlet weak var txtStudents: UITextField!
    
    var college = College()
    var department: Department?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        navigationItem.titleView = label
        
        if let existDepartment = department {
            label.text = existDepartment.getName()
            txtId.text = String(existDepartment.getDepartmentId())
            txtHead.text = existDepartment.getHead().getName()
            let programs = college.getProgramsOfDepartment(existDepartment.getDepartmentId())
            txtPrograms.text = String(programs.count)
            var instructors = 0
            var students = 0
            for p in programs {
                let courses = college.getCoursesOfProgram(p.getProgramId())
                for c in courses {
                    instructors += college.getInstructorsOfCourse(c.getCourseId()).count
                    let classes = college.getClassesOfCourse(c.getCourseId())
                    for cl in classes {
                        students += college.getStudentsOfClasse(cl.getClasseId()).count
                    }
                }
            }
            txtInstructors.text = "\(instructors)"
            txtStudents.text = "\(students)"
            var staff = 0
            for e in college.getEmployees() {
                if e.getMainFunction() == Function.Staff && college.getDepartmentOfEmployee(e.getEmployeeId()).getDepartmentId() == existDepartment.getDepartmentId() {
                    staff += 1
                }
            }
            txtStaff.text = "\(staff)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
