//
//  ViewController.swift
//  HamburgerMenu
//
//  Created by Prathamesh Salvi on 05/10/18.
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var tabbarContainerView: UIView! 
    @IBOutlet weak var sideMenuView: UIView!
    
    //MARK: - Variables
    
    var initialPos: CGPoint?
    var touchPos: CGPoint?
    let blackTransparentViewTag = 02271994
    var openFlag: Bool = false
    
    //MARK: - ViewController Variables
    lazy var frontVC: UIViewController? = {
        let front = self.storyboard?.instantiateViewController(withIdentifier: "FrontTabbar")
        return front
    }()
    
    lazy var rearVC: UIViewController? = {
        let rear = self.storyboard?.instantiateViewController(withIdentifier: "rearVC")
        return rear
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        displayTabbar()
        addShadowToView()
        setUpNotifications()
        setUpGestures()
        
   
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpNotifications(){
        let notificationOpenOrCloseSideMenu = Notification.Name("notificationOpenOrCloseSideMenu")
        NotificationCenter.default.addObserver(self, selector: #selector(openOrCloseSideMenu), name: notificationOpenOrCloseSideMenu, object: nil)
        
        let notificationCloseSideMenu = Notification.Name("notificationCloseSideMenu")
        NotificationCenter.default.addObserver(self, selector: #selector(closeSideMenu), name: notificationCloseSideMenu, object: nil)
        
        let notificationCloseSideMenuWithoutAnimation = Notification.Name("notificationCloseSideMenuWithoutAnimation")
        NotificationCenter.default.addObserver(self, selector: #selector(closeWithoutAnimation), name: notificationCloseSideMenuWithoutAnimation, object: nil)
    }
    
    func setUpGestures(){
        let panGestureContainerView = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        self.view.addGestureRecognizer(panGestureContainerView)
    }

    
    //MARK: - UISetup
    func displayTabbar(){
        // To display Tabbar in TabbarContainerView
        if let vc = frontVC {
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.tabbarContainerView.bounds
            self.tabbarContainerView.addSubview(vc.view)
          
        }
    }
    
    func displaySideMenu(){
        // To display RearViewController in Side Menu View
        if !self.children.contains(rearVC!){
            if let vc = rearVC {
                self.addChild(vc)
                vc.didMove(toParent: self)
                
                vc.view.frame = self.sideMenuView.bounds
                self.sideMenuView.addSubview(vc.view)
              
            }

        }
    }
    
    //MARK: - Shadow View
    func addBlackTransparentView() -> UIView{
        //Black Shadow on MainView(i.e on TabBarController) when side menu is opened.
        let blackView = self.tabbarContainerView.viewWithTag(blackTransparentViewTag)
        if blackView != nil{
            return blackView!
        }else{
            let sView = UIView(frame: self.tabbarContainerView.bounds)
            sView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sView.tag = blackTransparentViewTag
            sView.alpha = 0
            sView.backgroundColor = UIColor.black
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeSideMenu))
            sView.addGestureRecognizer(recognizer)
            return sView
        }
        
        
    }
    
    func addShadowToView(){
        //Gives Illusion that main view is above the side menu
        self.tabbarContainerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.tabbarContainerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.tabbarContainerView.layer.shadowRadius = 1
        self.tabbarContainerView.layer.shadowOpacity = 1
        self.tabbarContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.tabbarContainerView.layer.borderWidth = 0.2
    }
    
   
    
    
    //MARK: - Selector Methods
    @objc func openOrCloseSideMenu(){
        //Opens or Closes Side Menu On Click of Button
        if openFlag{
            //This closes Rear View
            let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
            UIView.animate(withDuration: 0.3, animations: {
                self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
                blackTransparentView?.alpha = 0
                
            }) { (_) in
                blackTransparentView?.removeFromSuperview()
                self.openFlag = false
            }
        }else{
            //This opens Rear View
            UIView.animate(withDuration: 0.0, animations: {
                self.displaySideMenu()
                let blackTransparentView = self.addBlackTransparentView()

                self.tabbarContainerView.addSubview(blackTransparentView)
                
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                
                self.addBlackTransparentView().alpha = self.view.bounds.width * 0.8/(self.view.bounds.width * 1.8)
                self.tabbarContainerView.frame = CGRect(x: self.tabbarContainerView.bounds.size.width * 0.8, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
                    }) { (_) in
                    self.openFlag = true
                    }
            }
            
        }
   
    }
    
    @objc func closeSideMenu(){
        //To close Side Menu
        let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
            UIView.animate(withDuration: 0.3, animations: {
                self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
                blackTransparentView?.alpha = 0.0
                
            }) { (_) in
                blackTransparentView?.removeFromSuperview()
                self.openFlag = false
            }
    
    }
    
    @objc func closeWithoutAnimation(){
        //To close Side Menu without animation
        let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
        blackTransparentView?.alpha = 0
        blackTransparentView?.removeFromSuperview()
       self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
       self.openFlag = false
    }
    
    
    
    //MARK: - Pan Gesture
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer){
        //For Pan Gesture
        
        touchPos = panGesture.location(in: self.view)
        let translation = panGesture.translation(in: self.view)
        
        //Add BlackShadowView
        let blackTransparentView = self.addBlackTransparentView()
        self.tabbarContainerView.addSubview(blackTransparentView)
        
        
        if panGesture.state == .began{
            initialPos = touchPos
        }else if panGesture.state == .changed{
            let touchPosition = self.view.bounds.width * 0.8
            if (initialPos?.x)! > touchPosition && openFlag{
                //To Close Rear View
                if self.tabbarContainerView.frame.minX > 0{
                    self.tabbarContainerView.center = CGPoint(x: self.tabbarContainerView.center.x + translation.x, y: self.tabbarContainerView.bounds.midY)
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                    
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }
            }else if !openFlag{
                //To Open Rear View
                if translation.x > 0.0{
                    displaySideMenu()
                    
                    self.tabbarContainerView.center = CGPoint(x: translation.x + self.tabbarContainerView.center.x, y: self.tabbarContainerView.bounds.midY)
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                    
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }
                
            }
            
        }else if panGesture.state == .ended{
            if self.tabbarContainerView.frame.minX > self.view.frame.midX{
                //Opens Rear View
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.tabbarContainerView.frame = CGRect(x: self.view.frame.width * 0.8, y: 0, width: self.tabbarContainerView.bounds.width, height: self.tabbarContainerView.bounds.height)
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }) { (_) in
                    self.openFlag = true
                }
            }else{
                //Closes Rear View
                UIView.animate(withDuration: 0.2, animations: {
                    self.tabbarContainerView.center = CGPoint(x: self.view.center.x, y: self.tabbarContainerView.bounds.midY)
                    blackTransparentView.alpha = 0
                }) { (_) in
                    blackTransparentView.removeFromSuperview()
                    self.openFlag = false
                   
                }
            }
        }
    }
    
    

}

class HamburgerMenu{
    //Class To Implement Easy Functions To Open Or Close RearView
    //Make object of this class and call functions
    func triggerSideMenu(){
        let notificationOpenOrCloseSideMenu = Notification.Name("notificationOpenOrCloseSideMenu")
        NotificationCenter.default.post(name: notificationOpenOrCloseSideMenu, object: nil)
    }
    
    func closeSideMenu(){
        let notificationCloseSideMenu = Notification.Name("notificationCloseSideMenu")
        NotificationCenter.default.post(name: notificationCloseSideMenu, object: nil)
    }
    
    func closeSideMenuWithoutAnimation(){
        let notificationCloseSideMenuWithoutAnimation = Notification.Name("notificationCloseSideMenuWithoutAnimation")
        NotificationCenter.default.post(name: notificationCloseSideMenuWithoutAnimation, object: nil)
    }
    
}
