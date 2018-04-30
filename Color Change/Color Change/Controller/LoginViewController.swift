//
//  LoginViewController.swift
//  Color Change
//
//  Created by xr on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var m_usernameTxtField: UITextField!
    @IBOutlet weak var m_pwdTxtField: UITextField!
    @IBOutlet weak var m_formatPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_usernameTxtField.layer.borderColor = Global.APP_PRIMARY_COLOR.cgColor
        self.m_pwdTxtField.layer.borderColor = Global.APP_PRIMARY_COLOR.cgColor
        
        let text = "Forgot Password?"
        let text_range = NSRange(location: 0, length: text.count)
        let attributtedString = NSMutableAttributedString(string: text)
        attributtedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15.0), range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Global.APP_PRIMARY_COLOR, range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.underlineColor, value: Global.APP_PRIMARY_COLOR, range: text_range)
        self.m_formatPwdBtn.setAttributedTitle(attributtedString, for: .normal)
        self.m_formatPwdBtn.setAttributedTitle(attributtedString, for: .selected)
    }
    
    

}
