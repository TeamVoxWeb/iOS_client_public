//
//  MenuManager.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit

class MenuManager: UIView, UIGestureRecognizerDelegate {
    static let sharedInstance = MenuManager()

    @IBOutlet weak var menuBackground: UIView!
    @IBOutlet var logoLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet var contentView:UIView?
    //MARK: - initialisers
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MenuManager", owner: self, options: nil)
        guard let content = contentView else { return }
        self.addSubview(content)
        
        carLabel.font = UIFont.sideBarMenuItem
        carLabel.text = "Cars"
        carLabel.textColor = UIColor.white
            
        otherLabel.font = UIFont.sideBarMenuItem
        otherLabel.text = "Other"
        otherLabel.textColor = UIColor.white5
        
        logoLabel.font = UIFont.logo
        logoLabel.text = "LOGOTEXT"
        logoLabel.textColor = UIColor.white
        
        menuBackground.backgroundColor = UIColor.greyishBrownTwo
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        self.contentView?.addGestureRecognizer(tap)
    }
    
    //MARK: - Menu Actions
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.hideMenu()
    }

    @IBAction func carButtonClicked(_ sender: Any) {
        self.hideMenuWith(navController: Constants.GENERAL.APP_DELEGATE.carListNavController!)
    }
    
    @IBAction func otherButtonClicked(_ sender: Any) {
        self.hideMenuWith(navController: Constants.GENERAL.APP_DELEGATE.otherListNavController!)
    }
    
    func showMenu(){
        
        self.contentView?.frame = CGRect(x: -((self.contentView?.frame.size.width)!), y: 0, width: Constants.GENERAL.SCREEN_SIZE.width, height: Constants.GENERAL.SCREEN_SIZE.height)
        
        Constants.GENERAL.APP_DELEGATE.window?.addSubview(contentView!)
        
        UIView.animate(withDuration: 0.26, delay: 0.0, options: [], animations: {
            self.contentView?.frame.origin.x = 0.0
        }, completion: nil)
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.26, delay: 0.0, options: [], animations: {
            self.contentView?.frame.origin.x = -((self.contentView?.frame.size.width)!)
        }, completion: { (complete: Bool) in
            self.contentView?.removeFromSuperview()
        })
    }
    
    func hideMenuWith(navController: UINavigationController){
        UIView.animate(withDuration: 0.26, delay: 0.0, options: [], animations: {
            self.contentView?.frame.origin.x = -((self.contentView?.frame.size.width)!)
        }, completion: { (complete: Bool) in
            self.contentView?.removeFromSuperview()
        })
        UIView.transition(with: Constants.GENERAL.APP_DELEGATE.window!, duration: 0.26, options: .transitionCrossDissolve, animations: {
            Constants.GENERAL.APP_DELEGATE.window?.rootViewController = navController
        }, completion: nil)

    }
}

