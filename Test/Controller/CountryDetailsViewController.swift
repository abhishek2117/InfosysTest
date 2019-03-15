//
//  ViewController.swift
//  Test
//
//  Created by Champ on 05/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import SnapKit

class CountryDetailsViewController: UIViewController {
    
    private var arrayCountryDetials: [CountryDetails] = []
    
    var tblData: UITableView!
    
    static let tblEstimateHeight: CGFloat = 70.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblData = UITableView(frame: .zero, style: .plain)
        tblData.delegate = self
        tblData.dataSource = self
        tblData.tableFooterView = UIView()
        tblData.separatorInset = .zero
        tblData.register(CountryDetailsTableViewCell.self, forCellReuseIdentifier: CountryDetailsTableViewConstant.countryCellIdentifier)
        self.view.addSubview(tblData)
        
        tblData.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(fetchDataFromServer)
        )
        
        fetchDataFromServer()
    }
    
    @objc func fetchDataFromServer() {
        //Internet check
        if Reachability.isConnectedToNetwork() {
            let hud = UIViewController.displayHUD(self.view)
            WebService.sharedInstance.loadData { (arrDetailedDescription, title, error) in
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    if let title = title {
                        self.title = title
                    }
                    
                    if let arrDetailedDescriptionTemp = arrDetailedDescription {
                        self.arrayCountryDetials = arrDetailedDescriptionTemp
                        self.tblData.reloadData()
                    }
                    
                    UIViewController.removeHUD(hud)
                }
            }
        } else {
            let alert = UIAlertController.init(title: Constant.noInternetConnectionAlertTitle, message: Constant.internetConnectionAlertMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: Constant.internetConnectionAlertOkButtonTitle, style: .default) { (action:UIAlertAction) in
                
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension CountryDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CountryDetailsViewController.tblEstimateHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CountryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCountryDetials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryDetailsTableViewConstant.countryCellIdentifier, for: indexPath) as! CountryDetailsTableViewCell
        cell.imgMedia.image = UIImage(named: CountryDetailsTableViewConstant.countryDetailsTableViewCellPlaceholder)
        cell.countryDetail = arrayCountryDetials[indexPath.row]
        return cell
    }
    
}
