//
//  AppAccountNavigationBar.swift
//  hobbou
//
//  Created by Hans Yonathan on 10/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class AppAccountNavigationBarController: StatusBarController {
    
    private var closeButton: IconButton!
    private var titleLabel: UILabel!
    open let bar = Bar()

    open var display = Display.partial {
        didSet {
            layoutSubviews()
        }
    }
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let y = Application.shouldStatusBarBeHidden || statusBar.isHidden ? 0 : statusBar.height
        let p = y + bar.height
        
        bar.y = y
        bar.width = view.width
        
        switch display {
        case .partial:
            rootViewController.view.y = p
            rootViewController.view.height = view.height - p
        case .full:
            rootViewController.view.frame = view.bounds
        }
    }
    
    open override func prepare() {
        super.prepare()
        prepareStatusBar()
        prepareBar()
        prepareCloseButton()
        prepareTitleLabel()
        statusBarStyle = .lightContent
        bar.leftViews = [closeButton]
        bar.centerViews = [titleLabel]
    }
    
    private func prepareCloseButton() {
        closeButton = IconButton(image: Icon.cm.close)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
    }
    
    private func prepareTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = NSLocalizedString("Account", comment: "for appmenucontroller")
    }

    @objc private func handleCloseButton(){
        print("close")
        dismiss(animated: true, completion: nil)
    }
    
}

extension AppAccountNavigationBarController{

    /// Prepares the statusBar.
    fileprivate func prepareStatusBar() {
        shouldHideStatusBarOnRotation = false
        statusBar.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
    }
    
    /// Prepares the searchBar.
    fileprivate func prepareBar() {
        bar.depthPreset = .depth1
        bar.zPosition = 1000
        bar.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        view.addSubview(bar)
    }
}
