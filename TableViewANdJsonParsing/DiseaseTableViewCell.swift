//
//  DiseaseTableViewCell.swift
//  TableViewANdJsonParsing
//
//  Created by Nayyer Ali on 1/31/20.
//  Copyright © 2020 Nayyer Ali. All rights reserved.
//

import UIKit

class DiseaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var diseasesTextField: UITextField!
    
    @IBOutlet weak var checkBox: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        diseasesTextField.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
