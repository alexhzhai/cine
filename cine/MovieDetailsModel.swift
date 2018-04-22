//
//  MovieDetailsModel.swift
//  cine
//
//  Created by Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsModel : Decodable {
    var title: String
    var vote_average: Double
    var overview: String
    
    
    func getTitle() -> String {
        return title
    }
    
    func getRating() -> Double {
        return vote_average
    }
    
    func getOverview() -> String {
        return overview
    }
    
}
