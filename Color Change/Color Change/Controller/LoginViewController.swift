//
//  LoginViewController.swift
//  Color Change
//
//  Created by xr on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class LoginViewController: UIViewController {

    
    @IBOutlet weak var m_usernameTxtField: UITextField!
    @IBOutlet weak var m_pwdTxtField: UITextField!
//    @IBOutlet weak var m_formatPwdBtn: UIButton!
    
    let progressHUD = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_usernameTxtField.text = "user2"
        self.m_pwdTxtField.text = "12345"
        
        self.m_usernameTxtField.layer.borderColor = Global.APP_PRIMARY_COLOR.cgColor
        self.m_pwdTxtField.layer.borderColor = Global.APP_PRIMARY_COLOR.cgColor
        
        let text = "Forgot Password?"
        let text_range = NSRange(location: 0, length: text.count)
        let attributtedString = NSMutableAttributedString(string: text)
        attributtedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15.0), range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Global.APP_PRIMARY_COLOR, range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: text_range)
        attributtedString.addAttribute(NSAttributedStringKey.underlineColor, value: Global.APP_PRIMARY_COLOR, range: text_range)
//        self.m_formatPwdBtn.setAttributedTitle(attributtedString, for: .normal)
//        self.m_formatPwdBtn.setAttributedTitle(attributtedString, for: .selected)
    }
    
    
    @IBAction func onLoginBtn(_ sender: UIButton) {
        let device_token = Helper.loadObjectDataToNSUserDefault(forKey: "device_token") as? String ?? ""
        let username = m_usernameTxtField.text
        let password = self.m_pwdTxtField.text
        
        if TextUtils.isEmpty(username) || TextUtils.isEmpty(password) {
            let alertController = UIAlertController(title: "Error", message: "Please input Username or password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        progressHUD.textLabel.text = "Login..."
        progressHUD.show(in: self.view)
        progressHUD.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        
        if TextUtils.isEmpty(device_token) {
            print("Error")
        }
        else {
            let parameters: Parameters =
                [
                    "username" :  username!,
                    "password" : password!,
                    "token" : device_token,
                    "platform" : "iOS"
            ]
            let apiName = Global.SERVER_ADDRESS + Global.LOGIN
            
            Alamofire.request(apiName, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).validate().responseJSON { (response) in
                
                DispatchQueue.main.async {
                    self.progressHUD.dismiss()
                }
                
                switch response.result {
                case .success:
                    
                    let theJSON = response.result.value as! NSDictionary
                    
                    if theJSON["Result"] as! Bool {
                        // Success Code
                        self.performSegue(withIdentifier: "ToHome", sender: nil)
                    } else {
                        // Failure Code
                        let alertController = UIAlertController(title: "Error", message: "Login Fail", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    break
                case .failure:
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Error", message: "Login Fail", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    break
                }
            }
        }
    }
}
