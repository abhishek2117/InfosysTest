//
//  ViewController.swift
//  Test
//
//  Created by Champ on 05/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var arrData: [DetailedDescription] = []
    private var tblData: UITableView!
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblData = UITableView(frame: .zero, style: .plain)
        tblData.delegate = self
        tblData.dataSource = self
        tblData.tableFooterView = UIView()
        tblData.separatorInset = .zero
        tblData.register(DetailedDescriptionTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.view.addSubview(tblData)
        
        tblData.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        //Internet check
        if Reachability.isConnectedToNetwork() {
            let hud = UIViewController.displayHUD(self.view)
            Webservice.sharedInstance.loadData { (arrDetailedDescription, title, error) in
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    if let title = title {
                        self.title = title
                    }
                    
                    if let arrDetailedDescriptionTemp = arrDetailedDescription {
                        self.arrData = arrDetailedDescriptionTemp
                        self.tblData.reloadData()
                    }
                    
                    UIViewController.removeHUD(hud)
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
    
    // MARK :- UITableView Delegate & DataSource
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailedDescriptionTableViewCell
        cell.detailedDescription = arrData[indexPath.row]
        return cell
    }
    
}
