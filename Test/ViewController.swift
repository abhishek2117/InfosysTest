//
//  ViewController.swift
//  Test
//
//  Created by Champ on 05/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Internet check
        if Reachability.isConnectedToNetwork() {
            Webservice.sharedInstance.loadData { (arrDetailedDescription, title, error) in
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    if let title = title {
                        self.title = title
                    }
                }
                
            }
        } else {
            let alert = UIAlertController.init(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

