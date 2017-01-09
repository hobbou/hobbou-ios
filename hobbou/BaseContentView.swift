//
//  ContentBaseView.swift
//  hobbou
//
//  Created by Hans Yonathan on 6/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class VideoContentView: BaseContentView {
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let playImage = UIImage(named: "Circled Play Filled-100")
        button.setImage(playImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    func handlePlayPause(){
        print("handlepause")
    }
    
    override func setupViews() {
        addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}

class BaseContentView: UIView {
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.alpha = 0
        return view
    }()
    
    let lengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "05:00"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Plus Math Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        addSubview(thumbnailImageView)
        
        addConstraint(format: "H:|[v0]|", views: thumbnailImageView)
        //vertical constraints
        addConstraint(format: "V:|[v0]|", views: thumbnailImageView)
        
        addSubview(containerView)
        //top constraint
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: 1, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: thumbnailImageView, attribute: .width, multiplier: 1, constant: 0))
        
        addSubview(lengthLabel)
        //top constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: -4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
        containerView.addSubview(userProfileImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleTextView)
        containerView.addSubview(moreButton)
        containerView.addSubview(saveButton)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        //width constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: -4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        //width constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    func handleMore(){
        print("handleMore")
    }
    
    func handleSave(){
        print("handleSave")
    }
    
}
