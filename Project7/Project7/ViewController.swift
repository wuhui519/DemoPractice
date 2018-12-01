//
//  ViewController.swift
//  Project7
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    lazy var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabTapped()
        title = self.tabBarController?.selectedIndex == 0 ? "Most Recent" : "Top Rated"
    }
    
    // MARK: - private
    
    func tabTapped() {
        // if data has been loaded, do nothing
        if petitions.count > 0 {
            return
        }
        let currentTabIndex = self.tabBarController?.selectedIndex ?? 0
        let urlString: String
        switch currentTabIndex {
        case 0:
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        default:
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        loadRequest(urlString)
    }
    
    func loadRequest(_ urlString: String) {
        // progressing...
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = navigationController!.view.center
        activityIndicator.style = .whiteLarge
        activityIndicator.backgroundColor = UIColor.gray
        navigationController?.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        // reload data
        let url = URL(string: urlString)!
        let urlSessionConfig = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration: urlSessionConfig)
        let task = urlSession.dataTask(with: url) {[unowned self] (data, response, error) in
            if let d = data {
                let json = try? JSONSerialization.jsonObject(with: d, options: [])
                if let jsonMap = json as? [String: Any] {
                    let ps = Petitions(json: jsonMap)
                    self.petitions = ps.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        activityIndicator.stopAnimating()
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - tableview delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Petition", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petition = petitions[indexPath.row]
        let vc = DetailViewController()
        vc.title = petition.title
        vc.body = petition.body
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

