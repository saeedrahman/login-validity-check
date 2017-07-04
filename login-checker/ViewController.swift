//
//  ViewController.swift
//  login-checker
//
//  Created by Saeed Rahman on 01/07/2017.
//  Copyright © 2017 Beardy Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    // Maximum number of login attempts
    let maxLoginCount = 5
    
    // Number of failed login attempts
    var currentLoginCount = 0
    
    // Upon reaching maxLoginCount attempts, input fields are disabled and countdown initiates
    var loginTimeoutCountdown = 10
    
    // Global access Timer()
    var timer = Timer()
    
    // Initiates timer, and decrements loginTimeoutCountdown by 1. If loginTimeoutCountdown is equal to '0', all input fields and login button is re-enabled.
    func counter() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: false)
        
        loginTimeoutCountdown -= 1
        
        loginStatusLabel.text = ("Please wait for \(loginTimeoutCountdown) seconds before re-attempting login")
        
        if (loginTimeoutCountdown == 0) {
            timer.invalidate()
            loginStatusLabel.text = ("Re-attempt login")
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
            loginButtonOutlet.isEnabled = true
            loginButtonOutlet.setTitle("LOGIN", for: .normal)

            
            loginStatusLabel.text = ""
            loginTimeoutCountdown = 10
            currentLoginCount = 0
        }
    }
    
    // Runs the loginCheck function
    @IBAction func loginButton(_ sender: Any) {
        loginCheck()
    }
    
    // Check number of failed login attempts, and disable input when maxLoginCount limit is reached
    func checkLoginCount() {
        if (currentLoginCount < maxLoginCount) {
            
        } else {
            emailTextField.isEnabled = false
            passwordTextField.isEnabled = false
            loginButtonOutlet.isEnabled = false
            loginButtonOutlet.setTitle("LOGIN DISABLED", for: .normal)
            
            counter()
        }
    }
    
    // Check login credentials, and show second VC if login successful
    
    func loginCheck() {
        
        let username = "bobbychan@cdnis.edu.hk"
        let password = "12345"
        
        if (emailTextField.text != username || passwordTextField.text != password) {
            currentLoginCount += 1
            loginStatusLabel.text = ("Invalid username or password: \(currentLoginCount) of \(maxLoginCount) attempts")
            checkLoginCount()
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginSuccessVC")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
