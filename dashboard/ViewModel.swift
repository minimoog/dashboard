////
//  ViewModel.swift
//  dashboard
//
//  Created by Toni Jovanoski on 7/20/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//two enums are ugly here, maybe we can use assosiated value here like
//enum SettingsType {
//  case PushNotification(ItemType: BooleanItem
//...
//}

enum SettingsViewModelItemType {
    case BooleanItem
    case FontItem
    case ThreadsItem
}

enum SettingsType {
    case PushNotification
    case ShareOnFacebook
    case FontSize
    case Threads
    case ShowSignatures
    case EnableLocation
}

protocol SettingsViewModelItem {
    var type: SettingsViewModelItemType { get }
    var name: String { get }
    var settingsType: SettingsType { get }
}

struct BoolItem: SettingsViewModelItem
{
    var type: SettingsViewModelItemType {
        return .BooleanItem
    }
    
    var name: String
    var onoff: Bool
    var settingsType: SettingsType
    
    init(name: String, onoff: Bool, settingsType: SettingsType) {
        self.name = name
        self.onoff = onoff
        self.settingsType = settingsType
    }
}

struct FontItem: SettingsViewModelItem {
    var type: SettingsViewModelItemType {
        return .FontItem
    }
    
    var settingsType: SettingsType
    var name: String { return "Font Size" }
    var fontsize: FontSize
    
    init(fontsize: FontSize, settingsType: SettingsType) {
        self.fontsize = fontsize
        self.settingsType = settingsType
    }
    
    mutating func increaseSize() {
        //uh array of enum ????
        if fontsize == .Small {
            fontsize = .Medium
            return
        }
        
        if fontsize == .Medium {
            fontsize = .Large
            return
        }
        
        if fontsize == .Large {
            fontsize = .Small
            return
        }
    }
}

struct ThreadsItem: SettingsViewModelItem {
    var type: SettingsViewModelItemType {
        return .ThreadsItem
    }
    
    var settingsType: SettingsType
    var name: String { return "Threads" }
    var threadvalue: ThreadValue
    
    init(threadvalue: ThreadValue, settingsType: SettingsType) {
        self.threadvalue = threadvalue
        self.settingsType = settingsType
    }
}

class SettingsViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    var dashBoardSetting: DashboardSettings?
    var items = [SettingsViewModelItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        super.init()
        
        fetchSettings()
        
        if let dashboard = dashBoardSetting {
            let pushNotificationItem = BoolItem(name: "Push Notifications", onoff: dashboard.pushNotification, settingsType: .PushNotification)
            let shareOnFacebookItem = BoolItem(name: "Share on FB", onoff: dashboard.shareOnFacebook, settingsType: .ShareOnFacebook)
            let fontSizeItem = FontItem(fontsize: dashboard.fontSizeEnum, settingsType: .FontSize)
            let showSignaturesItem = BoolItem(name: "Show Signatures", onoff: dashboard.showSignatures, settingsType: .ShowSignatures)
            let enableLocationItem = BoolItem(name: "Enable Locatoin", onoff: dashboard.enableLocation, settingsType: .EnableLocation)
            let threadItem = ThreadsItem(threadvalue: dashboard.threadsEnum, settingsType: .Threads)
            
            items.append(pushNotificationItem)
            items.append(shareOnFacebookItem)
            items.append(fontSizeItem)
            items.append(showSignaturesItem)
            items.append(enableLocationItem)
            items.append(threadItem)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        switch  item.type {
        case .BooleanItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BoolCell.identifier, for: indexPath) as? BoolCell {
                cell.item = item
                
                cell.action = {
                    guard let dashboard = self.dashBoardSetting else {
                        return
                    }
                    
                    switch item.settingsType {
                    case .PushNotification:
                        dashboard.pushNotification = !dashboard.pushNotification
                        self.store()
                    case .ShareOnFacebook:
                        dashboard.shareOnFacebook = !dashboard.shareOnFacebook
                        self.store()
                    case .ShowSignatures:
                        dashboard.showSignatures = !dashboard.showSignatures
                        self.store()
                    case .EnableLocation:
                        dashboard.enableLocation = !dashboard.enableLocation
                        self.store()
                    default:
                        return
                        
                    }
                }
                
                return cell
            }
            
        case .FontItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FontCell.identifier, for: indexPath) as? FontCell {
                cell.item = item
                
                return cell
            }
            
            return UITableViewCell()
            
        case .ThreadsItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ThreadCell.identifier, for: indexPath) as? ThreadCell {
                cell.item = item
                return cell
            }
            
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if var item = items[indexPath.row] as? FontItem {
            if item.settingsType == .FontSize {
                if let cell = tableView.cellForRow(at: indexPath) as? FontCell {
                    item.increaseSize()
                    cell.item = item
                    
                    //tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
                    
                    if let dashboard = dashBoardSetting {
                        dashboard.fontSizeEnum = item.fontsize
                        store()
                    }
                }
            }
            
            return
        }
        
        if var item = items[indexPath.row] as? ThreadsItem {
            if item.settingsType == .Threads {
                if let cell = tableView.cellForRow(at: indexPath) as? ThreadCell {
                }
            }
        }
    }
    
    func store() {
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func fetchSettings() {
        do {
            let ds = try context.fetch(DashboardSettings.fetchRequest())
            dashBoardSetting = ds[0] as! DashboardSettings
        } catch {
            print("Failed")
        }
    }
}
