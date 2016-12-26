//
//  MainPageViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet var newDay: UIButton!
    @IBOutlet var passDay: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHight = UIScreen.main.bounds.height
        let buttonHight = newDay.frame.height
        let off:CGFloat = 50
        let y_newDay = screenHight/2 - off - buttonHight
        let y_passDay = screenHight/2
        newDay.frame.origin.y = y_newDay
        passDay.frame.origin.y = y_passDay
        
    }

}
