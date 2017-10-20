//
//  BSMyViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//
import UIKit
struct BSMeIcon {
    let icon : String
    let title : String
}
class BSMyViewController: BSBaseTableViewController {
    
    let v = BSMyHeaderView.loadFromNib()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        setUI()
        configTable()
        v.imgPhoto.addTapGesture {[unowned self] (sender) in
            self.showPicture()
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func configTable(){

        tableView.cellId_register("BSMyTableViewCell")
        tableView.cellId_register("BAMySetTableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = BSCellLineColor
        
        self.navigationController?.navigationBar.shadowImage = UIImage.getImageWithColor(color: BSNavColor)
        
        makeCustomerImageNavigationItem("me_setting", left: false) {
            VCRouter.toSettingVC()
            
//            let view = BSShareView.loadFromNib()
//            view.show()
        }
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
//            guard let `self` = self else { return  UITableViewCell() }
            
//            if indexPath.section == 0 && indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyTableViewCell", for: indexPath) as! BSMyTableViewCell
//                return cell
//            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BAMySetTableViewCell", for: indexPath) as! BAMySetTableViewCell
                cell.iconModel = element as! BSMeIcon
               
                return cell
//            }
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in

            let row         = indexpath.element?.row
            let section     = indexpath.element?.section
            
            switch section ?? 0 {
                case 0:
                    switch row ?? 0{
                    case 0:   VCRouter.toADVC(.Adverted)
                    default:
                        break
                }
                case 1:
                    switch row ?? 0{
                    case 0: VCRouter.toSuggestVC()
                    case 1: VCRouter.toAboutMeVC()
                    case 2: VCRouter.toCenterVC()
                    case 3: self.exitLogin()
                    default:
                        break
                }
                case 2:
                    switch row ?? 0{
                    case 0: VCRouter.toSettingVC()

                    default:
                        break
                }
                default:break
                
            }

            }.addDisposableTo(rx_disposeBag)
        
        
        dataArr.value.append(SectionModel.init(model: "one",
                                               items: [
                                                                     BSMeIcon.init(icon: "me_ad", title: "我的广告"),
                                                                     BSMeIcon.init(icon: "me_friend", title: "邀请好友")]))
        
        dataArr.value.append(SectionModel.init(model: "two", items: [BSMeIcon.init(icon: "me_suggest", title: "建议反馈"),
                                                                     BSMeIcon.init(icon: "me_about", title: "关于我们"),
                                                                     BSMeIcon.init(icon: "me_center", title: "客服中心"),
                                                                     BSMeIcon.init(icon: "me_out", title: "退出登录")]))
    
        
    }

    //MARK: 退出登录
    func exitLogin() {
        let alertController: UIAlertController = UIAlertController(title: "退出登录", message: "你确定要退出登录吗", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style:.cancel, handler: nil)
        alertController.addAction(cancelAction)
        let sureAction: UIAlertAction = UIAlertAction(title: "确定", style: .default) { action -> Void in
            print("退出登录")
        }
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK:Lazy
    lazy var imagePicker:UIImagePickerController = {
        let v = UIImagePickerController()
        v.delegate = self
        return v
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension BSMyViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
         
            v.frame = CGRect.init(x: 0, y: 0, w: MGScreenWidth, h: 110)
            return v
        }else {
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
             return 160
        }else{
            return 0.01
        }
    }
 
    
}
extension BSMyViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //选取相册
    fileprivate func showPicture(){
        let actionSheetController: UIAlertController = UIAlertController(title: "更改头像", message: nil, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
        let takePictureAction: UIAlertAction = UIAlertAction(title: "相机拍照", style: .default) { action -> Void in
            self.choosePhtot(.camera)
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册选取", style: .default) { action -> Void in
            self.choosePhtot(.photoLibrary)
        }
        actionSheetController.addAction(choosePictureAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func choosePhtot(_ type:UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(type){
            //指定图片控制器类型
            imagePicker.sourceType = type
            //弹出控制器，显示界面
            self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(imagePicker, animated: true, completion:nil)
        }else{
//            DLog("读取相册错误")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: nil)
        
        v.imgPhoto.image = image
    
        
    }
    
    
}
