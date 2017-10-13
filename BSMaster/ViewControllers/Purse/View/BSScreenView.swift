//
//  BSScreenView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSScreenView: ETPopupView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var htightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        animationDuration = 0.3
        type = .sheet
        self.snp.makeConstraints { (make) in
            make.width.equalTo(MGScreenWidth)
        }
        ETPopupWindow.sharedWindow().touchWildToHide = true
        connfigCollectionView()
    }
    func connfigCollectionView()  {
        
//        self.contentView.layoutIfNeeded()
        collectionView.cellId_register("BSScreenCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        htightConstraint.constant = 6/2 * 50
        self.layoutIfNeeded()
        collectionView.reloadData()
        
    }
}
extension BSScreenView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BSScreenCollectionViewCell", for: indexPath) as! BSScreenCollectionViewCell
        if indexPath.row != 0 {
            cell.lbTitle.backgroundColor = UIColor.white
            cell.lbTitle.textColor = UIColor.red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (MGScreenWidth - 60 - 16)/3,height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    
}
