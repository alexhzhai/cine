//
//  Genre.swift
//  cine
//
//  Created by Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import Foundation
import UIKit

struct Genre : Decodable {
    var name: String
    var id: Int
    
    init(_ n: String, _ i: Int) {
        name = n
        id = i
    }
    
    func getName() -> String {
        return name
    }
    
    func getID() -> Int {
        return id
    }

}
