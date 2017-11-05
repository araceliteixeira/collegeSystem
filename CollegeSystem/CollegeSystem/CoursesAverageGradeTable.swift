//
//  CoursesAverageGradeTable.swift
//  CollegeSystem
//
//  Created by Araceli Teixeira on 05/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class CoursesAverageGradeTable: UITableViewController {

    var data: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.text = "Top 3 courses with worst average grades"
        navigationItem.titleView = label
        
        let collegeReports = CollegeReports()
        data = collegeReports.coursesByWorstAverageReport()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesAverageGradeCell", for: indexPath) as? CoursesAverageGradeCell {
            let cellData = data[indexPath.row]
            cell.lblCourse.text = cellData.0
            cell.lblAverageGrade.text = cellData.1
            return cell
        } else {
            fatalError("The dequeued cell is not an instance of CoursesAverageGradeCell")
        }
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
