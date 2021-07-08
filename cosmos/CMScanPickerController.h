//
//  CMScanPickerController.h
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import <CXUIKit/CXUIKit.h>

@class CMScanPickerController;

typedef void(^CMScanPickerCompletionBlock)(CXPickerController *picker,
                                           CXPickerFinishState state,
                                           NSString *codeText);

@interface CMScanPickerController : CXPickerController

+ (instancetype)showFromViewController:(UIViewController *)viewController
                            completion:(CMScanPickerCompletionBlock)completion;

@end
