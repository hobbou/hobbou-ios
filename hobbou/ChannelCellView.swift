//
//  ChannelCellView.swift
//  hobbou
//
//  Created by Hans Yonathan on 25/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class HeaderChannelCell: BaseCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let channelCoverImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let channelLogoImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 33
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let channelDescriptionLabel: UITextView = {
        let label = UITextView()
        label.text = "Channel description in here.. check it out!"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.isEditable = false
        return label
    }()
    
    let subscriptionTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "300K Subscribers"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        //label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "subscribe")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Subscribe", for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSubscribe), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var configureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Settings Filled-100")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleConfigure), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    func handleSubscribe(){
        print("handle subcribe")
    }
    
    func handleConfigure(){
        print("handle configure")
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(channelCoverImageView)
        addSubview(separatorView)
        addSubview(middleSeparatorView)
        addSubview(configureButton)
        addConstraint(format: "H:|[v0]|", views: channelCoverImageView)
        addConstraint(format: "H:|[v0]|", views: middleSeparatorView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        
        addSubview(containerView)
        addConstraint(format: "H:|[v0]|", views: containerView)
        
        //addConstraint(format: "V:|[v0][v1(1)][v2][v3(1)]|", views: channelCoverImageView, middleSeparatorView, containerView, separatorView)
        
        addConstraint(NSLayoutConstraint(item: channelCoverImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: channelCoverImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: configureButton, attribute: .bottom, relatedBy: .equal, toItem: channelCoverImageView, attribute: .bottom, multiplier: 1, constant: -4))
        addConstraint(NSLayoutConstraint(item: configureButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -8))
        addConstraint(NSLayoutConstraint(item: configureButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        addConstraint(NSLayoutConstraint(item: configureButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 22))
        

        addConstraint(NSLayoutConstraint(item: middleSeparatorView, attribute: .top, relatedBy: .equal, toItem: channelCoverImageView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: middleSeparatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: middleSeparatorView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
        
        containerView.addSubview(subscribeButton)
        containerView.addSubview(subscriptionTotalLabel)
        containerView.addSubview(channelDescriptionLabel)
        
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1, constant: 32))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0, constant: 110))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0, constant: 44))
        
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .top, relatedBy: .equal, toItem: subscribeButton, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .left, relatedBy: .equal, toItem: subscribeButton, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0, constant: 110))
        addConstraint(NSLayoutConstraint(item: subscriptionTotalLabel, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: channelDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: channelDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1, constant: -16))
        addConstraint(NSLayoutConstraint(item: channelDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0, constant: 150))
        addConstraint(NSLayoutConstraint(item: channelDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0, constant: 90))
        
        addSubview(channelLogoImageView)
        
        channelLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        channelLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        channelLogoImageView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        channelLogoImageView.widthAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
}

class FeaturedChannelCell: BaseCell {
    
    lazy var baseContentView: BaseContentView = {
        let baseContentView = BaseContentView()
        baseContentView.translatesAutoresizingMaskIntoConstraints = false
        return baseContentView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(baseContentView)
        addSubview(separatorView)
        addConstraint(format: "H:|-4-[v0]-4-|", views: baseContentView)
        addConstraint(format: "H:|[v0]|", views: separatorView)
        addConstraint(format: "V:|-4-[v0]-4-[v1(1)]|", views: baseContentView, separatorView)
    }
    
}


class MenuContentChannelBarCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let menuNames = [
        NSLocalizedString("Timeline", comment: "for menu content channel bar"),
        NSLocalizedString("Content", comment: "for menu content channel bar"),
        NSLocalizedString("Playlists", comment: "for menu content channel bar"),
        NSLocalizedString("Discussion", comment: "for menu content channel bar")
    ]
    
    //var postController: PostController?
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 245/255, green: 236/255, blue: 221/255, alpha: 1)//UIColor(red: 233/255, green: 221/255, blue: 198/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.layer.borderWidth = 0.3
        cv.layer.borderColor = UIColor.lightGray.cgColor
        return cv
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        collectionView.register(MenuContentChannelCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: UInt(GL_NONE)))
        setupHorizontalBar()
    }
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if [1,3].contains(indexPath.item) {
//            if let viewCell = postController?.collectionView.cellForItem(at: indexPath) as? WordListBaseCell {
//                viewCell.collectionView.setContentOffset(.zero, animated: true)
//            }
//        }
//        
//        let cell = collectionView.cellForItem(at: indexPath) as! MenuCell
//        cell.imageView.image = UIImage(named: imageSelectedNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
//        postController?.scrollTo(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuContentChannelCell
        cell.tintColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        cell.titleLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        cell.titleLabel.text = menuNames[indexPath.item]
        //potential has bug on the color of the menu in here
        if indexPath.item == 0 {
            cell.titleLabel.textColor = UIColor(red: 205/255, green: 133/255, blue: 63/255, alpha: 1)
        }
        //cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuContentChannelCell: BaseCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isHighlighted ? UIColor(red: 205/255, green: 133/255, blue: 63/255, alpha: 1) : UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor(red: 205/255, green: 133/255, blue: 63/255, alpha: 1) : UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(titleLabel)
        addConstraint(format: "V:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
}


class BodyChannelCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
//    lazy var menuBar: MenuContentChannelBar = {
//        let mb = MenuContentChannelBar()
//        //mb.postController = self
//        return mb
//    }()
    
//    private func setupMenuBar(){
//        addSubview(menuBar)
//        addConstraint(format: "H:|[v0]|", views: menuBar)
//        addConstraint(format: "V:|[v0(30)]", views: menuBar)
//    }
    
    let timelineCellId = "timelineCellId"
    let contentCellId = "contentCellId"
    let playlistCellId = "playlistCellId"
    let discussionCellId = "discussionCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
        setupCollectionView()
    }
    
    func setupCollectionView(){
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 245/255, alpha: 1)
        collectionView.register(TimelineCell.self, forCellWithReuseIdentifier: timelineCellId)
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: contentCellId)
        //collectionView.register(BaseCell.self, forCellWithReuseIdentifier: playlistCellId)
        //collectionView.register(BaseCell.self, forCellWithReuseIdentifier: discussionCellId)
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timelineCellId, for: indexPath) as! TimelineCell
        if indexPath.item == 1 {
            let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath) as! BaseCell
            return contentCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
}

class TimelineCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
    
    
    override func setupViews() {
        setupCollectionView()
    }
    
    func setupCollectionView(){
        addSubview(collectionView)
        addConstraint(format: "H:|[v0]|", views: collectionView)
        addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 238/255, alpha: 1)
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
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: (height + 16 + 68)*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PostCell {
            cell.showContentContainer()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //print("begin")
        for cell in collectionView.visibleCells {
            if let cell = cell as? PostCell{
                cell.showContentContainer()
            }
            if let cell = cell as? ShareCell{
                cell.showContentContainer()
            }
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //print("end")
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
            //print("end")
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
