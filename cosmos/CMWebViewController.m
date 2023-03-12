//
//  CMWebViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMWebViewController.h"
#import <CXShareSDK/CXShareSDK.h>
#import <CXAssetsPicker/CXAssetsPicker.h>
#import <CXNetSDK/CXNetSDK.h>
#import "CMSchemeHandler.h"
#import "CMScanPickerController.h"
#import "CMURLRequestParams.h"

@interface CMWebViewController () {
    
}

@end

@implementation CMWebViewController

- (void)registerBridgeHandlers {
    [super registerBridgeHandlers];
    
    @weakify(self);
    [self registerHandler:@"handleScheme" handler:^(NSDictionary<NSString *, id> *data, CXWebViewBridgeCallback callback) {
        @strongify(self);
        NSString *url = [data cx_stringForKey:@"scheme"];
        NSDictionary<NSString *, id> *params = [data cx_dictionaryForKey:@"params"];
        [self handleOpenURLString:url params:params];
        callback(nil);
    }];
    
    [self registerHandler:@"imagePicker" handler:^(NSDictionary<NSString *, id> *data, CXWebViewBridgeCallback callback) {
        @strongify(self);
        CXWebViewImagePickerParams *params = [[CXWebViewImagePickerParams alloc] initWithDictionary:data];
        [CXWebViewImagePickerController showFromViewController:self
                                                        params:params
                                                    completion:^(CXPickerController *picker, UIImage *image, NSString *base64, CXPickerFinishState state, UIImagePickerControllerSourceType sourceType) {
            callback(@{@"image" : base64 ?: @"", @"code" : @(state)});
        }];
    }];
    
    [self registerHandler:@"getParamsSignature" handler:^(NSDictionary<NSString *, id> *data, CXWebViewBridgeCallback callback) {
        @strongify(self);
        callback([self signatureParams:data]);
    }];
    
    [self registerHandler:@"scanCode" handler:^(NSDictionary<NSString *, id> *data, CXWebViewBridgeCallback callback) {
        @strongify(self);
        [CMScanPickerController showFromViewController:self completion:^(CXPickerController *picker, CXPickerFinishState state, NSString *codeText) {
            callback(@{@"code" : codeText ?: @""});
        }];
    }];
}

- (void)handleShareWithData:(NSDictionary<NSString *, id> *)data callback:(CXWebViewBridgeCallback)callback{
    [[CXShareSDKManager sharedManager] shareWithDictionary:data
                                                  inWindow:self.view.window
                                                   tracker:^(CXSharePanelModel *dataModel) {
        if(dataModel.actionType == CXSharePanelActionRefresh){
            [self reload];
        }
        
        CXShareTrackerData *trackerData = dataModel.shareDataModel.trackerData;
        CXDataRecordX(trackerData.id, trackerData.params);
    } callback:^(CXShareChannel shareChannel, CXShareState state) {
        if(callback){
            callback(@{@"channel": shareChannel, @"code" : @(state)});
        }
    }];
}

- (void)handleOpenURLString:(NSString *)url params:(NSDictionary<NSString *,id> *)params{
    [CMSchemeHandler handleOpenURLString:url params:params];
}

- (NSURL *)URLWithURLString:(NSString *)url params:(NSDictionary<NSString *, id> *)params{
    params = [self signatureParams:params];
    return [super URLWithURLString:url params:params];
}

- (NSDictionary<NSString *, id> *)signatureParams:(NSDictionary<NSString *, id> *)params{
    NSMutableDictionary<NSString *, id> *allParams = [NSMutableDictionary dictionary];
    if(params){
        [allParams addEntriesFromDictionary:params];
    }
    
    NSDictionary<NSString *,id> *commonParams = [self commonParams];
    if(commonParams){
        [allParams addEntriesFromDictionary:commonParams];
    }
    
    // 没有参数，就不签名
    if(allParams.count > 0){
        NSString *sign = [CXSignUtils signWithDictionary:allParams
                                             ignoreKeys:@[[CMURLRequestParams signParamKey]]
                                             privateKey:[CMURLRequestParams signPrivateKey]];
        [allParams cx_setValue:sign forKey:[CMURLRequestParams signParamKey]];
    }
    
    return [allParams copy];
}

- (NSDictionary<NSString *,id> *)commonParams{
    return [CMURLRequestParams commonParams];
}

+ (void)registerSchemeSupporter {
    [[CXSchemeRegistrar sharedRegistrar] registerClass:self
                                          businessPage:CXSchemeBusinessWebPage
                                                module:CXSchemeBusinessModuleApplication];
}

@end
