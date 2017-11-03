//
//  ViewController.swift
//  CollegeSystem
//
//  Created by Araceli Teixeira on 03/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerProfile: UIPickerView!
    @IBOutlet weak var pickerUser: UIPickerView!
    
    var college = College()
    
    var profiles: [String] = ["Student", "Staff", "Instructor", "Department Head", "Program Head", "Course Head"]
    var users: [(Int, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerProfile.delegate = self
        pickerProfile.dataSource = self
        pickerUser.delegate = self
        pickerUser.dataSource = self
        
        college.createCollege()
        loadUsers(profiles[0])
    }
    
    func loadUsers(_ profile: String) {
        users = []
        switch profile {
        case "Student":
            for s in college.getStudents() {
                users.append((s.getStudentId(), s.getName()))
            }
        case "Staff":
            for e in college.getEmployees() {
                if e.getMainFunction() == Function.Staff  && e.getEndDate().isEmpty {
                    users.append((e.getEmployeeId(), e.getName()))
                }
            }
        case "Instructor":
            for e in college.getEmployees() {
                if e.getMainFunction() == Function.Instructor  && e.getEndDate().isEmpty {
                    users.append((e.getEmployeeId(), e.getName()))
                }
            }
        case "Department Head":
            for d in college.getDepartments() {
                users.append((d.getHead().getEmployeeId(), d.getHead().getName()))
            }
        case "Program Head":
            for p in college.getPrograms() {
                users.append((p.getHead().getEmployeeId(), p.getHead().getName()))
            }
        case "Course Head":
            for c in college.getCourses() {
                users.append((c.getHead().getEmployeeId(), c.getHead().getName()))
            }
        default:
            print("Invalid profile")
        }
        users = users.sorted(by: {$0.1 < $1.1})
    }

    //MARK: pickerView methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === pickerProfile {
            return profiles.count
        } else if pickerView === pickerUser {
            return users.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === pickerProfile {
            return profiles[row]
        } else if pickerView === pickerUser {
            return users[row].1
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === pickerProfile {
            loadUsers(profiles[row])
            pickerUser.reloadAllComponents()
        } else if pickerView === pickerUser {
            print(users[row].1)
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue \(segue.identifier)")
        let destination = segue.destination as! CourseViewController
        destination.course = college.getCourse(1)
        destination.college = college
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
}

