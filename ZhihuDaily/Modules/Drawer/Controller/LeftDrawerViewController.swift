//
//  LeftDrawerViewController.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/5.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

class LeftDrawerViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var switchImageView: UIImageView!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var leftTableView: UITableView!
    
    var selectIndexPath: IndexPath?
    
    lazy var typeArray: [String] = {
        var array = [String]()
        array.append(contentsOf: ["首页", "电影日报", "体育日报", "日常心理学", "用户推荐日报", "不许无聊", "设计日报", "大公司日报", "财经日报", "互联网安全", "开始游戏", "音乐日报", "动漫日报"])
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    func createSubViews() -> Void {
        
        selectIndexPath = IndexPath(row: 0, section: 0)
        
        leftTableView.dataSource = self
        leftTableView.delegate = self
        leftTableView.separatorStyle = .none
        leftTableView.backgroundColor = UIColor(red: 35 / 255.0, green: 42 / 255.0, blue: 48 / 255.0, alpha: 1.0)
        leftTableView.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "LeftDrawerTableViewCell", bundle: nil)
        leftTableView.register(nib, forCellReuseIdentifier: "drawerCell")
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        footerView.backgroundColor = UIColor(red: 35 / 255.0, green: 42 / 255.0, blue: 48 / 255.0, alpha: 1.0)
        leftTableView.tableFooterView = footerView
        
        leftTableView.reloadData()
    }

    @IBAction func didClickLeftButton(_ sender: UIButton) {
        switch sender.tag {
        case 1001:
            toPersonalPage()
        case 1002:
            toCollectPage()
        case 1003:
            toMessagePage()
        case 1004:
            toSettingPage()
        case 1005:
            cacheStory()
        case 1006:
            switchDayNight()
        default:
            toPersonalPage()
        }
    }
    
    // MARK: - Private Method
    func toPersonalPage() {
        
    }
    
    func toCollectPage() {
        
    }
    
    func toMessagePage() {
        
    }
    
    func toSettingPage() {
        
    }
    
    func cacheStory() {
        
    }
    
    func switchDayNight() {
        
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

extension LeftDrawerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.typeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drawerCell = tableView.dequeueReusableCell(withIdentifier: "drawerCell") as! LeftDrawerTableViewCell
        drawerCell.selectionStyle = .none
        drawerCell.typeLabelLeading.constant = 15
        drawerCell.leftImageView.isHidden = true
        if indexPath.row == 0 {
            drawerCell.typeLabelLeading.constant = 50
            drawerCell.leftImageView.isHidden = false
            drawerCell.rightImageView.image = UIImage(named: "ico_enter")
        } else {
            drawerCell.rightImageView.image = UIImage(named: "ico_follow")
        }
        if let select = selectIndexPath {
            if select.row == indexPath.row {
                drawerCell.contentView.backgroundColor = UIColor(red: 27 / 255.0, green: 35 / 255.0, blue: 41 / 255.0, alpha: 1.0)
                drawerCell.typeLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
                drawerCell.typeLabel.textColor = .white
            } else {
                drawerCell.contentView.backgroundColor = UIColor(red: 35 / 255.0, green: 42 / 255.0, blue: 48 / 255.0, alpha: 1.0)
                drawerCell.typeLabel.font = UIFont.systemFont(ofSize: 14.0)
                drawerCell.typeLabel.textColor = UIColor(red: 124 / 255.0, green: 130 / 255.0, blue: 134 / 255.0, alpha: 1.0)
            }
            if select.row == 0 {
                drawerCell.leftImageView.image = UIImage(named: "ico_homepage_white")
            } else {
                drawerCell.leftImageView.image = UIImage(named: "ico_homepage")
            }
        } else {
            drawerCell.backgroundColor = UIColor(red: 27 / 255.0, green: 35 / 255.0, blue: 41 / 255.0, alpha: 1.0)
            drawerCell.typeLabel.font = UIFont.systemFont(ofSize: 14.0)
            drawerCell.typeLabel.textColor = UIColor(red: 124 / 255.0, green: 130 / 255.0, blue: 134 / 255.0, alpha: 1.0)
        }
        drawerCell.typeLabel.text = typeArray[indexPath.row]
        return drawerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndexPath = indexPath
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
