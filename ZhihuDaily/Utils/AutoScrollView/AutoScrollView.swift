//
//  AutoScrollView.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/10.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

protocol AutoScrollDelegate: NSObjectProtocol {
    func scrollViewDidClickAtIndex(_ index: Int)
}

class AutoScrollView: UIView {
    weak var delegate: AutoScrollDelegate?
    var scrollTimer: Timer?
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 220))
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl(frame: CGRect(x: 0, y: 200, width: ScreenWidth, height: 10))
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    var scrollHeight: CGFloat! {
        didSet {
            self.pageControl.frame = CGRect(x: 0, y: scrollHeight - 20, width: ScreenWidth, height: 10)
            self.scrollView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: scrollHeight)
            let subView = self.scrollView.subviews[self.pageControl.currentPage + 1]
            let topView = subView as! DetailTopView
            topView.frame.size.height = scrollHeight
        }
    }
    
    var storyArray: [Stories]! {
        willSet {
            self.storyArray = newValue
        }
        didSet {
            for subView in self.scrollView.subviews {
                subView.removeFromSuperview()
            }
            let leftView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[1] as! DetailTopView
            leftView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 220)
            self.scrollView.addSubview(leftView)
            
            let rightView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[1] as! DetailTopView
            rightView.frame = CGRect(x: ScreenWidth * CGFloat(storyArray.count + 1), y: 0, width: ScreenWidth, height: 220)
            
            for i in 0 ..< storyArray.count {
                let topView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[1] as! DetailTopView
                topView.frame = CGRect(x: ScreenWidth * CGFloat(i + 1), y: 0, width: ScreenWidth, height: 220)
                topView.story = storyArray[i]
                if i == 0 {
                    rightView.story = storyArray[i]
                    if storyArray.count == 1 {
                        leftView.story = storyArray[i]
                    }
                } else if i == storyArray.count - 1 {
                    leftView.story = storyArray[i]
                }
                self.scrollView.addSubview(topView)
                
                topView.newsButton.isHidden = false
                topView.newsButton.tag = 1000 + i
                topView.newsButton.addTarget(self, action: #selector(clickScrollItem(_:)), for: .touchUpInside)
            }
            
            self.scrollView.addSubview(rightView)
            
            self.pageControl.numberOfPages = storyArray.count
            self.pageControl.currentPage = 0
            self.scrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(storyArray.count + 2), height: 220)
            self.scrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    private func createSubviews() -> Void {
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
    }
    
    func startScroll() -> Void {
        guard let _ = scrollTimer else {
            scrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
            return
        }
    }
    
    func autoScroll() -> Void {
        UIView.animate(withDuration: 0.75, animations: { 
            let index = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: ScreenWidth * CGFloat(index + 2), y: 0)
        }) { (finished) in
            self.scrollWithScrollView(self.scrollView)
        }
    }
    
    func scrollWithScrollView(_ scrollView: UIScrollView) -> Void {
        let point = scrollView.contentOffset
        self.pageControl.currentPage = Int(point.x / ScreenWidth) - 1
        if point.x == ScreenWidth * CGFloat(self.storyArray.count + 1) {
            self.scrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
            self.pageControl.currentPage = 0
        } else if point.x == 0 {
            self.scrollView.contentOffset = CGPoint(x: ScreenWidth * CGFloat(self.storyArray.count), y: 0)
            self.pageControl.currentPage = self.storyArray.count - 1
        }
    }
    
    func clickScrollItem(_ button: UIButton) -> Void {
        let index = button.tag - 1000
        self.delegate?.scrollViewDidClickAtIndex(index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AutoScrollView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startScroll()
        scrollWithScrollView(self.scrollView)
    }
    
    func removeTimer() -> Void {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
}
