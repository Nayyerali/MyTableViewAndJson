//
//  CheckBox.swift
//  TableViewANdJsonParsing
//
//  Created by Nayyer Ali on 2/1/20.
//  Copyright © 2020 Nayyer Ali. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    // images
    let checkedImage = UIImage(named: "Checkmark") as! UIImage
    let UncheckImage = UIImage(named: "Circle") as! UIImage
    
    // bool property
    var isChecked:Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(UncheckImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked", for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
