//
//  ViewController.swift
//  Project7
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    lazy var petitions = [Petitions]()
    lazy var requestUrl = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // MARK: - private
    
    func loadRequest(_ url: String) {
        
    }
    
    // MARK: - tableview delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ps = petitions[tabBarController?.selectedIndex ?? 0]
        return ps.result?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return nil
    }

}

