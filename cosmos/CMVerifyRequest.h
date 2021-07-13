//
//  CMVerifyRequest.h
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMBaseURLRequest.h"

@interface CMVerifyRequest : CMBaseURLRequest

@end

@class CMVerifyDataModel;

@interface CMVerifyModel : CXBaseModel

@property (nonatomic, strong) CMVerifyDataModel *data;

@end

@interface CMVerifyDataModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *authCode;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL appAuthEnabled;
@property (nonatomic, assign) BOOL radioEnabled;
@property (nonatomic, assign) long trialDate;
@property (nonatomic, assign) long lastDate;
@property (nonatomic, copy) NSString *note;

@end
