//
//  ViewController.swift
//  Project5
//
//  Created by Faye on 2018/11/27.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    // lazy init
    lazy var textCheck = UITextChecker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        chooseTheWord()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(replayBtnTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
    }
    
    // MARK: - tableView delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    // MARK: - action
    @objc private func replayBtnTapped() {
        chooseTheWord()
        usedWords.removeAll()
        tableView.reloadData()
    }
    
    @objc private func addBtnTapped() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        // This is new!! -- unowned
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [unowned self, alert] (_) in
            if let text = alert.textFields?.first?.text {
                self.checkResult(text)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - private
    private func loadData() {
        // This is new!!
        let path = Bundle.main.path(forResource: "start", ofType: "txt")!
        if let content = try? String(contentsOfFile: path) {
            allWords = content.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        } else {
            allWords = ["silkworm"]
        }
    }
    
    private func chooseTheWord() {
        if allWords.count > 0 {
            title = allWords.randomElement()
        }
    }
    
    func checkResult(_ result: String) {
        let lowerResult = result.lowercased()
        if isResultPossible(lowerResult) {
            if isResultOriginal(lowerResult) {
                if isResultValid(lowerResult) {
                    usedWords.append(result)
                    tableView.insertRows(at: [IndexPath(row: usedWords.count - 1, section: 0)], with: .automatic)
                } else {
                    showAlert(title: "Word not recognized", message: "You can't just make them up, you know!")
                }
            } else {
                showAlert(title: "Word used already", message: "Be more original!")
            }
        } else {
            showAlert(title: "Word not possible", message: "You can't spell that word from '\(title!)'!")
        }
    }
    
    func showAlert(title aTitle:String, message aMessage:String) {
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion:nil)
    }
    
    // letters contain in title
    func isResultPossible(_ result: String) -> Bool {
        var titleString = title!
        for letter in result {
            // my way of computing word in title
//            if let index = titleString.firstIndex(of: letter) {
//                titleString.remove(at: index)
            // their way
            if let range = titleString.range(of: String(letter)) {
                titleString.remove(at: range.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func isResultOriginal(_ result: String) -> Bool {
        return !usedWords.contains(result)
    }
    
    func isResultValid(_ result: String) -> Bool {
        // why result.utf16?
        // Swift strings count things like emoji as 1-letter strings, but UTF-16 considers them to be 2-letter strings.
        // This means if you use count with UIKit methods, you run the risk of miscounting the string length.
        let range = NSMakeRange(0, result.utf16.count)
        let misspelledRange = textCheck.rangeOfMisspelledWord(in: result, range: range, startingAt: 0, wrap: true, language: "en")
        return misspelledRange.location == NSNotFound
    }


}

