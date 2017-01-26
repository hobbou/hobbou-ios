//
//  AccountCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 10/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

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
    case content = "Content"
    case creator = "Creator"
    case album = "Album"
    case configuration = "Configuration"
    case terms = "Terms"
    case feedback = "Feedback"
    case help = "Help"
    
    private static let allAccountMenuName = [history, notification, myChannel, content, creator, album, configuration, terms, feedback, help]
    
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
        let myChannelAccountMenu = AccountMenu(name: .myChannel, imageName: "Contacts-96")
        let historyAccountMenu = AccountMenu(name: .history, imageName: "Past-96")
        let notificationAccountMenu = AccountMenu(name: .notification, imageName: "Appointment Reminders-96")
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
        cv.isScrollEnabled = false
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        addSubview(separatorView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0][v1(1)]|", views: collectionView,separatorView)
        collectionView.register(AccountMenuBasedCell.self, forCellWithReuseIdentifier: accountCellId)
        collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: accountCellId, for: indexPath) as! AccountMenuBasedCell
        let accountMenu = accountMenus[indexPath.item]
        cell.accountMenu = accountMenu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            //accountViewController?.present(ChannelViewController(), animated: true, completion: nil)
            accountViewController?.dismiss(animated: true, completion: {
                let channelViewController =  ChannelViewController()
                channelViewController.navigationItem.title = "Channel Name"
                self.accountViewController?.appMenuController?.navigationController?.navigationBar.tintColor = .white
                self.accountViewController?.appMenuController?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                self.accountViewController?.appMenuController?.navigationController?.pushViewController(channelViewController, animated: true)
            })
        }
    }
    
}

class SavedListCellView: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let savedCellId = "savedCellId"
    let cellHeight:CGFloat = 50
    let savedMenus: [AccountMenu] = {
        let contentSavedMenu = AccountMenu(name: .content, imageName: "Video File Filled-100")
        let creatorSavedMenu = AccountMenu(name: .creator, imageName: "User Group Man Man-96")
        let albumSavedMenu = AccountMenu(name: .album, imageName: "Video Playlist-96")
        return [
            contentSavedMenu,
            creatorSavedMenu,
            albumSavedMenu
        ]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Saved", comment: "for accountcellview")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.grey.darken2
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        addSubview(separatorView)
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "H:|[v0]|", views: headerView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0(30)][v1][v2(1)]|", views: headerView,collectionView,separatorView)

        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        collectionView.register(AccountMenuBasedCell.self, forCellWithReuseIdentifier: savedCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: savedCellId, for: indexPath) as! AccountMenuBasedCell
        let saveMenu = savedMenus[indexPath.item]
        cell.accountMenu = saveMenu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
}

class PlaylistListCellView: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let playlistCellId = "playlistCellId"
    let cellHeight:CGFloat = 50
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Playlist", comment: "for playlistcellview")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.grey.darken2
        return label
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
        button.tintColor = Color.grey.darken2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Plus Math Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = Color.grey.darken2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    func handleMore(){
        print("handleMore")
    }
    
    func handleAdd(){
        print("handleAdd")
    }
    
    override func setupViews() {
        addSubview(collectionView)
        addSubview(separatorView)
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(addButton)
        headerView.addSubview(moreButton)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "H:|[v0]|", views: headerView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0(30)][v1][v2(1)]|", views: headerView,collectionView,separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .right, multiplier: 1, constant: -8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: addButton, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 4))
        //right constraint
        addConstraint(NSLayoutConstraint(item: addButton, attribute: .right, relatedBy: .equal, toItem: moreButton, attribute: .left, multiplier: 1, constant: -8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: addButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        //width constraint
        addConstraint(NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 22))
        
        collectionView.register(PlaylistMenuCell.self, forCellWithReuseIdentifier: playlistCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playlistCellId, for: indexPath) as! PlaylistMenuCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
}

class ConfigListCellView: BaseCell, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let configCellId = "configCellId"
    let cellHeight:CGFloat = 50
    let configMenus: [AccountMenu] = {
        let configurationConfigMenu = AccountMenu(name: .configuration, imageName: "Settings Filled-100")
        let termsConfigMenu = AccountMenu(name: .terms, imageName: "Lock Filled-100")
        let feedbackConfigMenu = AccountMenu(name: .feedback, imageName: "About Filled-100")
        let helpConfigMenu = AccountMenu(name: .help, imageName: "Help Filled-100")
        return [
            configurationConfigMenu,
            termsConfigMenu,
            feedbackConfigMenu,
            helpConfigMenu
        ]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(collectionView)
        addSubview(separatorView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|[v0][v1(1)]|", views: collectionView,separatorView)
        collectionView.register(AccountMenuBasedCell.self, forCellWithReuseIdentifier: configCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configCellId, for: indexPath) as! AccountMenuBasedCell
        let configMenu = configMenus[indexPath.item]
        cell.accountMenu = configMenu
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
}

class AccountMenuBasedCell: BaseCell {
    
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
        label.textColor = Color.grey.darken2
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
        tintColor = Color.grey.darken2
    }
}

class PlaylistMenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor(white: 0.98, alpha: 1) : .white
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Playlist Title", comment: "for playlistmenucell")
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.grey.darken2
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("22 Contents", comment: "for playlistmenucell")
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.grey.darken2
        return label
    }()
    
    let playlistImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(titleLabel)
        addSubview(totalLabel)
        addSubview(playlistImageView)
        addConstraint(format: "H:|-8-[v0(44)]-8-[v1]|", views: playlistImageView,titleLabel)
        addConstraint(format: "V:[v0(44)]", views: playlistImageView)
        
        addConstraint(NSLayoutConstraint(item: playlistImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY , multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: playlistImageView, attribute: .top, multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint(item: totalLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: totalLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: totalLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: totalLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 1, constant: 0))
        
        
        //tintColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
    }
}
