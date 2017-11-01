//
//  UICollectionViewGridLayout.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/20.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

open class UICollectionViewGridLayout: UICollectionViewLayout
{
    open override var collectionViewContentSize: CGSize {
        return self.collectionView?.bounds.size ?? .zero
    }
    
    open override func prepare() {
        
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return nil
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
}
