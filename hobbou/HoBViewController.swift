//
//  HallOfBouViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class HoBViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    let hobCellId = "hobCellId"
    private var lastContentOffset: CGFloat = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(categorySelectionView)
        view.addSubview(collectionView)
        collectionView.register(HoBCell.self, forCellWithReuseIdentifier: hobCellId)
        view.addConstraint(format: "H:|[v0]|", views: categorySelectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|-65-[v0(55)][v1]|", views: categorySelectionView, collectionView)
    }
    
    func categorySelectionHandleMore(){
        print("handlemore")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hobCellId, for: indexPath) as! HoBCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HoBViewController {
    
    fileprivate func preparePageTabBarItem() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Trophy-96")?.withRenderingMode(.alwaysTemplate)
        //imageView.tintColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        imageView.tintColor = Color.grey.base
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Hall of Bou", comment: "for hobviewcontroller")
        //titleLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        titleLabel.textColor = Color.grey.base
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        pageTabBarItem.addSubview(imageView)
//        pageTabBarItem.addSubview(titleLabel)
//        
//        //pageTabBarItem.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: pageTabBarItem, attribute: .bottom, multiplier: 1, constant: 0))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: pageTabBarItem, attribute: .centerX, multiplier: 1, constant: 0))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: pageTabBarItem, attribute: .centerY, multiplier: 1, constant: -8))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: pageTabBarItem, attribute: .height, multiplier: 0, constant: 33))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: pageTabBarItem, attribute: .width, multiplier: 0, constant: 33))
//        
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 2))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: pageTabBarItem, attribute: .centerX, multiplier: 1, constant: 0))
//        pageTabBarItem.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: pageTabBarItem, attribute: .height, multiplier: 0, constant: 10))

        //pageTabBarItem.setImage(imageView.image, for: .normal)
        //pageTabBarItem.setImage(UIImage(named: "sas"), for: .selected)

//        let spacing: CGFloat = 2.0
//        let imageSize: CGSize = pageTabBarItem.imageView!.image!.size
//        pageTabBarItem.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
//        let labelString = NSString(string: pageTabBarItem.titleLabel!.text!)
//        let titleSize = labelString.size(attributes: [NSFontAttributeName: pageTabBarItem.titleLabel!.font])
//        pageTabBarItem.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
//        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
//        pageTabBarItem.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
        pageTabBarItem.title = titleLabel.text
        pageTabBarItem.titleColor = Color.blueGrey.base
    }
    
    
}
