//
//  ViewController.swift
//  Project10
//
//  Created by Faye on 2018/12/4.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate {
    
    var imageItems = [ImageItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openImageLibrary(barBtn:)))
    }
    
    // MARK: - action
    
    @objc func openImageLibrary(barBtn: UIBarButtonItem) {
        
    }
    
    
    // MARK: - collection delegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        return cell
    }
    
}

