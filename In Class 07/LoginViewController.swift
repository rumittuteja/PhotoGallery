//
//  LoginViewController.swift
//  In Class Assignment 06
//
//  Created by Rumit Singh Tuteja on 10/22/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtFieldEmailID: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    func validInput() -> Bool{
        return !((txtFieldEmailID.text?.isEmpty)!) && !((txtFieldPassword.text?.isEmpty)!)
    }
    @IBAction func btnLoginAction(_ sender: Any) {
        if validInput() {
            Auth.auth().signIn(withEmail: txtFieldEmailID.text!, password: txtFieldPassword.text!) { (user, error) in
                if let userauth = user, error == nil {
                    print(user?.uid)
                    self.pushNotebooksViewController()
                }else {
                    self.displayAlert(message: "Couldnt log user in", forViewController: self)
                }
            }
        }else{
            self.displayAlert(message: "Please enter valid credentials to log in.", forViewController: self)

        }
    }
    
     func displayAlert(message:String, forViewController viewController:UIViewController){
        let myAlert = UIAlertController(title:"Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
    }
    
    func pushNotebooksViewController(){
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "imagesvc")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserSessionExists()
    }
    
    func checkIfUserSessionExists(){
        if Auth.auth().currentUser != nil {
            pushNotebooksViewController()
        }else{
            // remain on the same page.
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
