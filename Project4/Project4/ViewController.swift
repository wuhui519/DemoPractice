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
    var progressView: UIProgressView!
    var websites = ["https://www.apple.com", "https://3g.163.com/touch/#"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressView = UIProgressView(progressViewStyle: .default)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open URL", style: .plain, target: self, action: #selector(rightBarBtnTapped))
        self.loadReqeust(websites[0])
        
        webView.allowsBackForwardNavigationGestures = true
        // delegate
        webView.navigationDelegate = self
        // KVO
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // toolbar
        let progressItem = UIBarButtonItem(customView: progressView)
        // !!This is new
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refreshBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressItem, flexibleItem, refreshBtn]
        navigationController?.isToolbarHidden = false
    }

    @objc private func rightBarBtnTapped() {
        let alertVC = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        let appleAction = UIAlertAction(title: "apple.com", style: .default) { (_) in
            self.loadReqeust(self.websites[0])
        }
        let neteaseAction = UIAlertAction(title: "163.com", style: .default) { (_) in
            self.loadReqeust(self.websites[1])
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(appleAction)
        alertVC.addAction(neteaseAction)
        alertVC.addAction(cancelAction)
        // used on iPad
        alertVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = webView.url?.host {
            for website in websites {
                if website.contains(url) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.setProgress(Float(webView!.estimatedProgress), animated: true)
        }
    }
}

