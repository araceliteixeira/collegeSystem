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
                if (e.getMainFunction() == Function.Instructor || e.getMainFunction() == Function.Head)  && e.getEndDate().isEmpty {
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
            pickerUser.selectRow(0, inComponent: 0, animated: true)
            selectedUser = users[0]
        } else if pickerView === pickerUser {
            selectedUser = users[row]
        }
    }

    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
    @IBAction func btnEnter(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let profile = profiles[pickerProfile.selectedRow(inComponent: 0)]
        
        switch profile {
        case profiles[0]:
            let navigation = storyBoard.instantiateViewController(withIdentifier: "studentDetailNavigation") as! UINavigationController
            let destination = navigation.topViewController as! StudentViewController
            destination.student = college.getStudent(selectedUser.0)
            destination.college = college
            self.present(navigation, animated:true, completion:nil)
        case profiles[1]:
            let destination = storyBoard.instantiateViewController(withIdentifier: "showReports") as! ReportsPageViewController
            destination.college = college
            self.present(destination, animated:true, completion:nil)
        case profiles[2]:
            let navigation = storyBoard.instantiateViewController(withIdentifier: "instructorDetailNavigation") as! UINavigationController
            let destination = navigation.topViewController as! InstructorViewController
            destination.instructor = college.getEmployee(selectedUser.0)
            destination.college = college
            self.present(navigation, animated:true, completion:nil)
        case profiles[3]:
            for d in college.getDepartments() {
                if d.getHead().getEmployeeId() == selectedUser.0 {
                    let navigation = storyBoard.instantiateViewController(withIdentifier: "departmentDetailNavigation") as! UINavigationController
                    let destination = navigation.topViewController as! DepartmentViewController
                    destination.department = d
                    destination.college = college
                    self.present(navigation, animated:true, completion:nil)
                    break
                }
            }
        case profiles[4]:
            for p in college.getPrograms() {
                if p.getHead().getEmployeeId() == selectedUser.0 {
                    let navigation = storyBoard.instantiateViewController(withIdentifier: "programDetailNavigation") as! UINavigationController
                    let destination = navigation.topViewController as! ProgramViewController
                    destination.program = p
                    destination.college = college
                    self.present(navigation, animated:true, completion:nil)
                    break
                }
            }
        case profiles[5]:
            for c in college.getCourses() {
                if c.getHead().getEmployeeId() == selectedUser.0 {
                    let navigation = storyBoard.instantiateViewController(withIdentifier: "courseDetailNavigation") as! UINavigationController
                    let destination = navigation.topViewController as! CourseViewController
                    destination.course = c
                    destination.college = college
                    self.present(navigation, animated:true, completion:nil)
                    break
                }
            }
        default:
            print("error - identifier not found")
        }
        
    }
}

