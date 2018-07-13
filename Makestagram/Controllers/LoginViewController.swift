//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Connie Liu on 7/10/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        authUI.delegate = self
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        //print("login button clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginViewController: FUIAuthDelegate {
//    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
//        if let error = error {
//            assertionFailure("Error signing in: \(error.localizedDescription)")
//            return
//        }
//        print("handle user signup / login")
//    }
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        guard let user = authDataResult?.user
            else {return}
        let userRef = Database.database().reference().child("users").child(user.uid)
        
//        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let user = User(snapshot: snapshot) {
//                print("Welcome back, \(user.username).")
//            } else {
//                print("New user!")
//            }
//        })
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let user = User(snapshot: snapshot) {
//                print("Welcome back, \(user.username).")
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let user = User(snapshot: snapshot) {
//                User.setCurrent(user)
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User (snapshot: snapshot){
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    //self.view.window?.makeKeyAndVisible()
                }
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
                })
          }
}
