//
//  File.swift
//  hobbou
//
//  Created by Hans Yonathan on 5/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraint(format: String, views: UIView...){
        var viewsDict = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

extension UIButton {
    func alignTextUnderImage() {
        guard let imageView = imageView else {
            return
        }
        self.contentVerticalAlignment = .top
        self.contentHorizontalAlignment = .center
        let imageLeftOffset = (self.bounds.width - imageView.bounds.width) / 2//put image in center
        let titleTopOffset = imageView.bounds.height + 5
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageLeftOffset, 0, 0)
        self.titleEdgeInsets = UIEdgeInsetsMake(titleTopOffset, -imageView.bounds.width, 0, 0)
    }
}


class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageWithUrlString(urlString: String){
        let imageUrlString = URL(string: urlString)
        
        //set default image
        image = nil
        
    }
}
