//
//  HomeViewController.swift
//  Color Change
//
//  Created by xr on 4/30/18.
//  Copyright © 2018 Josh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackgroundColor(_:)), name: NSNotification.Name(rawValue: Global.COLOR_CHANGE), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func changeBackgroundColor(_ notification: Notification) {
        if let color_value = notification.userInfo?["color"] as? String {
            let color = UIColor(hexString: color_value) ?? UIColor.white
            self.view.backgroundColor = color
            
            Helper.setBrightness(value: 1.0)
        }
    }
}

