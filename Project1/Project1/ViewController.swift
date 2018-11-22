//
//  ViewController.swift
//  Project1
//
//  Created by Faye on 2018/11/21.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.starts(with: "nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
}

