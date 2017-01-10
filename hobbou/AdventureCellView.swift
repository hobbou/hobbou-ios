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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    let containerLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
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
        button.backgroundColor = .white
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
        //addSubview(containerLeft)
        //addConstraint(format: "H:|[v0]|", views: containerLeft)
        //addConstraint(format: "V:|-4-[v0]-4-|", views: containerLeft)
        setupCollectionView()
        addSubview(moreButton)
        addConstraint(format: "H:[v0(44)]|", views: moreButton)
        addConstraint(format: "V:|[v0]|", views: moreButton)
    }
    
    @objc func handleMore(){
        print("handleMore")
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
        view.backgroundColor = .green
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

class RecomendedListCell: BaseCell {
    
    let containerHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let containerContent: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override func setupViews() {
        addSubview(containerHeader)
        addSubview(containerContent)
        addConstraint(format: "H:|[v0]|", views: containerHeader)
        addConstraint(format: "H:|[v0]|", views: containerContent)
        addConstraint(format: "V:|[v0(44)][v1]|", views: containerHeader, containerContent)
    }
}

class NewListCell: BaseCell {
    
    let containerHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let containerContent: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override func setupViews() {
        addSubview(containerHeader)
        addSubview(containerContent)
        addConstraint(format: "H:|[v0]|", views: containerHeader)
        addConstraint(format: "H:|[v0]|", views: containerContent)
        addConstraint(format: "V:|[v0(44)][v1]|", views: containerHeader, containerContent)
    }
}

class RandomListCell: BaseCell {
    
    let containerHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let containerContent: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override func setupViews() {
        addSubview(containerHeader)
        addSubview(containerContent)
        addConstraint(format: "H:|[v0]|", views: containerHeader)
        addConstraint(format: "H:|[v0]|", views: containerContent)
        addConstraint(format: "V:|[v0(44)][v1]|", views: containerHeader, containerContent)
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
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addConstraint(format: "H:|[v0]|", views: thumbnailImageView)
        addConstraint(format: "V:|[v0]|", views: thumbnailImageView)
    }
    
}
