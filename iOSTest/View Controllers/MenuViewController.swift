//
//  MenuViewController.swift
//  iOSTest
//
//  Created by App Partner on 1/22/18.
//  Copyright © 2018 AppPartner. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - App Partner
     * =========================================================================================
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!

    
    
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coding Tasks"
        //styling button
        styleButton(button: chatButton)
        styleButton(button: loginButton)
        styleButton(button: animationButton)
        //set background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_home_menu.png")!)
    
    }
    //styling button function
    func styleButton(button:UIButton){
        button.layer.cornerRadius = 28
        button.layer.borderWidth = 0
    }
    
    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
}
