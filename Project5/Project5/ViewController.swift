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
    }
    
    @objc private func addBtnTapped() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
            if let text = alert.textFields?.first?.text {
                self.checkResult(text)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - private
    private func loadData() {
        // This is new!!
        let path = Bundle.main.path(forResource: "start", ofType: "txt")!
        let content = try! String(contentsOfFile: path)
        allWords = content.components(separatedBy: CharacterSet.whitespacesAndNewlines)
    }
    
    private func chooseTheWord() {
        if allWords.count > 0 {
            title = allWords.randomElement()
        }
    }
    
    func checkResult(_ result: String) {
        if self.isResultPossible(result) {
            if self.isResultUsed(result) {
                if self.isResultValid(result) {
                    usedWords.append(result)
                    tableView.reloadData()
                }
            }
        }
    }
    
    // letters contain in title
    func isResultPossible(_ result: String) -> Bool {
        var titleString = title!
        for letter in result {
            if let index = titleString.firstIndex(of: letter) {
                titleString.remove(at: index)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isResultUsed(_ result: String) -> Bool {
        return true
    }
    
    func isResultValid(_ result: String) -> Bool {
        return true
    }


}

