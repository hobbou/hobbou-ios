//
//  AccountCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 10/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class AccountMenu: NSObject {
    let name: AccountMenuName
    let imageName: String
    
    init(name: AccountMenuName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

enum AccountMenuName: String {

    case myChannel = "My Channel"
    case notification = "Notification"
    case history = "History"
    
    private static let allAccountMenuName = [history, notification, myChannel]
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "for accountmenuname")
    }
    
    init!(rawValue: String) {
        let keys =  AccountMenuName.allAccountMenuName
        let filtered = keys.filter { $0.rawValue == rawValue }
        
        self = filtered.first!
    }
    
    init!(localizedString: String) {
        let keys =  AccountMenuName.allAccountMenuName
        let filtered = keys.filter { $0.localizedString == localizedString }
        
        self = filtered.first!
    }
}


class AccountListCellView: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let accountCellId = "accountCellId"
    let cellHeight:CGFloat = 50
    let accountMenus: [AccountMenu] = {
        let myChannelAccountMenu = AccountMenu(name: .myChannel, imageName: "Delete Filled-100")
        let historyAccountMenu = AccountMenu(name: .history, imageName: "Delete Filled-100")
        let notificationAccountMenu = AccountMenu(name: .notification, imageName: "Voice Presentation Filled-100")
        return [
            myChannelAccountMenu,
            historyAccountMenu,
            notificationAccountMenu
        ]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.register(AccountCell.self, forCellWithReuseIdentifier: accountCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: accountCellId, for: indexPath) as! AccountCell
        let accountMenu = accountMenus[indexPath.item]
        cell.accountMenu = accountMenu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
}

class AccountCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor(white: 0.98, alpha: 1) : .white
        }
    }
    
    var accountMenu: AccountMenu? {
        didSet {
            nameLabel.text = (accountMenu?.name).map { $0.localizedString }
            if let imageName = accountMenu?.imageName {
                iconImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Account", comment: "for accountcell")
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Settings Filled-100")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        addConstraint(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraint(format: "V:|[v0]|", views: nameLabel)
        addConstraint(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY , multiplier: 1, constant: 0))
        tintColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        nameLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
    }
}
