//
//  FontCell.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import UIKit

func enumToSize(fontsize: FontSize) -> CGFloat {
    switch fontsize {
    case .Small:
        return 10
    case .Medium:
        return 15
    case .Large:
        return 20
    }
}

class FontCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var fontSize: UILabel!
    
    var item: SettingsViewModelItem? {
        didSet {
            guard let item = item as? FontItem else {
                return
            }
            
            name?.text = item.name
            
            fontSize?.text = "A"
            fontSize?.font = fontSize?.font.withSize(enumToSize(fontsize: item.fontsize))
        }
    }
    
    
    static var identifier: String {
        return String(describing: self)
    }
}

