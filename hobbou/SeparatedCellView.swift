//
//  SearchCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 9/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class SeparatedListContentBaseCell: BaseCell {
    
    let contentSeparatedView: UIView = {
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
    
    let lengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "05:00"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 6)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text = "Title in here..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.text = "Channel name"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let contentViewsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "200k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let contentBouLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "255k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let contentDateAgoLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "2 days ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let contentViewsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Play-104")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    let contentBouImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Christmas Star-96")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    let contentCalendarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Calendar-96")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()    
    
    override func setupViews() {
        addSubview(contentSeparatedView)
        addSubview(separatorView)
        addConstraint(format: "H:|-4-[v0]-4-|", views: contentSeparatedView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0]-4-[v1(1)]|", views: contentSeparatedView, separatorView)
        
        contentSeparatedView.addSubview(thumbnailImageView)
        contentSeparatedView.addSubview(titleLabel)
        contentSeparatedView.addSubview(channelLabel)
        contentSeparatedView.addSubview(moreButton)
        contentSeparatedView.addSubview(contentViewsImageView)
        contentSeparatedView.addSubview(contentViewsLabel)
        contentSeparatedView.addSubview(contentBouImageView)
        contentSeparatedView.addSubview(contentBouLabel)
        contentSeparatedView.addSubview(contentCalendarImageView)
        contentSeparatedView.addSubview(contentDateAgoLabel)
        
        contentSeparatedView.addSubview(lengthLabel)
        //top constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: -4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 11))
        //width constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .top, relatedBy: .equal, toItem: contentSeparatedView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .left, relatedBy: .equal, toItem: contentSeparatedView, attribute: .left, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 154))
        //width constraint
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 154))
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))

        //top constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .centerY, relatedBy: .equal, toItem: contentViewsLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .left, relatedBy: .equal, toItem: channelLabel, attribute: .left, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .top, relatedBy: .equal, toItem: channelLabel, attribute: .bottom, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .left, relatedBy: .equal, toItem: contentViewsImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .centerY, relatedBy: .equal, toItem: contentBouLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .left, relatedBy: .equal, toItem: contentViewsLabel, attribute: .right, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .top, relatedBy: .equal, toItem: channelLabel, attribute: .bottom, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .left, relatedBy: .equal, toItem: contentBouImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .centerY, relatedBy: .equal, toItem: contentDateAgoLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .left, relatedBy: .equal, toItem: channelLabel, attribute: .left, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.7, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .top, relatedBy: .equal, toItem: contentBouLabel, attribute: .bottom, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .left, relatedBy: .equal, toItem: contentCalendarImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: contentSeparatedView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
    }
    
    func handleMore(){
        print("handlemore")
    }
    
}

class SearchCell: SeparatedListContentBaseCell {
    
}

class MoreContentCell: SeparatedListContentBaseCell {
    
}

class HoBCell: SeparatedListContentBaseCell {
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "#1"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 6)
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(rankLabel)
        //top constraint
        addConstraint(NSLayoutConstraint(item: rankLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: rankLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: rankLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: rankLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
    }
    
}
