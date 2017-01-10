//
//  SearchViewController.swift
//  hobbou
//
//  Created by Hans Yonathan on 9/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit
import Material

class SearchViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    let searchCellId = "searchCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Prepare view.
        prepareSearchBar()
        /*prepareTableView()
        
        // Prepare model.
        prepareGraph()
        prepareSearch()*/
    }

    func setupCollectionView(){
        view.addSubview(collectionView)
        view.addConstraint(format: "H:|[v0]|", views: collectionView)
        view.addConstraint(format: "V:|[v0]|", views: collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: searchCellId)
        collectionView.alwaysBounceVertical = true
        //collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        //collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath) as! SearchCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

/// Model.
extension SearchViewController {
    internal func prepareGraph() {
        //graph = Graph()
        
        // Uncomment to clear the Graph data.
        //        graph.clear()
    }
    
    internal func prepareSearch() {
        /*search = Search<Entity>(graph: graph).for(types: "User").where(properties: "name")
        
        search.async { [weak self] (data) in
            if 0 == data.count {
                SampleData.createSampleData()
            }
            self?.reloadData()
        }*/
    }
    
    
    internal func reloadData() {
        /*tableView.data = search.sync().sorted(by: { (a, b) -> Bool in
            guard let n = a["name"] as? String, let m = b["name"] as? String else {
                return false
            }
            return n < m
        })*/
    }
}

extension SearchViewController: SearchBarDelegate {
    internal func prepareSearchBar() {
        // Access the searchBar.
        guard let searchBar = searchBarController?.searchBar else {
            return
        }
        
        searchBar.delegate = self
    }
    
    func searchBar(searchBar: SearchBar, didClear textField: UITextField, with text: String?) {
        reloadData()
    }
    
    func searchBar(searchBar: SearchBar, didChange textField: UITextField, with text: String?) {
        guard let pattern = text?.trimmed, 0 < pattern.utf16.count else {
            reloadData()
            return
        }
        
        /*search.async { [weak self, pattern = pattern] (users) in
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                return
            }
            
            var data = [Entity]()
            
            for user in users {
                if let name = user["name"] as? String {
                    let matches = regex.matches(in: name, range: NSRange(location: 0, length: name.utf16.count))
                    if 0 < matches.count {
                        data.append(user)
                    }
                }
            }
            
            self?.tableView.data = data
        }*/
    }
}
