//
//  ViewController.swift
//  Project4
//
//  Created by Faye on 2018/11/25.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open URL", style: .plain, target: self, action: #selector(rightBarBtnTapped))
        self.loadReqeust("https://baidu.com")
        
        // delegate
        webView.navigationDelegate = self
        // KVO
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }

    @objc private func rightBarBtnTapped() {
        let alertVC = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        let appleAction = UIAlertAction(title: "apple.com", style: .default) { (_) in
            self.loadReqeust("https://www.apple.com")
        }
        let neteaseAction = UIAlertAction(title: "163.com", style: .default) { (_) in
            self.loadReqeust("https://3g.163.com/touch/#")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(appleAction)
        alertVC.addAction(neteaseAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func loadReqeust(_ urlString: String) {
        progressView.progress = 0
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
    }
    
    // Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.setProgress(Float(webView!.estimatedProgress), animated: true)
        }
    }
    

    @IBAction func refreshBtnTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
}

