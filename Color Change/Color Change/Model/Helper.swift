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
    
    static func loadObjectDataToNSUserDefault(forKey: String) -> NSObject? {
        var loadObject:NSObject? = nil
        let userDefaults = UserDefaults.standard
        let data = userDefaults.data(forKey: forKey)
        if data != nil {
            loadObject = NSKeyedUnarchiver.unarchiveObject(with: data!) as? NSObject
        }
        
        return loadObject
    }
    
    static func setBrightness(value: CGFloat) {
        UIScreen.main.brightness = value
    }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
