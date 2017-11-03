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
    
    enum Profile: Int {
        case Student, Instructor, Head, Staff
    }
    
    var profiles: [String] = ["Staff", "Student", "Instructor", "Department Head", "Program Head", "Course Head"]
    var users: [String] = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerProfile.delegate = self
        pickerProfile.dataSource = self
        pickerUser.delegate = self
        pickerUser.dataSource = self
        
    }
    
    func loadUsers(_ profile: String) {
        
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
            return users[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === pickerProfile {
            print(profiles[row])
        } else if pickerView === pickerUser {
            print(users[row])
        }
    }

}

