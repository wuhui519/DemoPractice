//
//  Petition.swift
//  Project7
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit

//class Petition: NSObject {
//
//}

//struct Petition {
//    var body: String
//    var title: String
//    var url: String
//}
//
//extension Petition {
//    init(json: [String: Any]) {
//        if let aBody = json["body"] as? String {
//            body = aBody
//        } else {
//            body = ""
//        }
//        if let aTitle = json["title"] as? String {
//            title = aTitle
//        } else {
//            title = ""
//        }
//        if let aUrl = json["url"] as? String {
//            url = aUrl
//        } else {
//            url = ""
//        }
//    }
//}


struct Petition: Codable {
    var body: String
    var title: String
    var signatureCount: Int
}
