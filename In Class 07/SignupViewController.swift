//
//  SignupViewController.swift
//  In Class Assignment 06
//
//  Created by Rumit Singh Tuteja on 10/22/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    @IBOutlet weak var txtFieldPasswod: UITextField!
    
    
    @IBAction func btnCancelSignup(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitAction(_ sender: Any) {
        if validInput() {
            createUser()
        }
    }
    
    
    func createUser(){
        Auth.auth().createUser(withEmail:txtFieldEmail.text!, password:txtFieldPasswod.text!){ (user, error) in
            if error == nil {
                self.pushNotebooksViewController()
            }else {
                self.displayAlert(message: "Couldnt create new user. Please try again", forViewController: self)
            }
        }
    }
    func pushNotebooksViewController(){
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "imagesvc")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
    func validInput() -> Bool{
        if !(txtFieldName.text?.isEmpty)!, let strPassword = txtFieldPasswod.text, let strEmailID = txtFieldEmail.text, let strConfirmPassword = txtFieldConfirmPassword.text {
            if strConfirmPassword == strPassword {
                return true
            }
        }
        displayAlert(message: "Please enter the required details for signing up.", forViewController: self)
        return false
    }
    
    func displayAlert(message:String, forViewController viewController:UIViewController){
        let myAlert = UIAlertController(title:"Details required", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
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
