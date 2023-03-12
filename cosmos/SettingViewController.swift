//
//  SettingViewController.swift
//  cosmos
//
//  Created by wshaolin on 2023/3/3.
//

import Foundation

class SettingViewController : CXSettingViewController, CXSchemeSupporter {
    required init(params: [String : Any]?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadData(completion: CXSettingViewControllerDataBlock!) {
        /*
         * 第一组
         */
        let header1 = CXSettingHeaderFooterModel(height: 10.0)
        let rowModel_11 = CXSettingRowModel(title: "应急联系人") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        
        let rowModel_12 = CXSettingRightSwitchRowModel(title: "新消息通知") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        
        rowModel_12?.confirmBlock = { (switchModel: CXSettingRightSwitchRowModel?, on: Bool?, context: Any?, completion: CXSettingSwitchConfirmResultBlock?) in
            if(on!){
                completion!(true)
            }else{
                let viewController = context as! SettingViewController
                CXActionSheetUtils.showActionSheet { (config: CXActionSheetControllerConfigModel?) in
                    config!.title = "关闭后，手机将不再接收新消息通知";
                    config!.buttonTitles = ["确认关闭"];
                    config!.viewController = viewController;
                    config!.destructiveIndex = 0;
                } completion: { (index : Int) in
                    completion!(index == 0)
                } cancel: {
                    completion!(false)
                }
            }
        }
        
        let footer1: CXSettingHeaderFooterModel? = nil
        let sectionModel_1 = CXSettingSectionModel(rows: [rowModel_11!, rowModel_12!], header: header1, footer: footer1)
    
        
        /*
         * 第二组
         */
        let header2: CXSettingHeaderFooterModel? = nil
        let rowModel_21 = CXSettingRightTextRowModel(title: "深色模式") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        rowModel_21!.rightText = "跟随系统"
        let rowModel_22 = CXSettingRightBadgeRowModel(title: "新消息") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        
        rowModel_22!.badgeValue = "8"
        let footer2: CXSettingHeaderFooterModel? = nil
        let sectionModel_2 = CXSettingSectionModel(rows: [rowModel_21!, rowModel_22!], header: header2, footer: footer2)
        
        /*
         * 第三组
         */
        let header3 = CXSettingHeaderFooterModel(text: "可通过以下方式找到我", edgeInsets: UIEdgeInsets(top: 15.0, left: 15.0, bottom: 7.0, right: 15.0))
        let rowModel_31 = CXSettingRightSwitchRowModel(title: "手机号") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        let rowModel_32 = CXSettingRightSwitchRowModel(title: "微信号") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        
        let footer3 = CXSettingHeaderFooterModel(text: "关闭后，其他用户将不能通过上述信息找到你。", edgeInsets: UIEdgeInsets(top: 7.0, left: 15.0, bottom: 25.0, right: 15.0))
        let sectionModel_3 = CXSettingSectionModel(rows: [rowModel_31!, rowModel_32!], header: header3, footer: footer3)
        
        
        /*
         * 第四组
         */
        let header4: CXSettingHeaderFooterModel? = nil
        let rowModel_41 = CXSettingRowModel(title: "添加我的方式") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        let rowModel_42 = CXSettingRightSwitchRowModel(title: "向我推荐通讯录好友") { (itemNode: CXActionToolBarItemNode?, context: Any?) in
            
        }
        
        let footer4 = CXSettingHeaderFooterModel(text: "开启后，为你推荐已经开通账号的手机联系人。")
        let sectionModel_4 = CXSettingSectionModel(rows: [rowModel_41!, rowModel_42!], header: header4, footer: footer4)
        
        /*
         * 回调数据
         */
        completion([sectionModel_1!, sectionModel_2!, sectionModel_3!, sectionModel_4!]);
    }
    
    static func register() {
        CXSchemeRegistrar.shared().register(Self.self, businessPage: CMSchemeBusinessSettingPage, module: CMSchemeBusinessModuleCosmos)
    }
}
