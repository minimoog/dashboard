//
//  DashboardSettings+CoreDataClass.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreData

enum FontSize: Int32 {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum ThreadValue: Int32 {
    case ShowNew = 0
    case ShowOld = 1
    case ShowAll = 2
}

public class DashboardSettings: NSManagedObject {

}
