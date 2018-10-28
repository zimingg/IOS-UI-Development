//
//  AnimationViewController.swift
//  iOSTest
//
//  Created by App Partner on 1/22/18.
//  Copyright © 2018 AppPartner. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should spin when the user hits the spin button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    @IBOutlet var spinButton: UIButton!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var firework: UIImageView!
    
    
    
    
    var position = CGPoint(x: 0, y: 0)
    var speed: Float = 0.0
    var count = 0
    var buttonTittle = "Faster"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Back"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        title = "Animation"
        styleButton(button: spinButton)
    }
    
    //spin function
    func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 1.0, speed: Float) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * speed)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        imageView.layer.add(rotateAnimation, forKey: nil)
    }
    
    
    //touch move functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        position = touch.location(in: self.view)
        logo.center = position
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        position = touch.location(in: self.view)
        logo.center = position
    }
    
    //button style functon
    func styleButton(button:UIButton){
        button.layer.cornerRadius = 23
        button.layer.borderWidth = 0
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressSpinButton(_ sender: Any) {
        speed+=2.0
        count+=1
        if (count<4){
            buttonTittle+="!"
            rotateAnimation(imageView: logo, speed: speed)
            spinButton.setTitle(buttonTittle, for: .normal)
        }
        else if count == 4{
            spinButton.setTitle("Fireworks Next", for: .normal)
        }
        else if count == 5{
            view.backgroundColor = UIColor.black
            firework.loadGif(name: "giphy")
            spinButton.setTitle("Back", for: .normal)
        }
        else{
            let mainMenuViewController = MenuViewController()
            self.navigationController?.pushViewController(mainMenuViewController, animated: true)
        }
    }
}
