//
//  AdventureCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 9/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class CategorySelectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let categoryListCellId = "categoryListCellId"
    var adventureViewController: AdventureViewController?
    var hobViewController: HoBViewController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
        return cv
    }()
    
    let containerRight: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        //button.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        setupCollectionView()
        addSubview(containerRight)
        addConstraint(format: "H:[v0(44)]|", views: containerRight)
        addConstraint(format: "V:|[v0]|", views: containerRight)
        containerRight.addSubview(moreButton)
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .centerY, relatedBy: .equal, toItem: containerRight, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .centerX, relatedBy: .equal, toItem: containerRight, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: containerRight, attribute: .height, multiplier: 0.7, constant: 0))
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: containerRight, attribute: .height, multiplier: 0.7, constant: 0))
    }
    
    @objc func handleMore(){
        print("handleMore")
        let categoryPickerViewController = CategoryPickerViewController()
        //categoryPickerViewController.appMenuController = self
        adventureViewController?.present(AppCategoryPickerNavigationBarController(rootViewController: categoryPickerViewController)
            , animated: true, completion: nil)
        hobViewController?.present(AppCategoryPickerNavigationBarController(rootViewController: categoryPickerViewController)
            , animated: true, completion: nil)
    }
    
    func setupCollectionView(){
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        //collectionView.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 245/255, alpha: 1)
        collectionView.register(CategoryListCell.self, forCellWithReuseIdentifier: categoryListCellId)
        collectionView.alwaysBounceHorizontal = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryListCellId, for: indexPath) as! CategoryListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 40
        let width = Int(frame.width / 5)
        return CGSize(width: width, height: height)
    }
    
}

class FeaturedListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let featuredCellId = "featuredCellId"
    
    let pager: UIView = {
        let view = UIView()
        //view.backgroundColor = .green
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.addTarget(self, action: #selector(handlePageControlChange), for: .valueChanged)
        pc.numberOfPages = 4
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    func handlePageControlChange(){
        print(pageControl.currentPage)
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .init(rawValue: 0), animated: true)
    }
    
    override func setupViews() {
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)

        addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pageControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        //height constraint
        addConstraint(NSLayoutConstraint(item: pageControl, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: featuredCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredCellId, for: indexPath) as! FeaturedCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: (height + 16 + 68))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
    }
    
}

class RecomendedBaseListCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let recomendedCellId = "recomendedCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    let containerHeader: UIView = {
        let view = UIView()
        //view.backgroundColor = .green
        return view
    }()
    
    let containerContent: UIView = {
        let view = UIView()
        //view.backgroundColor = .purple
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Recomended", comment: "for recomendedlist")
        //label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        //button.backgroundColor = .white
        return button
    }()
    
    override func setupViews() {
        addSubview(containerHeader)
        addSubview(containerContent)
        addConstraint(format: "H:|[v0]|", views: containerHeader)
        addConstraint(format: "H:|[v0]|", views: containerContent)
        addConstraint(format: "V:|[v0(44)][v1]|", views: containerHeader, containerContent)
        
        containerHeader.addSubview(titleLabel)
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: containerHeader, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: containerHeader, attribute: .left, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: containerHeader, attribute: .right, multiplier: 1, constant: -44))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        containerHeader.addSubview(moreButton)
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .centerY, relatedBy: .equal, toItem: containerHeader, attribute: .centerY, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: containerHeader, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
        containerContent.addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
        collectionView.register(ThreeDimensionContentBaseCell.self, forCellWithReuseIdentifier: recomendedCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recomendedCellId, for: indexPath) as! ThreeDimensionContentBaseCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func handleMore(){
        print("handlemore")
    }
    
}

class NewListCell: RecomendedBaseListCell {
    
    override func setupViews() {
        super.setupViews()
        titleLabel.text = "New"
    }
    
}

class RandomListCell: RecomendedBaseListCell {
    
    override func setupViews() {
        super.setupViews()
        titleLabel.text = "Random"
    }
    
}

class CategoryListCell: BaseCell {
    
    let categLabel: UILabel = {
        let label = UILabel()
        label.text = "categ"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        view.cornerRadius = 22
        return view
    }()
    
    override func setupViews() {
        addSubview(containerView)
        addConstraint(format: "H:|-2-[v0]-2-|", views: containerView)
        addConstraint(format: "V:|-2-[v0]-2-|", views: containerView)
        containerView.addSubview(categLabel)
        addConstraint(format: "H:|[v0]|", views: categLabel)
        addConstraint(format: "V:|[v0]|", views: categLabel)
    }
    
}

class FeaturedCell: BaseCell {
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.alpha = 0
        return view
    }()

    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text = "Title in here"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.text = "Channel Name"
        return label
    }()
    
    let contentViewsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "200k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let contentBouLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "255k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let contentDateAgoLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.text = "2 days ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let contentViewsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Play-104")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    let contentBouImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Christmas Star-96")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    let contentCalendarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Calendar-96")?.withRenderingMode(.alwaysTemplate))
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
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
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addConstraint(format: "H:|[v0]|", views: thumbnailImageView)
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
        containerView.addSubview(channelLabel)
        containerView.addSubview(contentViewsImageView)
        containerView.addSubview(contentViewsLabel)
        containerView.addSubview(contentBouImageView)
        containerView.addSubview(contentBouLabel)
        containerView.addSubview(contentCalendarImageView)
        containerView.addSubview(contentDateAgoLabel)
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
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //width constraint
        //addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))

        //top constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .centerY, relatedBy: .equal, toItem: channelLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .left, relatedBy: .equal, toItem: channelLabel, attribute: .right, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentViewsImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .top, relatedBy: .equal, toItem: channelLabel, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .left, relatedBy: .equal, toItem: contentViewsImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentViewsLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .centerY, relatedBy: .equal, toItem: channelLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .left, relatedBy: .equal, toItem: contentViewsLabel, attribute: .right, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentBouImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .top, relatedBy: .equal, toItem: channelLabel, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .left, relatedBy: .equal, toItem: contentBouImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentBouLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .centerY, relatedBy: .equal, toItem: channelLabel, attribute: .centerY, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .left, relatedBy: .equal, toItem: contentBouLabel, attribute: .right, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //width constraint
        addConstraint(NSLayoutConstraint(item: contentCalendarImageView, attribute: .width, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 0.5, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .top, relatedBy: .equal, toItem: channelLabel, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .left, relatedBy: .equal, toItem: contentCalendarImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: contentDateAgoLabel, attribute: .height, relatedBy: .equal, toItem: channelLabel, attribute: .height, multiplier: 1, constant: 0))
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: -4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        //width constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
    }
    
    func handleSave(){
        print("save")
    }
    
    func hideContentContainer(){
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.containerView.alpha = 0
            }, completion: { (completed) in
                //self.containerView.alpha = 0
            })
        })
    }
    
    func showContentContainer(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1
        }) { (completed) in
            //self.containerView.isHidden = true
            //self.containerView.alpha = 1
        }
    }
    
}

class ThreeDimensionContentBaseCell: BaseCell {

    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text  = "Title in here.."
        label.font = .systemFont(ofSize: 11)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 6)
        label.text = "Channel Name"
        return label
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
        label.font = .boldSystemFont(ofSize: 6)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return label
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
    
    override func setupViews() {
        layer.borderWidth = 0.3
        addSubview(thumbnailImageView)
        addConstraint(format: "H:|[v0]|", views: thumbnailImageView)
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
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 11))
        //width constraint
        addConstraint(NSLayoutConstraint(item: lengthLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(channelLabel)
        containerView.addSubview(saveButton)
                
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .top, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: -4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 10))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 10))
        //width constraint
        addConstraint(NSLayoutConstraint(item: channelLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: -2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 2))
        //height constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))

    }
    
    func handleSave(){
        print("handlesave")
    }
    
    func hideContentContainer(){
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.containerView.alpha = 0
            }, completion: { (completed) in
                //self.containerView.alpha = 0
            })
        })
    }
    
    func showContentContainer(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1
        }) { (completed) in
            //self.containerView.isHidden = true
            //self.containerView.alpha = 1
        }
    }
    
}
