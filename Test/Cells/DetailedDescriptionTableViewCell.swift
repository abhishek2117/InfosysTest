//
//  DetailedDescriptionTableViewCell.swift
//  Test
//
//  Created by Abhishek Rathore on 06/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class DetailedDescriptionTableViewCell: UITableViewCell {
    
    let imgMedia:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 25
        img.image = UIImage(named: "placeholder")
        img.clipsToBounds = true
        return img
    }()
    
    let lblTitle:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let lblDesc:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        self.contentView.addSubview(imgMedia)
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(lblDesc)
        
        imgMedia.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self.contentView)
        }
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10.0)
            make.left.equalTo(imgMedia.snp.left).offset(60.0)
            make.right.equalTo(self.contentView).offset(-10.0)
        }
        
        lblDesc.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(20.0)
            make.top.equalTo(lblTitle.snp.bottom).offset(5.0)
            make.left.equalTo(imgMedia.snp.left).offset(60.0)
            make.right.equalTo(self.contentView).offset(-10.0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var detailedDescription: DetailedDescription? {
        didSet {
            
            guard let detailedDescriptionItem = detailedDescription else {
                return
            }
            
            lblTitle.text = detailedDescriptionItem.title
            lblDesc.text = detailedDescriptionItem.description
            imgMedia.loadImage(urlString: detailedDescriptionItem.mediaPath)
        }
    }
}
