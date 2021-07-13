//
//  CMScanViewController.h
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import <CXUIKit/CXUIKit.h>

@class CMScanViewController;

@protocol CMScanViewControllerDelegate <NSObject>

@optional

- (void)scanViewControllerDidCancel:(CMScanViewController *)scanViewController;

- (BOOL)scanViewController:(CMScanViewController *)scanViewController
 didFinishedWithQRCodeText:(NSString *)codeText
                     error:(NSString **)error;

@end

@interface CMScanViewController : CXBaseViewController

@property (nonatomic, weak) id<CMScanViewControllerDelegate> delegate;

- (void)startCameraRunning;
- (void)stopCameraRunning;

@end
