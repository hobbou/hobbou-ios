//
//  ContentDetailCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 11/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class RelatedVideoCell: SeparatedListContentBaseCell {
    
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
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Description in here"
        tv.backgroundColor = UIColor.clear
        tv.isEditable = false
        return tv
    }()
    
    let userImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .green
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
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        return label
    }()
    
    let subscriptionTotalLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "subscribe")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Subscribe", for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(descriptionTextView)
        addSubview(separatorView)
        addSubview(middleSeparatorView)

        let containerView = UIView()
        addSubview(containerView)
        containerView.addSubview(userImageView)
        containerView.addSubview(subscribeButton)
        containerView.addSubview(userLabel)
        containerView.addSubview(subscriptionTotalLabel)
        
        addConstraint(format: "H:|-8-[v0]-32-|", views: descriptionTextView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "H:|[v0]|", views: middleSeparatorView)
        
        addConstraint(format:"V:|[v0]-8-[v1(1)]-8-[v2]-8-|", views: descriptionTextView, middleSeparatorView, containerView)
        
        addConstraint(format: "V:[v0(1)]|", views: separatorView)
        
        addConstraint(format: "H:|-8-[v0]-8-|", views: containerView)
        addConstraint(format: "H:|-8-[v0(44)]-[v1]-8-[v2(110)]-8-|", views: userImageView, userLabel, subscribeButton)
        
        addConstraint(format: "V:|[v0(20)]-4-[v1(20)]|", views: userLabel, subscriptionTotalLabel)
        addConstraint(format: "V:|[v0(44)]|", views: subscribeButton)
        addConstraint(format: "V:|[v0(44)]|", views: userImageView)
        
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .width, relatedBy: .equal, toItem: userLabel, attribute: .width, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .left, relatedBy: .equal, toItem: userLabel, attribute: .left, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .right, relatedBy: .equal, toItem: userLabel, attribute: .right, multiplier: 1, constant: 0))
        
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

class CommentCell: BaseCommentCell {
    
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
    

    override func handleMore() {
        print("handleMore")
    }
    
    override func setupViews() {
        addSubview(commentContainerView)
        addSubview(separatorView)
        addConstraint(format: "H:|[v0]|", views: commentContainerView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0]-2-[v1(1)]|", views: commentContainerView, separatorView)
        commentContainerView.addSubview(userProfileImageView)
        commentContainerView.addSubview(descriptionLabel)
        commentContainerView.addSubview(subtitleLabel)
        commentContainerView.addSubview(moreButton)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .top, relatedBy: .equal, toItem: commentContainerView, attribute: .top, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .left, relatedBy: .equal, toItem: commentContainerView, attribute: .left, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 33))
        //width constraint
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 33))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: commentContainerView, attribute: .right, multiplier: 1, constant: -4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 14))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 14))
        //width constraint
        //addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .width, relatedBy: .equal, toItem: descriptionLabel, attribute: .width, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: subtitleLabel, attribute: .top, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .left, relatedBy: .equal, toItem: subtitleLabel, attribute: .right, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: descriptionLabel, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: subtitleLabel, attribute: .height, multiplier: 1, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: subtitleLabel, attribute: .height, multiplier: 1, constant: 0))
    }
    
}


