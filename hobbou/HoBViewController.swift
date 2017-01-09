//
//  HallOfBouViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class HoBViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HoBViewController {
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.title = NSLocalizedString("Hall of Bou", comment: "for hobviewcontroller")
        pageTabBarItem.titleColor = Color.blueGrey.base
    }
}
