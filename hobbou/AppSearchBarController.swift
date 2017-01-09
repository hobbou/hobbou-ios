//
//  AppSearchBarController.swift
//  hobbou
//
//  Created by Hans Yonathan on 9/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class AppSearchBarController: SearchBarController {
    private var backButton: IconButton!
    private var moreButton: IconButton!
    
    open override func prepare() {
        super.prepare()
        prepareBackButton()
        prepareMoreButton()
        prepareStatusBar()
        prepareSearchBar()
    }
    
    private func prepareBackButton() {
        backButton = IconButton(image: Icon.cm.arrowBack)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    }
    
    @objc private func handleBackButton(){
        print("back")
        navigationController?.popViewController(animated: true)
    }
    
    private func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical)
    }
    
    private func prepareStatusBar() {
        statusBarStyle = .lightContent
        
        // Access the statusBar.
        //        statusBar.backgroundColor = Color.grey.base
    }
    
    private func prepareSearchBar() {
        searchBar.leftViews = [backButton]
        searchBar.rightViews = [moreButton]
    }
}
