//
//  CategoryPickerController.swift
//  hobbou
//
//  Created by Hans Yonathan on 27/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

//
//  AccountViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 10/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class CategoryPickerViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let categoryListCellId = "CategoryListCellId"
    var appMenuController: AppMenuController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryPickerCellView.self, forCellWithReuseIdentifier: categoryListCellId)
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryListCellId, for: indexPath) as! CategoryPickerCellView
        //cell.accountViewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellLeg = (collectionView.frame.size.width/2) - 5;
        return CGSize(width: cellLeg,height: cellLeg);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
