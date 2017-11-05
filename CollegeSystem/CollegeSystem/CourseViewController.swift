//
//  CourseViewController.swift
//  CollegeSystem
//
//  Created by Araceli Teixeira on 03/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtCredit: UITextField!
    @IBOutlet weak var txtHead: UITextField!
    @IBOutlet weak var txtProgram: UITextView!
    @IBOutlet weak var txtInstructors: UITextField!
    @IBOutlet weak var txtClasses: UITextField!
    @IBOutlet weak var txtStudents: UITextField!
    
    var college: College = College()
    var course: Course?
    var instructors: [Employee] = []
    var classes: [Classe] = []
    var students: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtProgram.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        self.txtProgram.layer.borderWidth = 0.5
        self.txtProgram.layer.cornerRadius = 5
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        navigationItem.titleView = label

        if let existCourse = course {
            label.text = existCourse.getName()
            txtId.text = String(existCourse.getCourseId())
            txtCredit.text = String(existCourse.getCreditHour())
            txtHead.text = existCourse.getHead().getName()
            txtProgram.text = existCourse.getProgram().getName()
            instructors = college.getInstructorsOfCourse(existCourse.getCourseId())
            txtInstructors.text = String(instructors.count)
            classes = college.getClassesOfCourse(existCourse.getCourseId())
            txtClasses.text = String(classes.count)
            for c in classes {
                students.append(contentsOf: college.getStudentsOfClasse(c.getClasseId()))
            }
            txtStudents.text = String(students.count)
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
