//
//  DetailViewController.swift
//  Project1
//
//  Created by Faye on 2018/11/23.
//  Copyright © 2018 Faye. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            title = imageToLoad
        }
        navigationItem.largeTitleDisplayMode = .never
        
        // right navigation bar item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBtnTouched))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc private func shareBtnTouched(_ sender: UIBarButtonItem) {
        let activityItems = [imageView.image!]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        activityVC.excludedActivityTypes = [.postToFacebook, .postToTencentWeibo]
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(activityVC, animated: true)
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
