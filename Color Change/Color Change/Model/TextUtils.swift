//
//  TextUtils.swift
//  Color Change
//
//  Created by xr on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit

class TextUtils: NSObject {

    static func isEmpty(_ text: String?) -> Bool {
        var rslt = true
        if text == nil {
            return rslt
        }
        
        if text?.count == 0 {
            return rslt
        }
        
        rslt = false
        
        return rslt
    }
    
    func stringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd, yyyy HH:mm a"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func dateFromString(_ date_str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MMM-dd, yyyy HH:mm a"
        let date = dateFormatter.date(from: date_str)!
        
        return date
    }
}
