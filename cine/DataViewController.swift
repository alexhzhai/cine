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
    
    class JSONData {
        
        let apiID = "f0a08a45c140313b230b94058a0e4cb7"
        let getGenresURL = "https://api.themoviedb.org/3/genre/movie/list?"
        
        var genreList: [String: [Genre]]?
        var movies: [MovieDetailsModel]?
        var apiURL = "https://api.themoviedb.org/3"
        
        
        let group = DispatchGroup()
        var genreIdDictionary : [String: Int] = [:]

        
        init()
        {
            //call discoverMovies
            discoverMovies(apiURL)
        }
        
        func getOfficialGenres() {
            let urlString = getGenresURL + "api_key=\(apiID)"
            print(urlString)
            
            guard let urlGenres = URL(string: urlString) else { return }
            
            group.enter()
            
            //var result : [String: [Genre]] = [:]
            
            URLSession.shared.dataTask(with: urlGenres) { (data, response, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else{ return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    let genreData = try JSONDecoder().decode([String: [Genre]].self, from: data)

                    
                    //ADD DISPATCH QUEUE?
                    print("getting to set genreList")
                    self.genreList = genreData
                    //print(self.genreList)
                    for g in self.genreList!["genres"]! {
                        self.genreIdDictionary[g.getName()] = g.getID()
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                print("getting genres - succeeded")
                self.group.leave()
            }.resume()
        }
        
        // genre format: all integers
        func addGenres(_ genres: [String]) -> String {
            
            //TBD (before this): check whether USER given strings are OFFICIAL or not
            
            var ret = "&with_genres="
            for genreId in genres {
                ret.append("\(genreIdDictionary[genreId]!),")
            }
            ret.remove(at: ret.index(before: ret.endIndex))
            
            return ret
        }
        
        func discoverMovies(_ urlstr: String) {
            
            getOfficialGenres()
            
            group.notify(queue: .main) { //waits until getOfficialGenres completes
                
                //ADD SPECIFICATIONS TO URL HERE: in CORRECT ORDER
                var urlString = urlstr
                urlString.append("/discover/movie?")
                urlString.append("api_key=\(self.apiID)")
                
                //genres specification - SET BASED ON USER INPUT
                var genres = ["Action", "Adventure"] //convert to user input
                urlString.append(self.addGenres(genres))
                print(urlString)
                
                guard let url = URL(string: urlString) else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    
                    guard let data = data else{ return }
                    //Implement JSON decoding and parsing
                    do {
                        //Decode retrived data with JSONDecoder and assing type of Article object
                        
                        let movieData = try JSONDecoder().decode(DisplayPageModel.self, from: data)
                        
                        print("getting to set movieData")
                        self.movies = movieData.getMovieDetails()
                        print(self.movies)
                        
                        //need to dispatch queue stuff? DISPATCH GROUP OR NO?
                        
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                    print("get movies by genre - succeeded")
                    }.resume()
            }
            //IMPLEMENT NEXT PAGE FUNCTIONALITY - TO QUERY WITH GIVEN PAGE
        }
    }
}

