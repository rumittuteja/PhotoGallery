//
//  ImagesViewController.swift
//  In Class 07
//
//  Created by Rumit Singh Tuteja on 10/26/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Firebase

class ImagesViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{   var arrKeys: [String]!
    var arrImages: [[String :String]]! = []
    let storage = Storage.storage().reference()
    let database = Database.database().reference()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName:"ImageCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "imageCell")
        let uid:String! = Auth.auth().currentUser?.uid
        self.database.child(uid).observe(.value, with: { snapshot in
            print(snapshot.value)
            self.arrImages.removeAll()
            if let arr = snapshot.value as? [String:[String:String]] {
                print(snapshot.value)
                for key in arr.keys {
                    let dictImage = arr[key]
                    self.arrImages.append(dictImage!)
                }
            }
            self.collectionView.reloadData()
            
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let dictImage = self.arrImages[indexPath.item]
        cell.setCellImage(imgURL: dictImage["url"])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = self.view.frame.size.width - 5
        return CGSize(width:dimension / 4.0 - 1, height:dimension / 4.0 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2,left: 2,bottom: 2,right: 2)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let image = info["UIImagePickerControllerOriginalImage"] {
            let imageName = "Image_" + UUID().uuidString + ".png"
            let storageRef = self.storage.child("InClass07_Images").child(imageName)
            let imageData = UIImagePNGRepresentation(image as! UIImage)
            storageRef.putData(imageData!, metadata:nil, completion:{[weak self]
                (metadata,error) in
                let uid = (Auth.auth().currentUser?.uid)!
                let imageID = UUID().uuidString
                self?.database.child(uid).updateChildValues([imageID:["id":imageID,"url":metadata?.downloadURL()?.absoluteString]])
                picker.dismiss(animated: true, completion: nil)
            })
        }
    }
    

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let photoVC = storyboard.instantiateViewController(withIdentifier: "photovc") as! PhotoViewController
        let dict = self.arrImages[indexPath.item]
        photoVC.dictPhoto = dict
        self.navigationController?.pushViewController(photoVC, animated: true)
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
