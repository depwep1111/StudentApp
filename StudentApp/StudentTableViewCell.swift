//
//  StudentTableViewCell.swift
//  StudentApp
//
//  Created by Cntt06 on 5/10/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelSchool: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var imgStudent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
