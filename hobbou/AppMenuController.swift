//
//  AppMenuController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class AppMenuController: MenuController {
    fileprivate let baseSize = CGSize(width: 56, height: 56)
    fileprivate let bottomInset: CGFloat = 77
    fileprivate let rightInset: CGFloat = 24
    
    open override func prepare() {
        super.prepare()
        view.backgroundColor = Color.grey.lighten5
        
        prepareMenu()
    }
    
    open override func openMenu(completion: ((UIView) -> Void)? = nil) {
        super.openMenu(completion: completion)
        menu.views.first?.animate(animation: Motion.rotate(angle: 45))
    }
    
    open override func closeMenu(completion: ((UIView) -> Void)? = nil) {
        super.closeMenu(completion: completion)
        menu.views.first?.animate(animation: Motion.rotate(angle: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = NSLocalizedString("hobbou", comment: "for appmenucontroller")
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        // Do any additional setup after loading the view.
        setupNavBarButtons()
    }
    
    func setupNavBarButtons(){
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let searchImage = UIImage(named: "Search Filled-100")?.withRenderingMode(.alwaysTemplate)
        searchButton.setBackgroundImage(searchImage, for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        searchButton.showsTouchWhenHighlighted = true
        let searchBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let moreImage = UIImage(named: "Circled User Male Filled-100")?.withRenderingMode(.alwaysTemplate)
        moreButton.setBackgroundImage(moreImage, for: .normal)
        moreButton.tintColor = .white
        moreButton.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        moreButton.showsTouchWhenHighlighted = true
        let moreBarButtonItem = UIBarButtonItem(customView: moreButton)

        navigationItem.rightBarButtonItems = [
            moreBarButtonItem,
            searchBarButtonItem,
        ]
    }

    func handleSearch(){
        print("handleSearch")
        let searchViewController = SearchViewController()
        let appSearchBarController = AppSearchBarController(rootViewController: searchViewController)
        present(appSearchBarController, animated: true, completion: nil)
    }
        
    func handleProfile(){
        print("handleProfile")
        let accountViewController = AccountViewController()
        accountViewController.appMenuController = self
        present(AppAccountNavigationBarController(rootViewController: accountViewController)
, animated: true, completion: nil)
        
    }
    
    func handleClose(){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AppMenuController {
    fileprivate func prepareMenu() {
        menu.baseSize = baseSize
        
        view.layout(menu)
            .size(baseSize)
            .bottom(bottomInset)
            .right(rightInset)
    }
}
