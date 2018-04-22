//
//  DataViewController.swift
//  cine
//
//  Created by Alex Zhai and Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var genreText: UITextField!
    
    var genre : String? = ""
    var dataObject : String = ""
    
    @IBAction func respondYesGenre(_ sender: UIButton)  {
        print("yes genre called")
    }
    @IBAction func respondNoGenre(_ sender: UIButton) {
        print("no genre called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        genre = genreText.text
        textField.resignFirstResponder()
        print(genre)
        return true
    }
    
    
//    @IBOutlet weak var genreText: UITextField! {
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool{
//            genre = genreText.text
//            textField.resignFirstResponder()
//            return true
//        }
//    }
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
        var apiURL = "https://api.themoviedb.org/3"
        
        init()
        {
            //call discoverMovies
            discoverMovies(apiURL)
        }
        
        func getOfficialGenres() {
            let urlString = getGenresURL + "api_key=\(apiID)"
            print(urlString)
            
            guard let urlGenres = URL(string: urlString) else { return }
            
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
                    print(self.genreList)
                    

                } catch let jsonError {
                    print(jsonError)
                }
                
                print("getting genres - succeeded")
                
            }.resume()
            
            //return result
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
        
        func discoverMovies(_ urlstr: String) {
            
            //ADD SPECIFICATIONS TO URL HERE: in CORRECT ORDER
            var urlString = urlstr
            urlString.append("/discover/movie?")
            urlString.append("api_key=\(apiID)")
            
            getOfficialGenres()
            
            //genres specification - SET BASED ON USER INPUT
            var genres = [28, 12] //convert to user input
            urlString.append(addGenres(genres))
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
                    
                    //TBD: ADD . . . .
                    
                    //need to dispatch queue stuff?
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                print("get movies by genre - succeeded")
                }.resume()
        }
        
    }

}

