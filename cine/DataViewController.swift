//
//  DataViewController.swift
//  cine
//
//  Created by Alex Zhai and Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    var knowsGenre = false
    
    @IBAction func respondYesGenre(_ sender: UIButton) {
        knowsGenre = true
        
    }
    
    @IBAction func respondNoGenre(_ sender: UIButton) {
        knowsGenre = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var jdata = JSONData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    struct JSONData {
        
        let apiID = "f0a08a45c140313b230b94058a0e4cb7"
        
        var apiURL = "https://api.themoviedb.org/3"
        
        init()
        {
            //call discoverMovies
            discoverMovies(apiURL)
        }
        
        // genre format: all integers
        func addGenres(_ genres: [Int]) -> String {
            
            //TBD: get OFFICIAL list of genres for movies (and check whether text is one of them) - then convert String to Int
            
            var ret = "&with_genres="
            for genreId in genres {
                ret.append("\(genreId),")
            }
            ret.remove(at: ret.index(before: ret.endIndex))
            
            return ret
        }
        
        mutating func discoverMovies(_ urlstr: String) {
            
            //ADD SPECIFICATIONS TO URL HERE: in CORRECT ORDER
            var urlString = urlstr
            urlString.append("/discover/movie?")
            urlString.append("api_key=\(apiID)")
            
            //genres specification - SET BASED ON USER INPUT
            var genres = [28, 12] //convert to user input
            urlString.append(addGenres(genres))
            print(urlString)
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else
                {
                    return
                }
                
                print("succeeded")
                }.resume()
        }
        
    }

}

