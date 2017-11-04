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
    var selectedUser: (Int, String) = (0, "")
    
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
            selectedUser = users[row]
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        print("prepare for segue \(identifier)")
        
        switch identifier {
        case "courseDetail":
            for c in college.getCourses() {
                if c.getHead().getEmployeeId() == selectedUser.0 {
                    let destination = segue.destination as! CourseViewController
                    destination.course = c
                    destination.college = college
                }
            }
        case "programDetail":
            for p in college.getPrograms() {
                if p.getHead().getEmployeeId() == selectedUser.0 {
                    let destination = segue.destination as! ProgramViewController
                    destination.program = p
                    destination.college = college
                    break
                }
            }
        case "departmentDetail":
            for d in college.getDepartments() {
                if d.getHead().getEmployeeId() == selectedUser.0 {
                    let destination = segue.destination as! DepartmentViewController
                    destination.department = d
                    destination.college = college
                }
            }
        case "studentDetail":
            let destination = segue.destination as! StudentViewController
            destination.student = college.getStudent(selectedUser.0)
            destination.college = college
        case "instructorDetail":
            let destination = segue.destination as! InstructorViewController
            destination.instructor = college.getEmployee(selectedUser.0)
            destination.college = college
        case "showReports":
            let destination = segue.destination as! CourseViewController
            destination.course = college.getCourse(selectedUser.0)
            destination.college = college
        default:
            print("error - identifier not found")
        }
        
        
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
}

