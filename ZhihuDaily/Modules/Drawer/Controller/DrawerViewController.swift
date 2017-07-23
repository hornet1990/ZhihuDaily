//
//  DrawerViewController.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/5.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import MMDrawerController

class DrawerViewController: MMDrawerController {

    var centerVC: NewsTodayViewController?
    var leftVC: LeftDrawerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftVC = LeftDrawerViewController()
        
        centerVC = NewsTodayViewController()
        let centerNV = UINavigationController(rootViewController: centerVC!)
        self.centerViewController = centerNV
        self.leftDrawerViewController = leftVC
        
        self.shouldStretchDrawer = false
        self.maximumLeftDrawerWidth = 225
        
        self.openDrawerGestureModeMask = .all
        self.closeDrawerGestureModeMask = .all
        // Do any additional setup after loading the view.
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

}
