//
//  ThreadCell.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import UIKit

func fromThreadValueToString(threadValue: ThreadValue) -> String {
    switch threadValue {
    case .ShowNew:
        return "Show New"
    case .ShowOld:
        return "Show Old"
    case .ShowAll:
        return "Show All"
    }
}

class ThreadCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let threads: [ThreadValue] = [.ShowNew, .ShowOld, .ShowAll]
    var item: SettingsViewModelItem? {
        didSet {
            guard let item = item as? ThreadsItem else {
                return
            }
            
            name?.text = item.name
            textField?.text = fromThreadValueToString(threadValue: item.threadvalue)
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fromThreadValueToString(threadValue: threads[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return threads.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = fromThreadValueToString(threadValue: threads[row])
    }
}
