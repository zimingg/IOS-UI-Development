//
//  LoginViewController.swift
//  iOSTest
//
//  Created by App Partner on 1/22/18.
//  Copyright © 2018 AppPartner. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take username and password input from the user using UITextFields
     *
     * 3) Using the following endpoint, make a request to login
     *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
     *    Parameter One: username
     *    Parameter Two: password
     *
     * 4) A valid username is 'AppPartner'
     *    A valid password is 'qwerty'
     *
     * 5) Calculate how long the API call took in milliseconds
     *
     * 6) If the response is an error display the error in a UIAlertView
     *
     * 7) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertView
     *
     * 8) When login is successful, tapping 'OK' in the UIAlertView should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
   
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem?.title = "Back"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        title = "Login"
        styleButton(button: loginButton)
        
        //input padding
        let Upadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.username.frame.height))
        username.leftView = Upadding
        username.leftViewMode = UITextFieldViewMode.always
        let Ppadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.password.frame.height))
        password.leftView = Ppadding
        password.leftViewMode = UITextFieldViewMode.always
    }
    //style function
    func styleButton(button:UIButton){
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
    }
    
    //set the UIAlert
    func alert(title:String, content:String){
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                if title == "Login Successful!"{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    func convertToDictionary(from text: String) throws -> [String: String] {
        guard let data = text.data(using: .utf8) else { return [:] }
        let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String] ?? [:]
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let userName:String = username.text!
        let Password:String = password.text!
        
        let json = "username=\(userName)&password=\(Password)"
        let url = URL(string: "http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        request.httpBody = json.data(using: String.Encoding.utf8);
        //record the current time
        let startTime = Date()
        //call the api
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.alert(title: "Alert" ,content: "Error!")
                })
            }
            else{
                //get success time and convert it to milliseconds
                let Successtime = Date().timeIntervalSince(startTime)
                let sTime = Float(Successtime)*1000
                do{
                    let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
                    do {
                        let dictionary = try self.convertToDictionary(from: outputStr!)
                        //print(dictionary)
                        
                        if dictionary["message"] == "Login Successful!"{
                            //success
                            DispatchQueue.main.async(execute: {
                                self.alert(title: "Login Successful!" ,content: "Time Used: \(sTime) milliseconds。")
                            })
                        }
                        else{
                            //fail
                            DispatchQueue.main.async(execute: {
                                self.alert(title: "Alert" ,content: "Incorrect Username or Password!")
                            })
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        task.resume()
        
    }
}
