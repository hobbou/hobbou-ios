//
//  CategoryPickerCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 27/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class CategoryPickerCellView: PickerSecondDimensionCellView {
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        button.setTitleColor(.white, for: .normal)
        button.setTitle("More...", for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = 17
        button.addTarget(self, action: #selector(handleCategMore), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    func handleCategMore(){
        print("Handle categ more..")
        let sectionPickerViewController = SectionPickerViewController()
        let appPicker = AppCategoryPickerNavigationBarController(rootViewController: sectionPickerViewController)
        appPicker.titleLabel.text = "Section"
        //categoryPickerViewController.appMenuController = self
        categoryPickerViewController?.present(appPicker
            , animated: true, completion: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(moreButton)
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: bgImageView, attribute: .height, multiplier: 0, constant: 33))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: bgImageView, attribute: .width, multiplier: 0, constant: 88))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .centerX, relatedBy: .equal, toItem: bgImageView, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
}

class SectionPickerCellView: PickerSecondDimensionCellView {
    
}

class PickerSecondDimensionCellView: BaseCell {
    
    var categoryPickerViewController: CategoryPickerViewController?
    
    
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
    
}

