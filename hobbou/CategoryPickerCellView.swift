//
//  CategoryPickerCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 27/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class CategoryPickerCellView: BaseCell {
    
    let bgImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let iconImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text  = "Title Category in here"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        addSubview(bgImageView)
        addConstraint(format: "H:|-4-[v0]-4-|", views: bgImageView)
        addConstraint(format: "V:|-4-[v0]-4-|", views: bgImageView)
        
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerX, relatedBy: .equal, toItem: bgImageView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: bgImageView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: iconImageView, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    }
    
    func handleSave(){
        print("handlesave")
    }

    
}

