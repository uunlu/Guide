//
//  GuideCollectionViewLayout.swift
//  Guide
//
//  Created by arbenjusufhayati on 11/8/17.
//  Copyright © 2017 HASELT. All rights reserved.
//

import UIKit

protocol GuideLayoutDelegate {
    func collectionViewCellWidthFor(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat
}

class GuideCollectionViewLayout: UICollectionViewLayout {
    
    var delegate: GuideLayoutDelegate!
    
    private var cellHeaderHeight : CGFloat = 30
    private var cellHeight : CGFloat = 60
    // private var cellWidth : CGFloat = 135
    private var contentWidth = CGFloat(cellWidth * hoursData.count)
    private var cellAttributeDict = [IndexPath: UICollectionViewLayoutAttributes]()
    private var contentSize = CGSize(width: 100, height: 30)//CGSize.zero
    var contentSizes = [IndexPath: CGSize]()
    private var dataSourceDidUpdate = true
    func setCellSize(size:CGSize){
        self.cellHeight = size.height
        //self.width = size.width
    }
    
    // MARK: Layout Delegates
    
    override var collectionViewContentSize : CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        
        if !dataSourceDidUpdate {
            
            // Determine current content offsets.
            let xOffset = collectionView!.contentOffset.x
            let yOffset = collectionView!.contentOffset.y
            
            if let sectionCount = collectionView?.numberOfSections, sectionCount > 0 {
                for section in 0...sectionCount-1 {
                    
                    // Confirm the section has items.
                    if let rowCount = collectionView?.numberOfItems(inSection: section) {
                        
                        // Update all items in the first row.
                        if section == 0 {
                            for item in 0..<rowCount {
                                
                                // Build indexPath to get attributes from dictionary.
                                let indexPath = IndexPath(item: item, section: section)
                                
                                // Update y-position to follow user.
                                if let attrs = cellAttributeDict[indexPath] {
                                    var frame = attrs.frame
                                    
                                    // Also update x-position for corner cell.
                                    if item == 0 {
                                        frame.origin.x = xOffset
                                    }
                                    
                                    frame.origin.y = yOffset
                                    attrs.frame = frame
                                }
                                
                            }
                            
                            // For all other sections, we only need to update
                            // the x-position for the fist item.
                        } else {
                            
                            // Build indexPath to get attributes from dictionary.
                            let indexPath = IndexPath(item: 0, section: section)
                            
                            // Update y-position to follow user.
                            if let attrs = cellAttributeDict[indexPath] {
                                var frame = attrs.frame
                                frame.origin.x = xOffset
                                attrs.frame = frame
                            }
                            
                        } // else
                    } // num of items in section > 0
                } // sections for loop
            } // num of sections > 0
            
            
            // Do not run attribute generation code
            // unless data source has been updated.
            return
        }
        // dataSourceDidUpdate = false
        
        // prepare cell
        
        if let sectionCount = collectionView?.numberOfSections {
            for section in 0..<sectionCount {
                if let rowCount = collectionView?.numberOfItems(inSection: section) {
                    for item in 0..<rowCount {
                        //                        let totalOffset = contentSizes.filter{ $0.key.section == section && $0.key.item < item}.map{ $0.value.width}
                        let indexPath = IndexPath(item: item, section: section)
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        let calculatedWidth = delegate.collectionViewCellWidthFor(collectionView: collectionView!, indexPath: indexPath)
                        
                        let totalOffset = contentSizes.filter{ $0.key.section == section && $0.key.item < item}.map{ $0.value.width}
                        
                        var total:CGFloat = 0
                        
                        for v in totalOffset {
                            total += v
                        }
                        
                        let xPos = total
                        let yPos = section == 0 ? 0 : self.cellHeight * CGFloat(section-1) + self.cellHeaderHeight + 2
                        
                        // header cell
                        if section == 0 {
                            cellAttributes.frame = CGRect(x: xPos, y: yPos, width: calculatedWidth, height: self.cellHeaderHeight)
                        }else{ // content cells
                            cellAttributes.frame = CGRect(x: xPos, y: yPos, width: calculatedWidth, height: self.cellHeight)
                        }
                        
                        
                        // Determine zIndex based on cell type.
                        if item == 0 && section == 0  {
                            cellAttributes.zIndex = 5
                        } else if section == 0 {
                            cellAttributes.zIndex = 4
                        } else if item == 0 {
                            cellAttributes.zIndex = 3
                        } else if item == 0 && section != 0 {
                            cellAttributes.zIndex = 2
                        } else {
                            cellAttributes.zIndex = 1
                        }
                        cellAttributeDict[indexPath] = cellAttributes
                    }
                }
            }
        }
        
        let contentHeight = CGFloat(collectionView!.numberOfSections) * self.cellHeight
        self.contentSize = CGSize(width: self.contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check cells in the visible rectangle to return attributes
        for cellAttributes in self.cellAttributeDict.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        return attributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributeDict[indexPath]!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

