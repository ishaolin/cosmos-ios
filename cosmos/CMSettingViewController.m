//
//  CMSettingViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/9.
//

#import "CMSettingViewController.h"
#import "CMSchemeHandler.h"

@interface CMSettingViewController () {
    
}

@end

@implementation CMSettingViewController

- (void)loadDataWithCompletion:(CXSettingViewControllerDataBlock)completion{
    /*
     * 第一组
     */
    CXSettingHeaderFooterModel *header1 = [[CXSettingHeaderFooterModel alloc] initWithHeight:10.0];
    CXSettingRowModel *rowModel_11 = [[CXSettingRowModel alloc] initWithTitle:@"应急联系人" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    CXSettingRightSwitchRowModel *rowModel_12 = [[CXSettingRightSwitchRowModel alloc] initWithTitle:@"新消息通知" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    rowModel_12.confirmBlock = ^(CXSettingRightSwitchRowModel *switchModel, BOOL on, id context, CXSettingSwitchConfirmResultBlock completion) {
        if(on){
            completion(YES);
        }else{
            // 关闭操作需要用户二次确认
            CMSettingViewController *viewController = (CMSettingViewController *)context;
            [CXActionSheetUtils showActionSheetWithConfigBlock:^(CXActionSheetControllerConfigModel *config) {
                config.title = @"关闭后，手机将不再接收新消息通知";
                config.buttonTitles = @[@"确认关闭"];
                config.viewController = viewController;
                config.destructiveIndex = 0;
            } completion:^(NSInteger buttonIndex) {
                completion(buttonIndex == 0);
            } cancelBlock:^{
                completion(NO);
            }];
        }
    };
    CXSettingHeaderFooterModel *footer1 = nil;
    CXSettingSectionModel *sectionModel_1 = [[CXSettingSectionModel alloc] initWithRows:@[rowModel_11, rowModel_12] header:header1 footer:footer1];
    
    
    /*
     * 第二组
     */
    CXSettingHeaderFooterModel *header2 = nil;
    CXSettingRightTextRowModel *rowModel_21 = [[CXSettingRightTextRowModel alloc] initWithTitle:@"深色模式" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    rowModel_21.rightText = @"跟随系统";
    CXSettingRightBadgeRowModel *rowModel_22 = [[CXSettingRightBadgeRowModel alloc] initWithTitle:@"新消息" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    rowModel_22.badgeValue = @"8";
    CXSettingHeaderFooterModel *footer2 = nil;
    CXSettingSectionModel *sectionModel_2 = [[CXSettingSectionModel alloc] initWithRows:@[rowModel_21, rowModel_22] header:header2 footer:footer2];
    
    
    /*
     * 第三组
     */
    CXSettingHeaderFooterModel *header3 = [[CXSettingHeaderFooterModel alloc] initWithText:@"可通过以下方式找到我：" edgeInsets:UIEdgeInsetsMake(15.0, 15.0, 7.0, 15.0)];
    CXSettingRowModel *rowModel_31 = [[CXSettingRightSwitchRowModel alloc] initWithTitle:@"手机号" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    CXSettingRowModel *rowModel_32 = [[CXSettingRightSwitchRowModel alloc] initWithTitle:@"微信号" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    CXSettingHeaderFooterModel *footer3 = [[CXSettingHeaderFooterModel alloc] initWithText:@"关闭后，其他用户将不能通过上述信息找到你。" edgeInsets:UIEdgeInsetsMake(7.0, 15.0, 25.0, 15.0)];
    CXSettingSectionModel *sectionModel_3 = [[CXSettingSectionModel alloc] initWithRows:@[rowModel_31, rowModel_32] header:header3 footer:footer3];
    
    
    /*
     * 第四组
     */
    CXSettingHeaderFooterModel *header4 = nil;
    CXSettingRowModel *rowModel_41 = [[CXSettingRowModel alloc] initWithTitle:@"添加我的方式" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    CXSettingRowModel *rowModel_42 = [[CXSettingRightSwitchRowModel alloc] initWithTitle:@"向我推荐通讯录好友" actionHandler:^(CXActionToolBarItemNode *itemNode, id context) {
        // 事件处理
    }];
    CXSettingHeaderFooterModel *footer4 = [[CXSettingHeaderFooterModel alloc] initWithText:@"开启后，为你推荐已经开通账号的手机联系人。"];
    CXSettingSectionModel *sectionModel_4 = [[CXSettingSectionModel alloc] initWithRows:@[rowModel_41, rowModel_42] header:header4 footer:footer4];
    
    
    /*
     * 回调数据
     */
    completion(@[sectionModel_1, sectionModel_2, sectionModel_3, sectionModel_4]);
}

+ (void)registerSchemeSupporter {
    [[CXSchemeRegistrar sharedRegistrar] registerClass:self
                                          businessPage:CMSchemeBusinessSettingPage
                                                module:CMSchemeBusinessModuleCosmos];
}

@end
