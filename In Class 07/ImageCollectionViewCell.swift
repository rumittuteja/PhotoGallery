//
//  ImageCollectionViewCell.swift
//  In Class 07
//
//  Created by Rumit Singh Tuteja on 10/26/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import AlamofireImage


class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func setCellImage(imgURL:String!){
        imgView.image = nil
        let url = URL(string:imgURL)!
        imgView.af_setImage(withURL: url, placeholderImage: UIImage(named:"300x400-150x150"), filter: nil, progress: nil, progressQueue: DispatchQueue(label: "com.appcoda.myqueue"), imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (resp) in
        })
    }
}
