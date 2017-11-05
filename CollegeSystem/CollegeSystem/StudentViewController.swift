//
//  StudentViewController.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtProgram: UITextField!
    @IBOutlet weak var txtStatus: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtCourses: UITextField!
    
    var college = College()
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        navigationItem.titleView = label
        
        if let existStudent = student {
            label.text = existStudent.getName()
            txtId.text = String(existStudent.getStudentId())
            txtCountry.text = String(describing: existStudent.getOriginCountry())
            let studentClasses = college.getStudentClassesOfStudent(existStudent.getStudentId())
            if !studentClasses.isEmpty {
                txtProgram.text = studentClasses[0].getClasse().getCourse().getProgram().getName()
            }
            txtStatus.text = String(describing: existStudent.getStatus())
            txtStartDate.text = existStudent.getStartDate()
            txtEndDate.text = existStudent.getEndDate()
            txtCourses.text = String(studentClasses.count)
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
