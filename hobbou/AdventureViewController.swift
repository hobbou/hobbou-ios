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

    let pageViewController : FeaturedPageViewController = {
        let viewController = FeaturedPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return viewController
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var categorySelectionView: CategorySelectionView = {
        let categView = CategorySelectionView()
        categView.translatesAutoresizingMaskIntoConstraints = false
        return categView
    }()
    
    let categorySelectionContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()

    let categorySelectionContainerLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let categorySelectionContainerRight: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
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
        //view.backgroundColor = .green
//        
//        view.addSubview(categorySelectionContainer)
//        view.addSubview(featureContainer)
//        view.addSubview(recomendedContainer)
//        view.addSubview(newContainer)
//        view.addSubview(randomContainer)
//        
//        view.addConstraint(format: "H:|[v0]|", views: categorySelectionContainer)
//        view.addConstraint(format: "H:|[v0]|", views: featureContainer)
//        view.addConstraint(format: "H:|[v0]|", views: recomendedContainer)
//        view.addConstraint(format: "H:|[v0]|", views: newContainer)
//        view.addConstraint(format: "H:|[v0]|", views: randomContainer)
//
//        view.addConstraint(format: "V:|[v0(44)][v1(120)][v2(150)][v3(75)][v4(75)]", views: categorySelectionContainer, featureContainer, recomendedContainer, newContainer, randomContainer)

        view.addSubview(categorySelectionView)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        
        //collectionView.register(CategorySelectionCell.self, forCellWithReuseIdentifier: categorySelectionCellId)
        collectionView.register(FeaturedListCell.self, forCellWithReuseIdentifier: featureCellId)
        collectionView.register(RecomendedListCell.self, forCellWithReuseIdentifier: recomendedCellId)
        collectionView.register(NewListCell.self, forCellWithReuseIdentifier: newCellId)
        collectionView.register(RandomListCell.self, forCellWithReuseIdentifier: randomCellId)
        
        collectionView.alwaysBounceVertical = true
        //collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        //collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        //addChildViewController(pageViewController)
        
        //pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 110)
        //view.addSubview(pageViewController.view)
        
        //view.addConstraint(format: "H:|[v0]|", views: categorySelectionContainer)
        //view.addConstraint(format: "H:|[v0]|", views: pageViewController.view)
        
        view.addConstraint(format: "H:|[v0]|", views: categorySelectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|-65-[v0(55)][v1]|", views: categorySelectionView, collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCellId, for: indexPath) as! BaseCell

//        if indexPath.item == 1 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureCellId, for: indexPath) as! FeaturedListCell
//        }else if indexPath.item == 2 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: recomendedCellId, for: indexPath) as! RecomendedListCell
//        }else if indexPath.item == 3 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: newCellId, for: indexPath) as! NewListCell
//        }else if indexPath.item == 4 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: randomCellId, for: indexPath) as! RandomListCell
//        } else {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: categorySelectionCellId, for: indexPath) as! CategorySelectionCell
//        }
        if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: recomendedCellId, for: indexPath) as! RecomendedListCell
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
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        var size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
//        print(indexPath.item)
//        if indexPath.item == 0 {
//            size = CGSize(width: view.frame.width, height: 50)
//        }else if indexPath.item == 1 {
//            size = CGSize(width: view.frame.width, height: (height + 16 + 68))
//        }else if indexPath.item == 2 {
//            size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
//        }else if indexPath.item == 3 {
//            size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
//        }else if indexPath.item == 4 {
//            size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
//        } else {
//            size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
//        }
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        var size = CGSize(width: view.frame.width, height: (height + 16 + 68)*2)
        if indexPath.item == 0 {
            size = CGSize(width: view.frame.width, height: (height + 16 + 68))
        }
        return size
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

class FeaturedPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    let loginPageFrames: [FeaturedPageFrame] = {
        return [
            FeaturedPageFrame(message: NSLocalizedString("Motivated others, Motivated you", comment: "for loginframe"), imageName: "screenshot1"),
            FeaturedPageFrame(message: NSLocalizedString("Vent your feeling and got motivated word from other", comment: "for loginframe"), imageName: "Facebook-100"),
            FeaturedPageFrame(message: NSLocalizedString("Listen and answer other people problem", comment: "for loginframe"), imageName: "Gold Bars-100"),
            FeaturedPageFrame(message: NSLocalizedString("Mark the words that you like as GoldWords", comment: "for loginframe"), imageName: "Gold Bars Filled-100")
        ]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        pc.numberOfPages = self.loginPageFrames.count
        pc.addTarget(self, action: #selector(handlePageControlChange), for: .valueChanged)
        return pc
    }()
    
    func handlePageControlChange(){
        print(pageControl.currentPage)
        let frameViewController = FeaturedFrameViewController()
        frameViewController.loginFramePage = loginPageFrames[pageControl.currentPage]
        setViewControllers([frameViewController], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        let frameViewController = FeaturedFrameViewController()
        frameViewController.loginFramePage = loginPageFrames.first
        let viewControllers = [frameViewController]
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        view.backgroundColor = .clear
        view.addSubview(pageControl)
        view.addConstraint(format: "H:|-100-[v0]-100-|", views: pageControl)
        view.addConstraint(format: "V:[v0(30)]|", views: pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentLoginFramePage = (viewController as! FeaturedFrameViewController).loginFramePage
        let currentIndex = loginPageFrames.index{$0.imageName == currentLoginFramePage?.imageName}
        if currentIndex! < loginPageFrames.count - 1 {
            let frameViewController = FeaturedFrameViewController()
            frameViewController.loginFramePage = loginPageFrames[currentIndex! + 1]
            return frameViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentLoginFramePage = (viewController as! FeaturedFrameViewController).loginFramePage
        let currentIndex = loginPageFrames.index{$0.imageName == currentLoginFramePage?.imageName}
        if currentIndex! > 0 {
            let frameViewController = FeaturedFrameViewController()
            frameViewController.loginFramePage = loginPageFrames[currentIndex! - 1]
            return frameViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentLoginFramePage = (viewControllers?.first as! FeaturedFrameViewController).loginFramePage
        let currentIndex = loginPageFrames.index{$0.imageName == currentLoginFramePage?.imageName}
        pageControl.currentPage = currentIndex!
    }
    
}


class FeaturedFrameViewController: UIViewController {
    
    var loginFramePage: FeaturedPageFrame? {
        didSet {
            imageView.image = UIImage(named: (loginFramePage?.imageName)!)
            titleLabel.text = loginFramePage?.message
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "facebook-square")
        return iv
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Discover Title in here and find something interesting later.."
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        titleLabel.font = .boldSystemFont(ofSize: 16)
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addConstraint(format: "H:|-40-[v0]-40-|", views: imageView)
        view.addConstraint(format: "H:|-40-[v0]-40-|", views: titleLabel)
        view.addConstraint(format: "V:|-10-[v0]-10-[v1]-16-|", views: titleLabel, imageView)
    }
    
}

struct FeaturedPageFrame {
    let message: String!
    let imageName: String!
}
