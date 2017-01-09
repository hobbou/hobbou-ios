//
//  SearchCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 9/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class SearchCell: BaseCell {
    
    let searchContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    override func setupViews() {
        addSubview(searchContentView)
        addSubview(separatorView)
        addConstraint(format: "H:|-4-[v0]-4-|", views: searchContentView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|-4-[v0]-4-[v1(1)]|", views: searchContentView, separatorView)
        
        searchContentView.addSubview(thumbnailImageView)
        searchContentView.addSubview(titleLabel)
        searchContentView.addSubview(subtitleTextView)
        searchContentView.addSubview(moreButton)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: searchContentView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .left, relatedBy: .equal, toItem: searchContentView, attribute: .left, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 77))
        //width constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 77))
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: searchContentView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
    }
    
    func handleMore(){
        print("handlemore")
    }
    
}
