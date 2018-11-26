//
//  SecondTabViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 24/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class SecondTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func hamburgerBtnAction(_ sender: UIBarButtonItem) {
        HamburgerMenu().triggerSideMenu()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
