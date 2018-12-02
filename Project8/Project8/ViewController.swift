//
//  ViewController.swift
//  Project8
//
//  Created by Faye on 2018/12/2.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cluesLabel: UILabel!
    @IBOutlet var answersLabel: UILabel!
    @IBOutlet var currentAnswer: UITextField!
    @IBOutlet var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var answers = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1 {
        didSet {
            loadContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This is new!!
        for subview in view.subviews where subview.tag == 1001 {
            let button = subview as! UIButton
            letterButtons.append(button)
            button.addTarget(self, action: #selector(letterTapped(_:)), for: .touchUpInside)
        }
        
        loadContent()
    }
    
    // MARK: - private
    
    private func loadContent() {
        if let path = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            // HA|UNT|ED: Ghosts in residence
            var letterBits = [String]()
            var clues = [String]()
            let content = try! String(contentsOfFile: path)
            let words = content.components(separatedBy: "\n")
            for (index, word) in words.enumerated() {
                let components = word.components(separatedBy: ":")
                let wordPart = components.first!
                let cluePart = "\(index + 1).\(components.last!)"
                let bits = wordPart.components(separatedBy: "|")
                letterBits += bits
                let solutionWord = wordPart.replacingOccurrences(of: "|", with: "")
                solutions.append(solutionWord)
                answers.append("\(solutionWord.count) letters")
                clues.append(cluePart)
            }
            cluesLabel.text = clues.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
            answersLabel.text = answers.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
            letterBits.shuffle()
            for (index, bit) in letterBits.enumerated() {
                let button = letterButtons[index]
                button.setTitle(bit, for: .normal)
            }
        }
    }
    
    func levelUp(_ alert: UIAlertAction) {
        solutions.removeAll()
        answers.removeAll()
        for button in letterButtons {
            button.isHidden = false
        }
        level += 1
    }
    
    // MARK: - action
    
    @objc func letterTapped (_ sender: UIButton) {
        activatedButtons.append(sender)
        sender.isHidden = true
        let word = currentAnswer.text! + sender.title(for: .normal)!
        currentAnswer.text = word
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        let answer = currentAnswer.text!
        if let index = solutions.index(of: answer) {
            activatedButtons.removeAll()
            answers.remove(at: index)
            answers.insert(answer, at: index)
            answersLabel.text = answers.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            
            if score % answers.count == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
        currentAnswer.text = ""
    }
}

