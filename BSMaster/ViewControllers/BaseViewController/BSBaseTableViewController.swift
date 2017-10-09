//
//  BSBaseTableViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBaseTableViewController: UITableViewController,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource{
    
    var pageIndex = 1 //翻页
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,Any>>()
    var dataArr =  Variable<[SectionModel<String,Any>]>([])
    
    var estimatedRowHeight:CGFloat?     // 预加载高度 为nil 时默认 44
    
    var isCurrentRequest : Bool = false // 记录当前页面是否网络请求过，区别是第一次进网络请求，还是下拉刷新进入网络请求
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomerBack()
        setUI()
        
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
////
//        } else {
//            
//            self.automaticallyAdjustsScrollViewInsets = false
//
//        }
      
    }
    
    func setCustomerBack() {
        if let count = navigationController?.viewControllers.count {
            if count > 1 {
                let item = UIBarButtonItem(image:UIImage(named: "nav_backArrow"), style:.plain, target: self, action:#selector(navBack))
                navigationItem.leftBarButtonItem = item
            }
        }
    }
    
    func navBack() {
        _ = navigationController?.popViewController(animated: true)
    }
    func setUI(){
        self.view.backgroundColor = UIColor.white
        self.tableView.backgroundColor      = tableColor
        self.tableView.tableFooterView      = UIView(frame:CGRect.zero)
        self.tableView.tableHeaderView      = UIView(frame:CGRect.zero)
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource   = self
        tableView.estimatedRowHeight        = estimatedRowHeight ?? 44
        tableView.rowHeight                 = UITableViewAutomaticDimension
        self.tableView.separatorColor       = SeprateColor
        self.tableView.mj_header            = mj_header
        self.tableView.sectionFooterHeight  = 0.01
        self.tableView.sectionHeaderHeight  = 0.01
//        self.edgesForExtendedLayout         = UIRectEdge()
//        self.tableView.keyboardDismissMode  = .onDrag
        
    }
    //MARK:网络请求 isLoding --- 是否弹出loading框
    func request(){
        if !isCurrentRequest {
            BSHud.showLoading()
            isCurrentRequest = true
        }
        BSDelay.start(delay: 2, closure: { // 模拟网络请求
            BSHud.dismiss()
            self.endRefresh()
        })
    }
    //MARK: MJHeader
    lazy var mj_header:MJRefreshNormalHeader = {
    
        let h = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
        h?.lastUpdatedTimeLabel.isHidden = true
        h?.stateLabel.isHidden = true

        return h!
    }()
    //MARK: MJFooter
    lazy var mj_footer:MJRefreshAutoNormalFooter = {
        let f = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction:#selector(loadMore))!
        return f
    }()
   //MARK: 上拉加载， 自动加1
    func loadMore() {
        pageIndex += 1
        request()
    }
   //MARK: 下拉刷新， 从第一页开始
    func pullToRefresh() {
        pageIndex = 1
        request()
    }
   //MARK: 结束刷新 ，停止动作
    func endRefresh() {
        mj_header.endRefreshing()
        mj_footer.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    deinit {
        
        BSLog("Title: == \(String(describing: self.title)) VC: == \(self.identifier())  --- 销毁")
        
    }
}


// 空白展位图
extension BSBaseTableViewController{
    @objc(titleForEmptyDataSet:) func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无数据"
        let attri = NSAttributedString(string: text, attributes:[NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 17)])
        return attri
    }
    
    @objc(backgroundColorForEmptyDataSet:) func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return tableColor
    }

}
