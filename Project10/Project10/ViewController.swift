//
//  ViewController.swift
//  Project10
//
//  Created by Faye on 2018/12/4.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openImageLibrary(barBtn:)))
    }
    
    // MARK: - action
    
    @objc func openImageLibrary(barBtn: UIBarButtonItem) {
        
    }


}

