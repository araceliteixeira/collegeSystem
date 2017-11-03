//
//  CourseViewController.swift
//  CollegeSystem
//
//  Created by Araceli Teixeira on 03/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtCredit: UITextField!
    @IBOutlet weak var txtHead: UITextField!
    @IBOutlet weak var txtProgram: UITextView!
    @IBOutlet weak var txtInstructors: UITextField!
    @IBOutlet weak var txtClasses: UITextField!
    @IBOutlet weak var txtStudents: UITextField!
    
    var course: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtId.delegate = self
        txtCredit.delegate = self
        txtHead.delegate = self
        txtProgram.delegate = self
        txtInstructors.delegate = self
        txtClasses.delegate = self
        txtStudents.delegate = self

        // Do any additional setup after loading the view.
        if let existCourse = course {
            lblCourse.text = existCourse.getName()
            txtId.text = String(existCourse.getCourseId())
            txtCredit.text = String(existCourse.getCreditHour())
            txtHead.text = existCourse.getHead().getName()
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

}
