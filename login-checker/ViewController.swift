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
    @IBOutlet weak var loginCountTextField: UILabel!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var loginTimerLabel: UILabel!
    
    let maxLoginCount = 5
    var currentLoginCount = 0
    var loginTimeoutCountdown = 10
    
    var timer = Timer()
    
    func counter() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: false)
        
        loginTimeoutCountdown -= 1
        
        loginTimerLabel.text = ("Please wait for \(loginTimeoutCountdown) seconds before re-attempting login")
        
        if (loginTimeoutCountdown == 0) {
            timer.invalidate()
            loginCountTextField.text = ("Re-attempt login")
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
            loginButtonOutlet.isEnabled = true
            loginTimerLabel.text = ""
            loginTimeoutCountdown = 10
            currentLoginCount = 0
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        loginCheck()
    }
    
    func checkLoginCount() {
        if (currentLoginCount < maxLoginCount) {
            
        } else {
            loginCountTextField.text = ("Max login attempts exhausted")
            emailTextField.isEnabled = false
            passwordTextField.isEnabled = false
            loginButtonOutlet.isEnabled = false
            
            counter()
        }
    }
    
    func loginCheck() {
        
        let username = "bobbychan@cdnis.edu.hk"
        let password = "12345"
        
        if (emailTextField.text != username || passwordTextField.text != password) {
            currentLoginCount += 1
            loginCountTextField.text = ("Invalid username or password: \(currentLoginCount) of \(maxLoginCount) attempts")
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
