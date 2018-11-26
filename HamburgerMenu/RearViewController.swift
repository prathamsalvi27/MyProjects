//
//  RearViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 05/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class RearViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openViewBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "openViewOneSegue", sender: self)
        HamburgerMenu().closeSideMenu()

    }
    
    @IBAction func openViewTwoBtnAction(_ sender: UIButton) {
        HamburgerMenu().closeSideMenu()
       self.performSegue(withIdentifier: "openViewOneSegue", sender: self)
        
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
