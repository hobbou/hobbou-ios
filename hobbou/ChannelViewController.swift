//
//  ChannelViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 25/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let headerCellId = "headerCellId"
    let featuredCellId = "featuredCellId"
    let bodyCellId = "bodyCellId"
    let contentMenuCellId = "contentMenuCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-152, height: view.frame.height))
        titleLabel.text = NSLocalizedString("Channel Name", comment: "for channel name")
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel

        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        let moreImage = UIImage(named: "Menu 2 Filled-100")?.withRenderingMode(.alwaysTemplate)
        moreButton.setBackgroundImage(moreImage, for: .normal)
        moreButton.tintColor = .white
        moreButton.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        moreButton.showsTouchWhenHighlighted = true
        let moreBarButtonItem = UIBarButtonItem(customView: moreButton)
        
        navigationItem.rightBarButtonItems = [
            moreBarButtonItem
        ]
        setupCollectionView()

    }
    
    func handleMore(){
        print("handleMore")
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
        collectionView.register(HeaderChannelCell.self, forCellWithReuseIdentifier: headerCellId)
        collectionView.register(FeaturedChannelCell.self, forCellWithReuseIdentifier: featuredCellId)
        collectionView.register(BodyChannelCell.self, forCellWithReuseIdentifier: bodyCellId)
        collectionView.register(MenuContentChannelBarCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: contentMenuCellId)
        collectionView.alwaysBounceVertical = true
        //collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        //collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! BaseCell
        if indexPath.item == 1 && indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredCellId, for: indexPath) as! FeaturedChannelCell
        }else if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyCellId, for: indexPath) as! BodyChannelCell
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! HeaderChannelCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: contentMenuCellId, for: indexPath) as! MenuContentChannelBarCell
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return CGSize(width: view.frame.height, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: view.frame.width, height: 200)
        if indexPath.item == 1 {
            let height = (view.frame.width - 16 - 16) * 9 / 16
            size = CGSize(width: view.frame.width, height: height + 16 + 68)
        } else if indexPath.section == 1{
            size = CGSize(width: view.frame.width, height: view.frame.height)
        } else{
            size = CGSize(width: view.frame.width, height: 200)
        }
        return size
    }
    
    
}