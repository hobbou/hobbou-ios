//
//  AdventureViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class AdventureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let categorySelectionCellId = "categorySelectionCellId"
    let featureCellId = "featuredCellId"
    let recomendedCellId = "recomendedCellId"
    let newCellId = "newCellId"
    let randomCellId = "randomCellId"
    private var lastContentOffset: CGFloat = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var categorySelectionView: CategorySelectionView = {
        let categView = CategorySelectionView()
        categView.translatesAutoresizingMaskIntoConstraints = false
        return categView
    }()
    
    lazy var categorySelectionMoreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(categorySelectionHandleMore), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    func categorySelectionHandleMore(){
        print("handleMore")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(categorySelectionView)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
        
        collectionView.register(FeaturedListCell.self, forCellWithReuseIdentifier: featureCellId)
        collectionView.register(RecomendedBaseListCell.self, forCellWithReuseIdentifier: recomendedCellId)
        collectionView.register(NewListCell.self, forCellWithReuseIdentifier: newCellId)
        collectionView.register(RandomListCell.self, forCellWithReuseIdentifier: randomCellId)
        
        collectionView.alwaysBounceVertical = true
        
        view.addConstraint(format: "H:|[v0]|", views: categorySelectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|-65-[v0(55)][v1]|", views: categorySelectionView, collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCellId, for: indexPath) as! BaseCell
        if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: recomendedCellId, for: indexPath) as! RecomendedBaseListCell
        }else if indexPath.item == 2 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath) as! NewListCell
        }else if indexPath.item == 3 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: randomCellId, for: indexPath) as! RandomListCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCellId, for: indexPath) as! FeaturedListCell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        var size = CGSize(width: view.frame.width, height: view.frame.width+44)
        if indexPath.item == 0 {
            size = CGSize(width: view.frame.width, height: (height + 16 + 68))
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let listCell = cell as? RecomendedBaseListCell {
            for cell in listCell.collectionView.visibleCells{
                if let cell = cell as? ThreeDimensionContentBaseCell {
                    cell.showContentContainer()
                }
            }
        }
        if let listCell = cell as? FeaturedListCell {
            for cell in listCell.collectionView.visibleCells{
                if let cell = cell as? FeaturedCell {
                    cell.showContentContainer()
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //print("begin")
        for cell in collectionView.visibleCells {
            if let listCell = cell as? RecomendedBaseListCell {
                for cell in listCell.collectionView.visibleCells{
                    if let cell = cell as? ThreeDimensionContentBaseCell {
                        cell.showContentContainer()
                    }
                }
            }
            if let listCell = cell as? FeaturedListCell {
                for cell in listCell.collectionView.visibleCells{
                    if let cell = cell as? FeaturedCell {
                        cell.showContentContainer()
                    }
                }
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
        //print("end")
        for cell in collectionView.visibleCells {
            if let listCell = cell as? RecomendedBaseListCell {
                for cell in listCell.collectionView.visibleCells{
                    if let cell = cell as? ThreeDimensionContentBaseCell {
                        cell.hideContentContainer()
                    }
                }
            }
            if let listCell = cell as? FeaturedListCell {
                for cell in listCell.collectionView.visibleCells{
                    if let cell = cell as? FeaturedCell {
                        cell.hideContentContainer()
                    }
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            //print("end")
            for cell in collectionView.visibleCells {
                if let listCell = cell as? RecomendedBaseListCell {
                    for cell in listCell.collectionView.visibleCells{
                        if let cell = cell as? ThreeDimensionContentBaseCell {
                            cell.hideContentContainer()
                        }
                    }
                }
                if let listCell = cell as? FeaturedListCell {
                    for cell in listCell.collectionView.visibleCells{
                        if let cell = cell as? FeaturedCell {
                            cell.hideContentContainer()
                        }
                    }
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AdventureViewController {
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.title = NSLocalizedString("Adventure", comment: "for adventureviewcontroller")
        pageTabBarItem.titleColor = Color.blueGrey.base
    }
}
