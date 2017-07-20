//
//  DashboardSettings+CoreDataProperties.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreData


extension DashboardSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DashboardSettings> {
        return NSFetchRequest<DashboardSettings>(entityName: "DashboardSettings")
    }

    @NSManaged public var pushNotification: Bool
    @NSManaged public var shareOnFacebook: Bool
    @NSManaged public var fontSize: Int32
    @NSManaged public var threads: Int32
    @NSManaged public var showSignatures: Bool
    @NSManaged public var enableLocation: Bool

}

extension DashboardSettings {
    var fontSizeEnum: FontSize {
        get {
            if let size = FontSize(rawValue: fontSize) {
                return size
            }
            
            return .Medium
        }
        
        set {
            fontSize = Int32(newValue.rawValue)
        }
    }
}

extension DashboardSettings {
    var threadsEnum: ThreadValue {
        get {
            if let threds = ThreadValue(rawValue: threads) {
                return threds
            }
            return .ShowNew
        }
        
        set {
            threads = Int32(newValue.rawValue)
        }
    }
}
