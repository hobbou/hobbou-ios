//
//  HomeViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let postCellId = "postCellId"
    let shareCellId = "shareCellId"
    private var lastContentOffset: CGFloat = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupCollectionView(){
        view.addSubview(collectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: postCellId)
        collectionView.register(ShareCell.self, forCellWithReuseIdentifier: shareCellId)
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellId, for: indexPath) as! PostCell
        if indexPath.item == 1 {
            let shareCell = collectionView.dequeueReusableCell(withReuseIdentifier: shareCellId, for: indexPath) as! ShareCell
            return shareCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentLauncher = ContentLauncher()
        contentLauncher.showVideoPlayer()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PostCell {
            cell.showContentContainer()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("begin")
        for cell in collectionView.visibleCells {
            if let cell = cell as? PostCell{
                cell.showContentContainer()
            }
            if let cell = cell as? ShareCell{
                cell.showContentContainer()
            }
        }
        
        let mainPageTabViewController = pageTabBarController as! MainPageTabViewController
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            //move down
            mainPageTabViewController.hideFloatingMenu()            
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            //move up
            mainPageTabViewController.showFloatingMenu()
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("end")
        for cell in collectionView.visibleCells {
            if let cell = cell as? PostCell{
                cell.hideContentContainer()
            }
            if let cell = cell as? ShareCell{
                cell.hideContentContainer()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            print("end")
            for cell in collectionView.visibleCells {
                if let cell = cell as? PostCell{
                    cell.hideContentContainer()
                }
                if let cell = cell as? ShareCell{
                    cell.hideContentContainer()
                }
            }
            
        }
    }
    
}

extension HomeViewController {
    
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.title = NSLocalizedString("Home", comment: "for homeviewcontroller")
        pageTabBarItem.titleColor = Color.blueGrey.base
    } 
    
}
