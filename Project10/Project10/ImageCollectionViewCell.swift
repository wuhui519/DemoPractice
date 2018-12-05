//
//  ImageCollectionViewCell.swift
//  Project10
//
//  Created by Faye on 2018/12/5.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
//    var imageItem: ImageItem
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
//
//    init(_ imageItem:ImageItem) {
//        self.imageItem = imageItem
//        super.init(coder: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.imageItem = ImageItem(imagePath: "", imageName: "")
//        super.init(coder: aDecoder)
//    }
    

}

struct ImageItem {
    var imagePath = ""
    var imageName = ""
}
