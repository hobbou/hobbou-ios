//
//  ContentDetailController.swift
//  hobbou
//
//  Created by Hans Yonathan on 11/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import AVFoundation

class VideoDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var videoPlayerView: VideoPlayerView?
    
//    var video: Video? {
//        didSet {
//            collectionView?.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        //        let height = 9 / 16 * view.frame.width
        //        videoPlayerView = VideoPlayerView(frame: CGRectMake(0, 0, view.frame.width, height))
        //        view.addSubview(videoPlayerView!)
        //        videoPlayerView?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        collectionView?.backgroundColor = UIColor.red
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(RelatedVideoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(VideoDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        //        view.addConstraintsWithFormat("H:|[v0]|", views: collectionView!)
        //        view.addConstraintsWithFormat("V:|-\(height)-[v0]|", views: collectionView!)
        //        collectionView?.contentInset = UIEdgeInsetsMake(height, 0, 0, 0)
        //        collectionView?.frame = CGRectMake(0, height, view.frame.width, view.frame.height)
    }
    
    let minWidth: CGFloat = 140
    let rightMargin: CGFloat = 5
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y < 0 {
            return
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let height = 9 / 16 * screenWidth
        
        let newWidth = screenWidth - (translation.y * minWidth / screenWidth) - (translation.y * rightMargin / screenWidth)
        let newHeight = 9 / 16 * newWidth
        
        let newX = translation.y * minWidth / screenWidth
        let newY = 9 / 16 * newX
        
        videoPlayerView?.playerLayer?.frame = CGRect(x: 0, y: newY + (translation.y * rightMargin / screenWidth) / 2, width: newWidth, height: newHeight)
        videoPlayerView?.playerLayer?.removeAllAnimations()
        videoPlayerView?.controlsContainerView.frame = CGRect(x: 0, y: newY + (translation.y * rightMargin / screenWidth) / 2, width: newWidth, height: newHeight)
        view.frame = CGRect(x: newX, y: translation.y + (translation.y * rightMargin / screenWidth), width: view.frame.width, height: view.frame.height)
        
        collectionView?.frame = CGRect(x: 0, y: height, width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = video?.relatedVideos?.count {
//            return count
//        }
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RelatedVideoCell
        //cell.video = video?.relatedVideos?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! VideoDetailHeader
        //header.video = video
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(16, 0, 16, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

