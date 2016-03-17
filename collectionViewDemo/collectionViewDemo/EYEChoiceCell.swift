//
//  EYEChoiceCell.swift
//  EyepetizerApp
//
//  Created by 梁亦明 on 16/3/14.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit


class EYEChoiceCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame : frame)
     
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(coverButton)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        
        backgroundImageView.snp_makeConstraints { [unowned self](make) -> Void in
            make.leading.trailing.top.bottom.equalTo(self.contentView)
        }
        coverButton.snp_makeConstraints { [unowned self](make) -> Void in
            make.leading.trailing.top.bottom.equalTo(self.contentView)
        }
        titleLabel.snp_makeConstraints { [unowned self](make) -> Void in
            make.leading.trailing.equalTo(self.contentView)
            make.height.equalTo(20)
            make.centerY.equalTo(self.contentView.center).offset(-10)
        }
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.contentView)
            make.height.equalTo(20)
            make.centerY.equalTo(self.contentView.center).offset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundImageView.image = nil
    }
    
    /// 传入模型设置数据
    var model : Model.IssueModel.ItemModel! {
        didSet {
            if let feed = model.feed {
                self.backgroundImageView.kf_setImageWithURL(NSURL(string: feed)!)
            }
            
            if let title = model.title {
                self.titleLabel.text = title
            }

            if let subTitle = model.subTitle {
                self.subTitleLabel.text = subTitle
            }
        
        }
    }
    
    /// 背景图
    private lazy var backgroundImageView : UIImageView = {
        var background : UIImageView = UIImageView()
        background.image = UIImage(named: "7e42a62065ef37cfa233009fb364fd1e_0_0")
        return background
    }()
    
    /// 黑色图层
    private lazy var coverButton : UIButton = {
        var coverButton : UIButton = UIButton()
        coverButton.backgroundColor = UIColor.blackColor()
        coverButton.alpha = 0.3
        return coverButton
    }()
    
    /// 标题
    private lazy var titleLabel : UILabel = {
        var titleLabel : UILabel = UILabel()
        titleLabel.textAlignment = .Center
        titleLabel.text = "标题"
        titleLabel.textColor = UIColor.whiteColor()
        return titleLabel
    }()
    
    /// 副标题
    private lazy var subTitleLabel : UILabel = {
        var subTitleLabel : UILabel = UILabel()
        subTitleLabel.textAlignment = .Center
        subTitleLabel.text = "副标题"
        subTitleLabel.textColor = UIColor.whiteColor()
        return subTitleLabel
    }()
    
}
