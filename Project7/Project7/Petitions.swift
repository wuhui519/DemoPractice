//
//  Petitions.swift
//  Project7
//
//  Created by Faye on 2018/11/29.
//  Copyright © 2018 CMCC. All rights reserved.
//

import UIKit

//class Petitions: NSObject {
//    var results: [Petition]?
//}

//struct Petitions {
//    let results: [Petition]
//}
//
//extension Petitions {
//    init(json: [String: Any]) {
//        if let aResult = json["results"] as? [Any] {
//            var computedResults = [Petition]()
//            for item in aResult {
//                if let itemMap = item as? [String: Any] {
//                    let petition = Petition(json: itemMap)
//                    computedResults.append(petition)
//                }
//            }
//            results = computedResults
//        } else {
//            results = []
//        }
//    }
//}

struct Petitions: Codable {
    var results: [Petition]
}
