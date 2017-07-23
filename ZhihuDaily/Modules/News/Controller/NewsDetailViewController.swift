//
//  NewsDetailViewController.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var detailWebView: UIWebView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var changeWebView: UIWebView?
    var changeTopView: DetailTopView?
    
    var idArray: [String]?
    
    var newsId: String!
    var presenter: NewsDetailPresenter?
    var topView: DetailTopView!
    var statusView: UIView?
    var refreshModel: DetailRefreshModel!
    var headerRefreshView: DetailRefreshView?
    var footerRefreshView: DetailRefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.fd_prefersNavigationBarHidden = true
        
        changeWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 43))
        self.view.addSubview(changeWebView!)
        self.view.sendSubview(toBack: changeWebView!)
        
        changeTopView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[1] as? DetailTopView
        changeTopView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 220)
        changeWebView?.scrollView.addSubview(changeTopView!)
        
        detailWebView.delegate = self
        detailWebView.scrollView.delegate = self
        presenter = NewsDetailPresenter()
        presenter?.delegate = self
        loadDetailData(newsId)
        
        topView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[1] as! DetailTopView
        topView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 220)
        detailWebView.scrollView.addSubview(topView)
        
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        statusView?.backgroundColor = .clear
        self.view.addSubview(statusView!)
        
        refreshModel = DetailRefreshModel(newsId: newsId, newsIdArray: idArray)
        changeNextButtonState()
        
        headerRefreshView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[2] as? DetailRefreshView
        headerRefreshView?.refreshType = .header
        headerRefreshView?.frame = CGRect(x: 0, y: -64, width: ScreenWidth, height: 60)
        headerRefreshView?.isHidden = true
        headerRefreshView?.refreshModel = refreshModel
        self.detailWebView.scrollView.addSubview(headerRefreshView!)
        
        footerRefreshView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?[2] as? DetailRefreshView
        footerRefreshView?.refreshType = .footer
        footerRefreshView?.isHidden = true
        footerRefreshView?.refreshModel = refreshModel
        self.detailWebView.scrollView.addSubview(footerRefreshView!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerVC.openDrawerGestureModeMask = .init(rawValue: 0)
    }

    @IBAction func didClickButton(_ sender: UIButton) {
        switch sender.tag {
        case 1001:
            backForward()
        case 1002:
            nextNews()
        case 1003:
            vote(sender)
        case 1004:
            share()
        case 1005:
            comment()
        default:
            backForward()
        }
    }
    
    func backForward() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func nextNews() {
        loadNextNews()
    }
    
    func vote(_ button: UIButton) {
        
    }
    
    func share() {
        
    }
    
    func comment() {
        
    }
    
    func loadDetailData(_ newsId: String) -> Void {
        presenter?.loadDetailData(newsId)
        presenter?.loadExtraData(newsId)
    }
    
    func loadNextNews() -> Void {
        let hasNext = refreshModel?.hasNext
        if let next = hasNext {
            if next {
                changeWebView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 43)
                detailWebView.frame = CGRect(x: 0, y: ScreenHeight - 43, width: ScreenWidth, height: ScreenHeight - 43)
                UIView.animate(withDuration: 0.3, animations: {
                    let newsId = self.refreshModel?.nextNewsId
                    self.loadDetailData(newsId!)
                    self.detailWebView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 43)
                    self.changeWebView?.frame = CGRect(x: 0, y: -ScreenHeight + 43, width: ScreenWidth, height: ScreenHeight - 43)
                })
//                let newsId = refreshModel?.nextNewsId
//                loadDetailData(newsId!)
            }
        }
    }
    
    func loadLastNews() -> Void {
        let hasLast = refreshModel?.hasLast
        if let last = hasLast {
            if last {
                changeWebView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 43)
                detailWebView.frame = CGRect(x: 0, y: -ScreenHeight + 43, width: ScreenWidth, height: ScreenHeight - 43)
                UIView.animate(withDuration: 0.3, animations: {
                    let newsId = self.refreshModel?.lastNewsId
                    self.loadDetailData(newsId!)
                    self.detailWebView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 43)
                    self.changeWebView?.frame = CGRect(x: 0, y: ScreenHeight - 43, width: ScreenWidth, height: ScreenHeight - 43)
                })
//                let newsId = refreshModel?.lastNewsId
//                loadDetailData(newsId!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeNextButtonState() -> Void {
        let hasNext = refreshModel?.hasNext
        if let next = hasNext {
            if next {
                nextButton.setImage(UIImage(named: "ico_next"), for: .normal)
                nextButton.isEnabled = true
            } else {
                nextButton.setImage(UIImage(named: "ico_end"), for: .normal)
                nextButton.isEnabled = false
            }
        }
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

extension NewsDetailViewController: NewsDetailPresenterDelegate, UIScrollViewDelegate, UIWebViewDelegate {
    func getDetailData(_ newsDetail: NewsDetail?, error: Error?) {
        if let getError = error {
            print(getError)
        } else {
            if let detail = newsDetail {
                if let cssArray = detail.css {
                    if cssArray.count > 0 {
                        let cssStr = cssArray[0]
                        let htmlStr = "<html><head><link rel='stylesheet' href='\(cssStr)'></head><body>\(detail.body)</body></html>"
                        detailWebView.loadHTMLString(htmlStr, baseURL: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: { 
                            self.changeWebView?.loadHTMLString(htmlStr, baseURL: nil)
                        })
                    }
                }
                newsId = detail.newsId
                refreshModel = DetailRefreshModel(newsId: newsId, newsIdArray: idArray)
                footerRefreshView?.refreshModel = refreshModel
                headerRefreshView?.refreshModel = refreshModel
                changeNextButtonState()
                topView.detailModel = detail
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    self.changeTopView?.detailModel = detail
                })
            }
        }
    }
    
    func getExtraData(_ extraModel: NewsExtra?, error: Error?) {
        if let getError = error {
            print(getError)
        } else {
            if let extra = extraModel {
                if let comment = extra.comments {
                    commentLabel.text = "\(comment)"
                }
                if let vote = extra.popularity {
                    voteCountLabel.text = "\(vote)"
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -64 {
            detailWebView.scrollView.contentOffset = CGPoint(x: 0, y: -64)
        }
        if offsetY < 0 && offsetY > -64 {
            topView.frame = CGRect(x: 0, y: offsetY, width: ScreenWidth, height: 220 + -offsetY)
        }
        if offsetY > 200 {
            statusView?.backgroundColor = .white
            UIApplication.shared.setStatusBarStyle(.default, animated: true)
        } else {
            statusView?.backgroundColor = .clear
            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        }
        
        if offsetY < -50 {
            UIView.animate(withDuration: 0.2, animations: {
                self.headerRefreshView?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            })
        } else if offsetY < 0 && offsetY > -50 {
            UIView.animate(withDuration: 0.2, animations: {
                self.headerRefreshView?.arrowImageView.transform = .identity
            })
        }
        
        let yPosition = scrollView.contentSize.height - scrollView.frame.size.height - 43 + 60
        if offsetY > yPosition + 50 {
            UIView.animate(withDuration: 0.2, animations: { 
                self.footerRefreshView?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: { 
                self.footerRefreshView?.arrowImageView.transform = .identity
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        if offSetY < -50 {
            loadLastNews()
        }
        
        let yPosition = scrollView.contentSize.height - scrollView.frame.size.height - 43 + 60
        if offSetY > yPosition + 50 {
            loadNextNews()
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        headerRefreshView?.isHidden = false
        footerRefreshView?.isHidden = false
        footerRefreshView?.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: ScreenWidth, height: 60)
    }
}
