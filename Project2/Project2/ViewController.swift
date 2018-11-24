//
//  ViewController.swift
//  Project2
//
//  Created by Faye on 2018/11/24.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var flagBtn1: UIButton!
    @IBOutlet var flagBtn2: UIButton!
    @IBOutlet var flagBtn3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var countries = [String]()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "score: \(score)"
        }
    }
    var flagBtns = [UIButton]()
    var correctFlagIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        flagBtns += [flagBtn1, flagBtn2, flagBtn3]
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        score = 0
        askQuestion()
        
        for item in flagBtns {
            item.layer.borderColor = UIColor.gray.cgColor
            item.layer.borderWidth = 0.5
        }
    }
    
    private func askQuestion(_ sender: Any! = nil) {
        var selectedCountries = [String]()
        let btnCount = flagBtns.count
        // my way of random country
//        var countriesCopy = countries
//        for i in 0...btnCount - 1 {
//            let item = countriesCopy.randomElement()!
//            countriesCopy.remove(at: countriesCopy.firstIndex(of: item)!)
//            selectedCountries.append(item)
//            let flagBtn = flagBtns[i]
//            flagBtn.setBackgroundImage(UIImage(named: item), for: .normal)
//        }
//        correctFlagIndex = Int(arc4random_uniform(UInt32(btnCount)))
        // Hacking's way
        countries.shuffle()
        for i in 0...btnCount - 1 {
            let item = countries[i]
            selectedCountries.append(item)
            let flagBtn = flagBtns[i]
            flagBtn.setBackgroundImage(UIImage(named: item), for: .normal)
        }
        correctFlagIndex = Int.random(in: 0...btnCount - 1)
        title = selectedCountries[correctFlagIndex].uppercased()
    }
    
    @IBAction func onFlagBtnTouched(_ sender: Any) {
        let flagBtn = sender as! UIButton
        let flagTag = flagBtn.tag
        var title:String
        if flagTag == correctFlagIndex {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .default) {_ in
//            self.askQuestion()
//        }
//        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: askQuestion))
        self.present(alert, animated: true)
    }
}

