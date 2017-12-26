//
//  PhotoViewController.swift
//  In Class 07
//
//  Created by Rumit Singh Tuteja on 10/26/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class PhotoViewController: UIViewController {
    var dictPhoto:[String:String]!
    @IBOutlet weak var imgView: UIImageView!
    let database = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:dictPhoto["url"]!)
        imgView.af_setImage(withURL: url!, placeholderImage: UIImage(named:"300x400-150x150"), filter: nil, progress: nil, progressQueue: DispatchQueue(label: "com.appcoda.myqueue"), imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (resp) in
        })
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func deleteImageAction(_ sender: Any) {
       
        let alertController = UIAlertController(title: "Photo Delete", message: "Do you want to delete this photo?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] (_ action: UIAlertAction) -> Void in
            let imgID = self?.dictPhoto["id"]
            self?.database.child((Auth.auth().currentUser?.uid)!).child(imgID!).removeValue(completionBlock: { (error, database) in
                self?.navigationController?.popViewController(animated: true)
            })
        })
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            print("Cancelled")
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: { _ in })
    }
    
    
    func popViewController(){
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
