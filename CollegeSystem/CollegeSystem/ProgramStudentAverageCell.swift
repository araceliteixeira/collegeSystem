//
//  ProgramStudentAverageCell.swift
//  CollegeSystem
//
//  Created by MacStudent on 2017-11-04.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class ProgramStudentAverageCell: UITableViewCell {

    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblStudent: UILabel!
    @IBOutlet weak var lblAverageGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
