//
//  ProgramViewController.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtHead: UITextField!
    @IBOutlet weak var txtCourses: UITextField!
    @IBOutlet weak var txtStudents: UITextField!
    
    var college = College()
    var program: Program?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        navigationItem.titleView = label
        
        if let existProgram = program {
            label.text = existProgram.getName()
            txtId.text = String(existProgram.getProgramId())
            txtDepartment.text = existProgram.getDepartment().getName()
            txtHead.text = existProgram.getHead().getName()
            let courses = college.getCoursesOfProgram(existProgram.getProgramId())
            txtCourses.text = String(courses.count)
            var students = 0
            for c in courses {
                let classes = college.getClassesOfCourse(c.getCourseId())
                for cl in classes {
                    students += college.getStudentsOfClasse(cl.getClasseId()).count
                }
            }
            txtStudents.text = "\(students)"
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
