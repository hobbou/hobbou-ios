//
//  MainPageTabViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class MainPageTabViewController: PageTabBarController {
    var addButton: FabButton!
    fileprivate var soundBouMenuItem: MenuItem!
    fileprivate var vidBouMenuItem: MenuItem!
    fileprivate var pictBouMenuItem: MenuItem!
    fileprivate var storyBouMenuItem: MenuItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareMenuButton()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareMenuController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func prepare() {
        super.prepare()
        
        delegate = self
        preparePageTabBar()
    }
    
    override func preparePageTabBarItems() {
        super.preparePageTabBarItems()
        for button in pageTabBar.buttons{
            button.addTarget(self, action: #selector(handleToTop), for: .touchUpInside)
        }
    }
    
    func handleToTop(){
        for viewController in viewControllers {
            if let viewController = viewController as? HomeViewController{
                viewController.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
            }
        }
    }
        
    func hideFloatingMenu(){
        self.addButton.alpha = 0
        /*let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.addButton.alpha = 0
            }, completion: { (completed) in
                //self.containerView.alpha = 0
            })
        })*/
    }
    
    func showFloatingMenu(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.addButton.alpha = 1
        }) { (completed) in
            //self.containerView.isHidden = true
            //self.containerView.alpha = 1
        }
    }

}

extension MainPageTabViewController {
    
    fileprivate func preparePageTabBar() {
        pageTabBar.lineColor = Color.blueGrey.base
        pageTabBar.dividerColor = Color.blueGrey.lighten5
    }
    
    fileprivate func prepareAddButton() {
        addButton = FabButton(image: Icon.cm.add, tintColor: .white)
        addButton.pulseColor = .white
        addButton.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 19/255, alpha: 1)
        addButton.addTarget(self, action: #selector(handleToggleMenu), for: .touchUpInside)
    }
    
    fileprivate func prepareSoundBouButton() {
        soundBouMenuItem = MenuItem()
        soundBouMenuItem.button.image = Icon.cm.audio
        soundBouMenuItem.button.tintColor = .white
        soundBouMenuItem.button.pulseColor = .white
        soundBouMenuItem.button.backgroundColor = Color.green.base
        soundBouMenuItem.button.depthPreset = .depth1
        soundBouMenuItem.title = "SoundBou"
    }
    
    fileprivate func prepareVidBouButton() {
        vidBouMenuItem = MenuItem()
        vidBouMenuItem.button.image = Icon.cm.videocam
        vidBouMenuItem.button.tintColor = .white
        vidBouMenuItem.button.pulseColor = .white
        vidBouMenuItem.button.backgroundColor = Color.blue.base
        vidBouMenuItem.title = "VidBou"
        vidBouMenuItem.hideTitleLabel()
    }
    
    fileprivate func preparePictBouButton() {
        pictBouMenuItem = MenuItem()
        pictBouMenuItem.button.image = Icon.cm.photoCamera
        pictBouMenuItem.button.tintColor = .white
        pictBouMenuItem.button.pulseColor = .white
        pictBouMenuItem.button.backgroundColor = Color.brown.base
        pictBouMenuItem.title = "PictBou"
        pictBouMenuItem.hideTitleLabel()
    }
    
    fileprivate func prepareStoryBouButton() {
        storyBouMenuItem = MenuItem()
        storyBouMenuItem.button.image = Icon.cm.pen
        storyBouMenuItem.button.tintColor = .white
        storyBouMenuItem.button.pulseColor = .white
        storyBouMenuItem.button.backgroundColor = Color.purple.base
        storyBouMenuItem.title = "StoryBou"
        storyBouMenuItem.hideTitleLabel()
    }
    
    fileprivate func prepareMenuButton(){
        prepareAddButton()
        prepareVidBouButton()
        preparePictBouButton()
        prepareSoundBouButton()
        prepareStoryBouButton()
    }
    
    fileprivate func prepareMenuController() {
        guard let mc = menuController as? AppMenuController else {
            return
        }
        
        mc.menu.delegate = self
        mc.menu.views = [addButton, pictBouMenuItem, storyBouMenuItem, vidBouMenuItem, soundBouMenuItem]
        mc.menu.direction = .bou
    }
    
    @objc
    fileprivate func handleToggleMenu(button: Button) {
        guard let mc = menuController as? AppMenuController else {
            return
        }
        
        if mc.menu.isOpened {
            mc.closeMenu { (view) in
                (view as? MenuItem)?.hideTitleLabel()
            }
        } else {
            mc.openMenu { (view) in
                
                //(view as? MenuItem)?.showTitleLabel()
            }
        }
    }
    
}

extension MainPageTabViewController: PageTabBarControllerDelegate {
    
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
    
}

extension MainPageTabViewController: MenuDelegate {
    func menu(menu: Menu, tappedAt point: CGPoint, isOutside: Bool) {
        guard isOutside else {
            return
        }
        
        guard let mc = menuController as? AppMenuController else {
            return
        }
        
        mc.closeMenu { (view) in
            (view as? MenuItem)?.hideTitleLabel()
        }
    }
}
