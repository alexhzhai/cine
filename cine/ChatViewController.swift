//
//  ChatViewController.swift
//  cine
//
//  Created by Alex Zhai and Arya Maheshwari on 4/21/18.
//  Copyright © 2018 cine. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }
    
}


