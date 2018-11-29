//
//  ViewController.swift
//  Project6
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let label1 = initLabel(UIColor.red, text: "THESE")
        let label2 = initLabel(UIColor.cyan, text: "ARE")
        let label3 = initLabel(UIColor.yellow, text: "SOME")
        let label4 = initLabel(UIColor.green, text: "AWESOME")
        let label5 = initLabel(UIColor.orange, text: "LABELS")
        let viewDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        // constraint
        for key in viewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(key)]|", options: [], metrics: nil, views: viewDictionary))
        }
        let metrics = ["labelHeight": 80]
        let format = "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: viewDictionary))
    }
    
    // MARK: - private
    private func initLabel(_ aColor: UIColor, text aText: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = aColor
        label.text = aText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        view.addSubview(label)
        return label
    }


}

