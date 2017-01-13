//
//  ContentLauncher.swift
//  hobbou
//
//  Created by Hans Yonathan on 11/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import AVFoundation

class ContentLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation....")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let videoDetailView = VideoDetailView(frame: keyWindow.frame)
            videoDetailView.frame = CGRect(x: 0, y: keyWindow.frame.height, width: 10, height: 10)
            keyWindow.addSubview(videoDetailView)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                videoDetailView.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                //maybe we'll do something here later...
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}

class VideoDetailView: UIView {
    
//    var video: Video? {
//        didSet {
//            videoDetailCollectionView.video = video
//            videoDetailController.video = video
//        }
//    }
    
    let videoDetailCollectionView: VideoDetailCollectionView = {
        let cv = VideoDetailCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var videoPlayerView: VideoPlayerView?
    var videoDetailController: VideoDetailController = {
        let layout = UICollectionViewFlowLayout()
        let controller = VideoDetailController(collectionViewLayout: layout)
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        let width = UIScreen.main.bounds.width
        let height = 9 / 16 * width
        videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        videoPlayerView?.videoDetailView = self
        videoPlayerView?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan2)))
        
        videoPlayerView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        addSubview(videoDetailCollectionView)
        videoDetailCollectionView.frame = CGRect(x: 0, y: height, width: width, height: UIScreen.main.bounds.height - height)
        addSubview(videoPlayerView!)
    }
    
    var interpolationLayer: InterpolationLayer?
    
    func handleTap(_ gesture: UITapGestureRecognizer) {
        if videoPlayerView!.isMinimized {
            maximize()
        } else {
            if videoPlayerView!.isPlaying{
                videoPlayerView?.showControlsBriefly()
            }else{
            if videoPlayerView?.controlsContainerView.alpha == 1 {
                videoPlayerView?.controlsContainerView.alpha = 0
            }else{
                videoPlayerView?.controlsContainerView.alpha = 1
            }
            }
        }
    }
    
    func minimize() {
        startInterpolationInterpolationHandler({ (value) in
            self.handleTranslationValue(UIScreen.main.bounds.height * value)
        })
    }
    
    func maximize() {
        startInterpolationInterpolationHandler({ (value) in
            self.handleTranslationValue(UIScreen.main.bounds.height * (1 - value))
            if value == 1 {
                self.videoPlayerView?.isMinimized = false
            }
        })
    }
    
    func startInterpolationInterpolationHandler(_ interpolationHandler: @escaping ((_ value: CGFloat) -> ()), duration: CFTimeInterval = 0.5) {
        interpolationLayer?.removeFromSuperlayer()
        interpolationLayer = InterpolationLayer()
        interpolationLayer?.interpolationDuration = duration
        interpolationLayer?.interpolationHandler = interpolationHandler
        layer.addSublayer(interpolationLayer!)
        interpolationLayer?.translationValue = 1
    }
    
    let minHeight: CGFloat = 100
    let rightMargin: CGFloat = 4
    let screenBounds = UIScreen.main.bounds
    
    var partialTranslationValue: CGFloat = 0
    
    func handlePan2(_ gesture: UIPanGestureRecognizer) {
        //where your finger is
        let translation = gesture.translation(in: self)
        
        if gesture.state == .ended {
            partialTranslationValue = translation.y
            handleGestureEnd()
        }
        
        let maxHeight = 9 / 16 * screenBounds.width
        handleTranslationValue(translation.y + (videoPlayerView!.isMinimized ? screenBounds.height - maxHeight : 0))
    }
    
    func handleGestureEnd() {
        let maxHeight = 9 / 16 * screenBounds.width
        if videoPlayerView!.isMinimized {
            startInterpolationInterpolationHandler({ (value) in
                var shouldMaximize = false
                
                if abs(self.partialTranslationValue) > (self.screenBounds.height - maxHeight) / 2 {
                    shouldMaximize = true
                    
                    let travelY = self.screenBounds.height - maxHeight + self.partialTranslationValue
                    self.handleTranslationValue(travelY - value * travelY)
                    
                } else {
                    shouldMaximize = false
                    let translationDiff = self.partialTranslationValue - value * self.partialTranslationValue
                    let diff = self.screenBounds.height - maxHeight + 80 + translationDiff
                    self.handleTranslationValue(diff)
                }
                
                if value == 1 {
                    self.partialTranslationValue = 0
                    self.videoPlayerView?.isMinimized = !shouldMaximize
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.videoPlayerView?.controlsContainerView.alpha = shouldMaximize ? 1 : 0
                })
            }, duration: 0.25)
            
        } else {
            startInterpolationInterpolationHandler({ (value) in
                var shouldMaximize = false
                
                if self.partialTranslationValue > (self.screenBounds.height - maxHeight) / 2 {
                    shouldMaximize = false
                    self.handleTranslationValue(self.partialTranslationValue + (self.screenBounds.height - self.partialTranslationValue) * value)
                } else {
                    shouldMaximize = true
                    self.handleTranslationValue(self.partialTranslationValue - self.partialTranslationValue * value)
                }
                
                if value == 1 {
                    self.partialTranslationValue = 0
                    
                    self.videoPlayerView?.isMinimized = !shouldMaximize
                }
            }, duration: 0.25)
        }
    }
    
    func handleTranslationValue(_ value: CGFloat) {

        let maxHeight = 9 / 16 * screenBounds.width
        
        let val = max(0, value)
        
        let minWidth = minHeight * 16 / 9
        
        let percentageDisplaced = val / (screenBounds.height) * 0.8
        let heightDiff = percentageDisplaced * maxHeight
        let widthDiff = 16 / 9 * heightDiff
        
        let playerHeight = maxHeight - heightDiff
        let playerWidth = screenBounds.width - widthDiff
        videoPlayerView?.frame = CGRect(x: 0, y: min(heightDiff, maxHeight - minHeight - rightMargin-129), width: max(playerWidth, minWidth), height: max(playerHeight, minHeight))
        videoPlayerView?.playerLayer?.frame = CGRect(x: 0, y: min(heightDiff, maxHeight - minHeight - rightMargin-129), width: max(playerWidth, minWidth), height: max(playerHeight, minHeight))
        videoPlayerView?.playerLayer?.removeAllAnimations()
        
        //videoPlayerView?.layer.frame = CGRect(x: 0, y: min(heightDiff, maxHeight - minHeight - rightMargin), width: max(playerWidth, minWidth), height: max(playerHeight, minHeight))
        //videoPlayerView?.frame = videoPlayerView!.playerLayer!.frame
        videoDetailCollectionView.alpha = max(0, 1 - percentageDisplaced * 3)
        //videoDetailCollectionView
        let x = max(0, min(heightDiff * 16/9 - percentageDisplaced * rightMargin, rightMargin))
        let y = max(0, min(val, screenBounds.height - maxHeight + 80))
        frame = CGRect(x: x, y: y, width: max(playerWidth, minWidth), height: max(playerHeight, minHeight))
        videoPlayerView?.controlsContainerView.alpha = 1 - val / (screenBounds.height - minHeight) * 1.2
        //backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class VideoPlayerView: UIView {
    
    var videoDetailView: VideoDetailView?
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Circled Pause Filled-100")
        button.setImage(image, for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    lazy var minimizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down-96"), for: UIControlState())
        button.addTarget(self, action: #selector(handleMinimize), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var fullscreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Full Screen Filled-100"), for: UIControlState())
        button.addTarget(self, action: #selector(handleFullscreen), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 16.5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        let bookmarkImage = UIImage(named: "Menu 2 Filled-100")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = false
    var isMinimized = false {
        didSet {
            if isMinimized == false {
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            }else{
                UIApplication.shared.setStatusBarHidden(false, with: .fade)
            }
        }
    }
    
    func handleMinimize() {
        videoDetailView?.minimize()
        isMinimized = true
        //UIView.animate(withDuration: 0.2, animations: {
        //    self.alpha = 0
        //})
    }
    
    func handleMore(){
        print("handleMore")
    }
    
    func handleFullscreen(){
        print("handleFullscreen")
    }
    
    var widthConstraint: NSLayoutConstraint?
    var trackHandleLeftConstraint: NSLayoutConstraint?
    
    func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "Circled Play Filled-100"), for: UIControlState())
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "Circled Pause Filled-100"), for: UIControlState())
        }
        
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
    
    func handleSliderChange() {
        print(videoSlider.value)
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //perhaps do something later here
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        setupGradientLayer()
        addSubview(controlsContainerView)
        addConstraint(format: "H:|[v0]|", views: controlsContainerView)
        addConstraint(format: "V:|[v0]|", views: controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(fullscreenButton)
        fullscreenButton.rightAnchor.constraint(equalTo: controlsContainerView.rightAnchor, constant: -8).isActive = true
        fullscreenButton.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor, constant: -2).isActive = true
        fullscreenButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        fullscreenButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: fullscreenButton.leftAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlsContainerView.addSubview(minimizeButton)
        minimizeButton.topAnchor.constraint(equalTo: controlsContainerView.topAnchor, constant: 10).isActive = true
        minimizeButton.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor, constant: 10).isActive = true
        minimizeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        minimizeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainerView.addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: controlsContainerView.topAnchor, constant: 10).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor, constant: 40).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 33).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        controlsContainerView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        controlsContainerView.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true

        
        controlsContainerView.addSubview(moreButton)
        //top constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: 0))
        //left constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: controlsContainerView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 33))
        //width constraint
        addConstraint(NSLayoutConstraint(item: moreButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 33))
        
        backgroundColor = .black
    }
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    fileprivate func setupPlayerView() {
        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            playerLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            layer.addSublayer(playerLayer!)
            //playerLayer?.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            //track player progress
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                //lets move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                    
                }
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            self.perform(#selector(self.hideControls), with: self, afterDelay: 3)
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    func hideControls() {
        UIView.animate(withDuration: 0.5, animations: {
            self.controlsContainerView.alpha = 0
        })
    }
    
    func showControls() {
        UIView.animate(withDuration: 0.5, animations: {
            self.controlsContainerView.alpha = 1
        })
    }
    
    func showControlsBriefly() {
        if controlsContainerView.alpha == 1 {
            self.controlsContainerView.alpha = 0
        }else{
            UIView.animate(withDuration: 0.0, animations: {
                self.controlsContainerView.alpha = 1
            }, completion: { (completed) in
                self.perform(#selector(self.hideControls), with: self, afterDelay: 3.5)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoDetailCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    let commentHeaderId = "commentHeaderId"
    let commentCellId = "commentCellId"
    
    /*var video: Video? {
        didSet {
            reloadData()
        }
    }*/
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        alwaysBounceVertical = true
        
        register(RelatedVideoCell.self, forCellWithReuseIdentifier: cellId)
        register(VideoDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        register(CommentsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: commentHeaderId)
        register(CommentCell.self, forCellWithReuseIdentifier: commentCellId)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let commentCount = video?.comments?.count, section == 1 {
//            return commentCount
//        }
//        if let count = video?.relatedVideos?.count, section == 0 {
//            return count
//        }
        if section == 0 {
            return 4
        }
        if section == 1 {
            return 4
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RelatedVideoCell
            //cell.video = video?.relatedVideos?[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellId, for: indexPath) as! CommentCell
            //cell.comment = video?.comments?[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! VideoDetailHeader
            //header.video = video
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: commentHeaderId, for: indexPath) as! CommentsHeader
            //header.video = video
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: section == 0 ? 150 : 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: frame.width, height: 96)
        } else {
//            if let attributedText = video?.comments?[indexPath.item].attributedText() {
//                let size = CGSize(width: frame.width - 90, height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let height = attributedText.boundingRect(with: size, options: options, context: nil).size.height
//                return CGSize(width: frame.width, height: max(68, height + 20))
//            }
            return CGSize(width: frame.width, height: max(68, height + 20))
        }
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(16, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 16 : 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

