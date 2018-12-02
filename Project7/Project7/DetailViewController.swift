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
    
    var webview: WKWebView!
    var petition: Petition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webview = WKWebView(frame: view.bounds)
        self.view.addSubview(webview!)
        guard let petition = petition else { return }
        title = petition.title
//        let html = "<html><body>" +
//            "<h1>\(petition.title)</h1><h2>\(petition.body)</h2>" +
//        "</body></html>";
        let html = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <style>body {font-size: 130%;}</style>
                </head>
                <body>
                    <h2>\(petition.title)</h2>
                    \(petition.body)
                </body>
            </html>
        """
        webview.loadHTMLString(html, baseURL: nil)
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
