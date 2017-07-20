//
//  ViewController.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel =  SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 140
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

