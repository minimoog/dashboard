//
//  BoolCell.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import UIKit

class BoolCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var action: (() -> ())? = nil
    
    var item: SettingsViewModelItem? {
        didSet {
            guard let item = item as? BoolItem else {
                return
            }
            
            name?.text = item.name
            
            toggleButton?.isSelected = item.onoff
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBAction func onClicked(_ sender: Any) {
        toggleButton?.isSelected = !toggleButton.isSelected
        
        if let saction = action {
            saction()
        }
    }
}
