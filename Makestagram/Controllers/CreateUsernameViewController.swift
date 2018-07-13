//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Connie Liu on 7/12/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
           let username = usernameTextField.text,
            !username.isEmpty else {return}
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {return}
            
            //print("Created new user: \(user.username)")
            User.setCurrent(user)

            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let initialViewController = storyboard.instantiateInitialViewController(){
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
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
