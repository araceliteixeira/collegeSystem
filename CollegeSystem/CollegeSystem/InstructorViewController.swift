//
//  InstructorViewController.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class InstructorViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtFunction: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtClasses: UITextField!
    @IBOutlet weak var txtStudents: UITextField!
    
    var college = College()
    var instructor: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        navigationItem.titleView = label
        
        if let existInstructor = instructor {
            label.text = existInstructor.getName()
            txtId.text = String(existInstructor.getEmployeeId())
            txtDepartment.text = college.getDepartmentOfEmployee(existInstructor.getEmployeeId()).getName()
            txtFunction.text = String(describing: existInstructor.getMainFunction())
            txtStartDate.text = existInstructor.getStartDate()
            txtEndDate.text = existInstructor.getEndDate()
            let studentClasses = college.getStudentClassesOfInstructor(existInstructor.getEmployeeId())
            txtClasses.text = String(studentClasses.count)
            var students = 0
            for sc in studentClasses {
                students += college.getStudentsOfClasse(sc.getClasse().getClasseId()).count
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
