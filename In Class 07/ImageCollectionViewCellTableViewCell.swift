//
//  ImageCollectionViewCellTableViewCell.swift
//  In Class 07
//
//  Created by Rumit Singh Tuteja on 10/26/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCollectionViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCellImage(imgURL:String!){
            let url = URL(string:imgURL)!
            imgView.af_setImage(withURL: url, placeholderImage: UIImage(named:"feed-placeholder"), filter: nil, progress: nil, progressQueue: DispatchQueue(label: "com.appcoda.myqueue"), imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (resp) in
            })
    }
    
}
