//
//  ViewController.swift
//  Guide
//
//  Created by arbenjusufhayati on 11/8/17.
//  Copyright © 2017 HASELT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataContent = [IndexPath:CGSize]()
    private let cellId = "GuideCell"
    private let cellHeaderId = "HeaderCell"
    private let cellHeight = 60
    
    // MARK: Collection view delegates
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var unique = [Int: Any]()
        for item in dataContent.keys {
            unique[item.section] = item
        }
        return unique.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataContent.filter{ $0.key.section == section}.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: GuideCollectionViewCell!
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellHeaderId, for: indexPath) as! GuideCollectionViewCell
            cell.showName?.text = "\(hoursData[indexPath.item])"
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! GuideCollectionViewCell
        }
        
        if indexPath.item == 0 {
            //  cell.backgroundColor = .black
            // cell.bounds = CGRect(x: 0, y: 0, width: 50, height: cellHeight)
            
        }
        
        if indexPath.section == 0 {
            
        }else if indexPath.item == 0 && indexPath.section == 1{
            cell.showName.text = "EuroSport"
        }
        else if indexPath.item == 0 && indexPath.section == 2{
            cell.showName.text = "Sky Sport 6 HD"
        }
        else {
            cell.showName.text = "Sec \(indexPath.section)/item \(indexPath.row)"
        }
        
        return cell
    }
    
    func loadData() {
        
        // header cells
        
        for index in 0...hoursData.count {
            if index == 0 {
                dataContent[IndexPath(item: index, section: 0 )] = CGSize(width: 50, height: cellHeight/2)
            }else{
                dataContent[IndexPath(item: index, section: 0 )] = CGSize(width: 135, height: cellHeight/2)
            }
        }
        
        dataContent[IndexPath(item: 0, section: 1)] = CGSize(width: 50, height: cellHeight)
        dataContent[IndexPath(item: 1, section: 1)] = CGSize(width: 100, height: cellHeight)
        dataContent[IndexPath(item: 2, section: 1)] = CGSize(width: 100, height: cellHeight)
        dataContent[IndexPath(item: 3, section: 1)] = CGSize(width: 150, height: cellHeight)
        dataContent[IndexPath(item: 4, section:1)] = CGSize(width: 150, height: cellHeight)
        dataContent[IndexPath(item: 5, section:1)] = CGSize(width: 100, height: cellHeight)
        dataContent[IndexPath(item: 5, section:1)] = CGSize(width: 50, height: cellHeight)
        dataContent[IndexPath(item: 5, section:1)] = CGSize(width: 100, height: cellHeight)
        
        
        dataContent[IndexPath(item: 0, section:2 )] = CGSize(width: 50, height: cellHeight)
        dataContent[IndexPath(item: 1, section:2 )] = CGSize(width: 60, height: cellHeight)
        dataContent[IndexPath(item: 2, section:2 )] = CGSize(width: 40, height: cellHeight)
        dataContent[IndexPath(item: 3, section:2 )] = CGSize(width: 130, height: cellHeight)
        dataContent[IndexPath(item: 4, section:2 )] = CGSize(width: 50, height: cellHeight)
        dataContent[IndexPath(item: 5, section:2 )] = CGSize(width: 50, height: cellHeight)
        dataContent[IndexPath(item: 6, section:2 )] = CGSize(width: 70, height: cellHeight)
        dataContent[IndexPath(item: 7, section:2 )] = CGSize(width: 90, height: cellHeight)
        dataContent[IndexPath(item: 8, section:2 )] = CGSize(width: 60, height: cellHeight)
        dataContent[IndexPath(item: 9, section:2 )] = CGSize(width: 100, height: cellHeight)
    }
    
    // MARK: View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadData()
        
        // delegates
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let layout = self.collectionView.collectionViewLayout as? GuideCollectionViewLayout {
            layout.delegate = self
            for item in self.dataContent {
                layout.contentSizes[item.key] = item.value
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : GuideLayoutDelegate {
    
    func collectionViewCellWidthFor(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat {
        let contentSize = self.dataContent[indexPath]
        return (contentSize?.width)!
    }
}

