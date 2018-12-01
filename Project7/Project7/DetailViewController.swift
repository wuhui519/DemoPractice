//
//  DetailViewController.swift
//  Project7
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webview: WKWebView?
    var body: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webview = WKWebView(frame: view.bounds)
        self.view .addSubview(webview!)
        if let aBody = body {
            if let aTitle = title {
                let string = "<html><body>" +
                    "<h1>\(aTitle)</h1><h2>\(aBody)</h2>" +
                "</body></html>";
                webview?.loadHTMLString(string, baseURL: nil)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
