//
//  FrontViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 05/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideHamburger))
//        
//        self.view.addGestureRecognizer(tapGesture)
        
    }
        
    @IBAction func hamburgerBtnAction(_ sender: UIBarButtonItem) {
      HamburgerMenu().triggerSideMenu()
    }
    
    @objc func hideHamburger(){
        HamburgerMenu().closeSideMenu()
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
