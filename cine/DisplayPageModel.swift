//
//  DisplayPageModel.swift
//  cine
//
//  Created by Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import Foundation

struct DisplayPageModel : Decodable {
    
    var results : [MovieDetailsModel]
    
    func getMovieDetails () -> [MovieDetailsModel] {
        return results
    }
}
