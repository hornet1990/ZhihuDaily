//
//  NewsTodayViewController.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON
import FDFullscreenPopGesture

class NewsTodayViewController: UIViewController {

    var presenter: NewsTodayPresenter?
    var topBarView: NewsTopView?
    var headerView: UIView?
    
    lazy var newTableView: UITableView = {
        var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "NewsTodayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsCell")
        return tableView
    }()
    
    lazy var autoScroll: AutoScrollView = {
        var autoScroll = AutoScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 220))
        autoScroll.delegate = self
        return autoScroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.fd_prefersNavigationBarHidden = true
        
        view.addSubview(self.newTableView)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 220))
        newTableView.tableHeaderView = containerView
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 220))
        newTableView.addSubview(headerView!)
        
        headerView?.addSubview(self.autoScroll)
        
        topBarView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)![0] as? NewsTopView
        topBarView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 58)
        topBarView?.leftButton.addTarget(self, action: #selector(openDrawer), for: UIControlEvents.touchUpInside)
        view.addSubview(topBarView!)
        
        presenter = NewsTodayPresenter()
        presenter?.delegate = self
        presenter?.loadListData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerVC.openDrawerGestureModeMask = .all
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func openDrawer() -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerVC.toggle(.left, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsTodayViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let pre = presenter {
            return pre.listArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pre = presenter {
            let array = pre.listArray[section]
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell: NewsTodayTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTodayTableViewCell
        newsCell.selectionStyle = .none
        if let pre = presenter {
            let array = pre.listArray[indexPath.section]
            if array.count > 0 {
                newsCell.stories = array[indexPath.row]
            }
        }
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 11, width: ScreenWidth, height: 16))
        sectionLabel.font = UIFont.systemFont(ofSize: 14.0)
        sectionLabel.textColor = .white
        sectionLabel.textAlignment = .center
        
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 38))
        sectionHeaderView.backgroundColor = UIColor(red:1 / 255.0, green:143 / 255.0, blue:214 / 255.0, alpha:1.0)
        sectionHeaderView.addSubview(sectionLabel)
        
        if let pre = presenter {
            let headerStr = pre.headerArray[section]
            sectionLabel.text = headerStr
        }
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        } else {
            return 38
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15 + 60 * ScreenWidth / 375 + 16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pre = presenter {
            let array = pre.listArray[indexPath.section]
            if array.count > 0 {
                let stories = array[indexPath.row]
                let detailVC = NewsDetailViewController()
                detailVC.newsId = stories.storyId
                var array = [String]()
                for items in pre.listArray {
                    for stories in items {
                        array.append(stories.storyId)
                    }
                }
                detailVC.idArray = array
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsTodayViewController: NewsTodayPresenterDelegate, UIScrollViewDelegate, AutoScrollDelegate {
    func newTodayPresenter(_ error: Error?, json: Any?) {
        if let err = error {
            print(err)
        } else {
            self.newTableView.reloadData()
            if let pre = presenter {
                if pre.topArray.count > 0 {
                    autoScroll.storyArray = pre.topArray
                    autoScroll.startScroll()
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.topBarView?.refreshView.hideIndicator()
        }
    }
    
    func newBeforePresenter(_ error: Error?, json: Any?) {
        if let err = error {
            print(err)
        } else {
            self.newTableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == newTableView {
            let offsetY = scrollView.contentOffset.y
            let color = UIColor(red:1 / 255.0, green:143 / 255.0, blue:214 / 255.0, alpha:(offsetY - 40) / 220.0)
            topBarView?.topView.backgroundColor = color
            topBarView?.bottomView.backgroundColor = color
            if offsetY < 0 && offsetY > -64 {
                headerView?.frame = CGRect(x: 0, y: offsetY, width: ScreenWidth, height: 220 + -offsetY)
                autoScroll.scrollHeight = 220 + -offsetY
                if let _ = autoScroll.scrollTimer {
                    autoScroll.removeTimer()
                }
                topBarView?.refreshView.isHidden = false
            }
            if offsetY < -64 {
                newTableView.contentOffset = CGPoint(x: 0, y: -64)
            }
            topBarView?.refreshView.scrollOffSetY = offsetY
            
            if offsetY < 44 && offsetY >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            } else if offsetY >= 44 {
                scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
            }
            
            var count = 0
            if let pre = presenter {
                let array: [Stories] = pre.listArray[0]
                count = array.count
            }
            let rowHeight = 15 + 60 * ScreenWidth / 375 + 16
            let hideY = 220 + CGFloat(count) * rowHeight + 38 - 58
            if offsetY > hideY {
                topBarView?.bottomView.alpha = 0.0
                topBarView?.centerTitleLabel.alpha = 0.0
            } else {
                topBarView?.bottomView.alpha = 1.0
                topBarView?.centerTitleLabel.alpha = 1.0
            }
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == newTableView {
            let offsetY = scrollView.contentOffset.y
            if offsetY == 0 {
                guard let _ = autoScroll.scrollTimer else {
                    autoScroll.startScroll()
                    return;
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == newTableView {
            let offsetY = scrollView.contentOffset.y
            if offsetY < -60 {
                topBarView?.refreshView.showIndicator()
                presenter?.loadListData()
            }
            if offsetY > scrollView.contentSize.height - scrollView.frame.size.height + 44 {
                presenter?.loadBeforeData()
            }
        }
    }
// MARK: - ScrollViewDelegate
    func scrollViewDidClickAtIndex(_ index: Int) {
        if let pre = presenter {
            if pre.topArray.count > 0 {
                let story = pre.topArray[index]
                let detailVC = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: Bundle.main)
                detailVC.newsId = story.storyId
                var array = [String]()
                for items in pre.listArray {
                    for stories in items {
                        array.append(stories.storyId)
                    }
                }
                detailVC.idArray = array
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
