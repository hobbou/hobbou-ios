//
//  ContentDetailCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 11/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class RelatedVideoCell: BaseCell {
    
//    var video: Video? {
//        didSet {
//            if let thumbnailImageName = video?.thumbnail_image_name {
//                thumbnailImageView.loadImageForUrlString(thumbnailImageName)
//            }
//            
//            titleLabel.text = video?.title
//            
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            let numViews = formatter.string(from: video!.number_of_views!)
//            userNameAndViewsLabel.text = "\(video!.channel!.name!)\n\(numViews!) views"
//        }
//    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Color.grey.darken2
        return label
    }()
    
    let userNameAndViewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Color.grey.darken2
        label.numberOfLines = 2
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(separatorView)
        addSubview(userNameAndViewsLabel)
        
        let width = 16 / 9 * (frame.height-16)
        addConstraint(format: "H:|-16-[v0(\(width))]-8-[v1]-16-|", views: thumbnailImageView, titleLabel)
        
        addConstraint(format: "H:|[v0]|", views: separatorView)
        
        addConstraint(format: "V:|[v0]-16-[v1(1)]|", views: thumbnailImageView, separatorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 14))
        
        addConstraint(format: "H:|-\(16 + width + 8)-[v0]-16-|", views: userNameAndViewsLabel)
        
        addConstraint(NSLayoutConstraint(item: userNameAndViewsLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: userNameAndViewsLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
}

class VideoDetailHeader: BaseCell {
    
//    var video: Video? {
//        didSet {
//            
//            if let v = video {
//                let attributedText = NSMutableAttributedString(string: v.title!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.rgb(16, green: 16, blue: 16)])
//                
//                let formatter = NumberFormatter()
//                formatter.numberStyle = .decimal
//                let numViews = formatter.string(from: v.number_of_views!)
//                attributedText.append(NSAttributedString(string: "\n\(numViews!) views", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(129, green: 129, blue: 129)]))
//                
//                titleTextView.attributedText = attributedText
//                
//                if let profileImageName = video?.channel?.profile_image_name {
//                    userImageView.loadImageForUrlString(profileImageName)
//                }
//                
//                if let user = v.channel {
//                    let userAttributedText = NSMutableAttributedString(string: user.name!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.rgb(16, green: 16, blue: 16)])
//                    
//                    let formatter = NumberFormatter()
//                    formatter.numberStyle = .decimal
//                    let numViews = formatter.string(from: v.number_of_views!)
//                    userAttributedText.append(NSAttributedString(string: "\n\(numViews!) subscribers", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(129, green: 129, blue: 129)]))
//                    
//                    userTextView.attributedText = userAttributedText
//                    
//                }
//            }
//            
//        }
//    }
    
    let titleTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Title"
        tv.backgroundColor = UIColor.clear
        tv.isEditable = false
        return tv
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 19
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let middleSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let userTextView: UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "subscribe")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Subscribe", for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleTextView)
        addSubview(separatorView)
        addSubview(userImageView)
        addSubview(middleSeparatorView)
        addSubview(userTextView)
        addSubview(subscribeButton)
        
        let containerView = UIView()
        addSubview(containerView)
        
        
        addConstraint(format: "H:|-8-[v0]-32-|", views: titleTextView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "H:|[v0]|", views: middleSeparatorView)
        
        addConstraint(format:"V:|[v0]-8-[v1(34)]-8-[v2(1)]-8-[v3(38)]-8-|", views: titleTextView, containerView, middleSeparatorView, userImageView)
        
        addConstraint(format: "V:[v0(1)]|", views: separatorView)
        
        addConstraint(format: "H:|-16-[v0]|", views: containerView)
        addConstraint(format: "H:|-12-[v0(38)]-[v1]-8-[v2(110)]|", views: userImageView, userTextView, subscribeButton)
        
        addConstraint(format: "V:[v0(40)]-12-|", views: userTextView)
        addConstraint(format: "V:[v0(40)]-8-|", views: subscribeButton)
        
    }
    
}

class CommentsHeader: BaseCell {
    
//    var video: Video? {
//        didSet {
//            if let count = video?.comments?.count {
//                titleLabel.text = "COMMENTS • \(count)"
//            }
//        }
//    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMENTS • 7"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(separatorView)
        
        addConstraint(format: "H:|-16-[v0]|", views: titleLabel)
        addConstraint(format: "V:|[v0]|", views: titleLabel)
        
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:[v0(1)]|", views: separatorView)
    }
    
}

class CommentCell: BaseCell {
    
//    var comment: Comment? {
//        didSet {
//            
//            textView.attributedText = comment?.attributedText()
//            
//            if let profileImageName = comment?.channel?.profile_image_name {
//                userImageView.loadImageForUrlString(profileImageName)
//            }
//        }
//    }
    
    let textView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        
        addSubview(textView)
        addSubview(userImageView)
        addSubview(separatorView)
        
        addConstraint(format: "H:|-16-[v0(50)]-4-[v1]|", views: userImageView, textView)
        addConstraint(format: "V:|-8-[v0(50)]", views: userImageView)
        addConstraint(format: "V:|[v0][v1(1)]|", views: textView, separatorView)
        
        addConstraint(format: "H:|-8-[v0]-8-|", views: separatorView)
    }
    
}


