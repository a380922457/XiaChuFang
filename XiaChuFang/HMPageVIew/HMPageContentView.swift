//
//  HMPageContentView.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

public protocol HMPageContentViewDelegate: class {
    func contentView(_ contentView: HMPageContentView, inIndex: Int)
    func contentView(_ contentView: HMPageContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat)
}


private let CellID = "CellID"
open class HMPageContentView: UIView {
    
    public weak var delegate: HMPageContentViewDelegate?
    
    public weak var reloader: HMPageReloadable?
    
    public var style: HMPageStyle
    
    public var childViewControllers : [UIViewController]
    
    /// 初始化后，默认显示的页数
    public var startIndex: Int = 0
    
    private var startOffsetX: CGFloat = 0
    
    private var isForbidDelegate: Bool = false
    
    private (set) public lazy var collectionView: UICollectionView = {
        let layout = HMPageCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        if #available(iOS 10, *) {
            collectionView.isPrefetchingEnabled = false
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellID)
        return collectionView
    }()
    
    
    public init(frame: CGRect, style: HMPageStyle, childViewControllers: [UIViewController], startIndex: Int = 0) {
        self.childViewControllers = childViewControllers
        self.style = style
        self.startIndex = startIndex
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.childViewControllers = [UIViewController]()
        self.style = HMPageStyle()
        super.init(coder: aDecoder)
    }
    

    override open func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        let layout = collectionView.collectionViewLayout as! HMPageCollectionViewFlowLayout
        layout.itemSize = bounds.size
        layout.offset = CGFloat(startIndex) * bounds.size.width
    }
}


extension HMPageContentView {
    public func setupUI() {
        addSubview(collectionView)
        
        collectionView.backgroundColor = style.contentViewBackgroundColor
        collectionView.isScrollEnabled = style.isContentScrollEnable

    }
}


extension HMPageContentView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let childVc = childViewControllers[indexPath.item]

        reloader = childVc as? HMPageReloadable
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}


extension HMPageContentView: UICollectionViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateUI(scrollView)
        
    }
    
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll(scrollView)
            
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll(scrollView)
    }
    
    
    func collectionViewDidEndScroll(_ scrollView: UIScrollView) {
        let inIndex = Int(round(collectionView.contentOffset.x / collectionView.bounds.width))
        
        let childVc = childViewControllers[inIndex]
        
        reloader = childVc as? HMPageReloadable
        
        reloader?.contentViewDidEndScroll?()
        
        delegate?.contentView(self, inIndex: inIndex)
        
    }

    
    
    private func updateUI(_ scrollView: UIScrollView) {
        if isForbidDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var targetIndex = 0
        var sourceIndex = 0
        
        
        progress = scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.bounds.width) / scrollView.bounds.width
        if progress == 0 {
            return
        }
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if collectionView.contentOffset.x > startOffsetX { // 左滑动
            sourceIndex = index
            targetIndex = index + 1
            if targetIndex > childViewControllers.count - 1 {
                return
            }
        } else {
            sourceIndex = index + 1
            targetIndex = index
            progress = 1 - progress
            if targetIndex < 0 {
                return
            }
        }
        
        if progress > 0.998 {
            progress = 1
        }
        
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}


extension HMPageContentView: HMPageTitleViewDelegate {
    public func titleView(_ titleView: HMPageTitleView, currentIndex: Int) {
        isForbidDelegate = true
        
        if currentIndex > childViewControllers.count - 1 {
            return
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)

        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}



