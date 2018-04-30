//
//  UtliManager.swift
//  Color Change
//
//  Created by Josh on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit

class Helper: NSObject {

    //MARK: - Save and Load NSObject Data through NSUserDefault
    static func saveObjectDataToNSUserDefault(saveObject: NSObject, forKey: String){
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: saveObject)
        userDefaults.set(encodedData, forKey: forKey)
    }
    
    static func loadObjectDataToNSUserDefault(forKey: String) -> NSObject{
        var loadObject:NSObject? = nil
        let userDefaults = UserDefaults.standard
        let data = userDefaults.data(forKey: forKey)
        if data != nil {
            loadObject = NSKeyedUnarchiver.unarchiveObject(with: data!) as? NSObject
        }
        
        return loadObject!
    }
}
