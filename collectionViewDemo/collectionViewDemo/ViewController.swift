//
//  ViewController.swift
//  collectionViewDemo
//
//  Created by 梁亦明 on 16/3/17.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Alamofire

let SCREEN_WIDTH : CGFloat = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT : CGFloat = UIScreen.mainScreen().bounds.height
let UI_NAV_HEIGHT : CGFloat = 64
class ViewController: UIViewController {

   
    //MARK: --------------------------- LifeCycle --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        
        getTodayData()
    }
    
    //MARK: --------------------------- Network --------------------------
    private func getTodayData() {
        let api = "http://baobab.wandoujia.com/api/v2/feed?date=1458120409379&num=7"
        Alamofire.request(.GET, api).responseSwiftyJSON ({[unowned self](request, Response, json, error) -> Void in
            
            if json != .null && error == nil{
                self.model = Model(dict: json.rawValue as! NSDictionary)
                self.collectionView.reloadData()
            }
            })
    }
    
    //MARK: --------------------------- Getter or Setter --------------------------
    /// 模型数据
    var model : Model?
    
    /// tableView
    private lazy var collectionView : UICollectionView = {
        /// 布局
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: 235)
        layout.sectionInset = UIEdgeInsetsZero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        var collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:layout)
        // 注册cell
        collectionView.registerClass(EYEChoiceCell.self, forCellWithReuseIdentifier: EYEChoiceCell.reuseIdentifier)
        // 注册header
        collectionView.registerClass(EYEChoiceHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EYEChoiceHeaderView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}


//MARK: --------------------------- UICollectionViewDelegate, UICollectionViewDataSource --------------------------
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let _ = model {
            return (model?.issueList.count)!
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let issueList : [Model.IssueModel] = (model?.issueList)!
        let issueModel : Model.IssueModel = issueList[section]
        let itemList = issueModel.itemList
        return itemList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let issueModel = model?.issueList[indexPath.section]
        
        let cell : EYEChoiceCell = collectionView.dequeueReusableCellWithReuseIdentifier(EYEChoiceCell.reuseIdentifier, forIndexPath: indexPath) as! EYEChoiceCell
        cell.model = issueModel?.itemList[indexPath.row]
        return cell
    }
    
    /**
     *  section HeaderView
     */
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        //        if kind == UICollectionElementKindSectionHeader {
        let headerView : EYEChoiceHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: EYEChoiceHeaderView.reuseIdentifier, forIndexPath: indexPath) as! EYEChoiceHeaderView
        let issueModel = model?.issueList[indexPath.section]
        if let image = issueModel?.headerImage {
            headerView.image = image
            print ("image:\(image)")
        } else {
            headerView.title = issueModel?.headerTitle
            print ("title:\(issueModel?.headerTitle)")
        }
        return headerView
        //        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // 获取cell的类型
        let issueModel = model?.issueList[section]
        if issueModel!.isHaveSectionView {
            return CGSize(width: SCREEN_WIDTH, height: 50)
        } else {
            return CGSizeZero
        }
    }
}

