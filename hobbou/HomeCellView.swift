//
//  CellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
}

class ShareCommentCell: BaseCommentCell {
    
    override func setupViews() {
        addSubview(commentContainerView)
        addSubview(separatorView)
        addConstraint(format: "H:|-2-[v0]-2-|", views: commentContainerView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0]-2-[v1(1)]|", views: commentContainerView, separatorView)
        commentContainerView.addSubview(userProfileImageView)
        commentContainerView.addSubview(descriptionLabel)
        commentContainerView.addSubview(subtitleLabel)
        
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
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .bottom, relatedBy: .equal, toItem: commentContainerView, attribute: .bottom, multiplier: 1, constant: -2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .width, relatedBy: .equal, toItem: descriptionLabel, attribute: .width, multiplier: 1, constant: 0))
        
    }
    
}

class PostCommentCell: BaseCommentCell {
    
    override func setupViews() {
        addSubview(commentContainerView)
        addSubview(separatorView)
        addConstraint(format: "H:|-2-[v0]-2-|", views: commentContainerView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0]-2-[v1(1)]|", views: commentContainerView, separatorView)
        commentContainerView.addSubview(userProfileImageView)
        commentContainerView.addSubview(descriptionLabel)
        commentContainerView.addSubview(subtitleLabel)
        
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
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .bottom, relatedBy: .equal, toItem: commentContainerView, attribute: .bottom, multiplier: 1, constant: -2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .width, relatedBy: .equal, toItem: descriptionLabel, attribute: .width, multiplier: 1, constant: 0))
    }
    
}

class BaseCommentCell: BaseCell {

    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "description comment in here..."
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 12)
        label.text = "Username • 2 minute ago"
        return label
    }()
    
    let commentContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .yellow
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
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
    
    func handleMore(){
        
    }
}

class ShareCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let shareCommentCellId = "shareCommentCellId"

    lazy var commentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text = "Username endorsed this Content"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "2 minutes ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var baseContentView: BaseContentView = {
        let baseContentView = BaseContentView()
        baseContentView.translatesAutoresizingMaskIntoConstraints = false
        return baseContentView
    }()
    
    let containerLeft: UIView = {
        let view = UIView()
        //view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerRight: UIView = {
        let view = UIView()
        //view.backgroundColor = Color.grey.lighten3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerComment: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(containerLeft)
        addSubview(containerRight)
        addSubview(separatorView)
        
        addConstraint(format: "H:|-4-[v0(52)][v1]-4-|", views: containerLeft, containerRight)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|-4-[v0]-4-[v1(1)]|", views: containerLeft, separatorView)
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: containerRight, attribute: .height, relatedBy: .equal, toItem: containerLeft, attribute: .height, multiplier: 1, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: containerRight, attribute: .top, relatedBy: .equal, toItem: containerLeft, attribute: .top, multiplier: 1, constant: 0))
        
        
        containerLeft.addSubview(userProfileImageView)
        addConstraint(format: "H:|-4-[v0(44)]-4-|", views: userProfileImageView)
        addConstraint(format: "V:|[v0(44)]", views: userProfileImageView)
        
        containerRight.addSubview(titleLabel)
        containerRight.addSubview(subtitleLabel)
        containerRight.addSubview(baseContentView)
        containerRight.addSubview(containerComment)
        containerComment.addSubview(commentCollectionView)
        
        addConstraint(format: "H:|[v0]|", views: titleLabel)
        addConstraint(format: "H:|[v0]|", views: subtitleLabel)
        addConstraint(format: "H:|[v0]|", views: baseContentView)
        addConstraint(format: "H:|[v0]|", views: containerComment)
        addConstraint(format: "H:|[v0]|", views: commentCollectionView)

        addConstraint(format: "V:|[v0(20)]-2-[v1(20)]-4-[v2][v3(230)]|", views: titleLabel,subtitleLabel, baseContentView, containerComment)
        
        addConstraint(format: "V:|[v0]|", views: commentCollectionView)
        
        commentCollectionView.register(ShareCommentCell.self, forCellWithReuseIdentifier: shareCommentCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shareCommentCellId, for: indexPath) as! ShareCommentCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: containerRight.width, height: 70)
    }
    
    func hideContentContainer(){
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.baseContentView.containerView.alpha = 0
            }, completion: { (completed) in
                //self.containerView.alpha = 0
            })
        })
    }
    
    func showContentContainer(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.baseContentView.containerView.alpha = 1
        }) { (completed) in
            //self.containerView.isHidden = true
            //self.containerView.alpha = 1
        }
    }
    
}

class PostCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let postCommentCellId = "postCommentCellId"

    let containerLeft: UIView = {
        let view = UIView()
        //view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerRight: UIView = {
        let view = UIView()
        //view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var baseContentView: BaseContentView = {
        let baseContentView = BaseContentView()
        return baseContentView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(baseContentView)
        addSubview(containerLeft)
        addSubview(containerRight)
        containerRight.addSubview(commentCollectionView)
        addSubview(separatorView)
        addConstraint(format: "H:|-4-[v0]-4-|", views: baseContentView)
        addConstraint(format: "H:|-4-[v0(52)][v1]-4-|", views: containerLeft, containerRight)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|-4-[v0][v1(230)]-4-[v2(1)]|", views: baseContentView, containerRight, separatorView)

        addConstraint(format: "H:|[v0]|", views: commentCollectionView)
        addConstraint(format: "V:|[v0]|", views: commentCollectionView)
        commentCollectionView.register(PostCommentCell.self, forCellWithReuseIdentifier: postCommentCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCommentCellId, for: indexPath) as! PostCommentCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: containerRight.width, height: 70)
    }
    
    func hideContentContainer(){
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.baseContentView.containerView.alpha = 0
            }, completion: { (completed) in
                //self.containerView.alpha = 0
            })
        })
    }
    
    func showContentContainer(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.baseContentView.containerView.alpha = 1
        }) { (completed) in
            //self.containerView.isHidden = true
            //self.containerView.alpha = 1
        }
    }
    
}
