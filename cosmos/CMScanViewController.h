//
//  CMScanViewController.h
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import "CMBaseViewController.h"

@class CMScanViewController;

@protocol CMScanViewControllerDelegate <NSObject>

@optional

- (void)scanViewControllerDidCancel:(CMScanViewController *)scanViewController;

- (BOOL)scanViewController:(CMScanViewController *)scanViewController
 didFinishedWithQRCodeText:(NSString *)codeText
                     error:(NSString **)error;

@end

@interface CMScanViewController : CMBaseViewController

@property (nonatomic, weak) id<CMScanViewControllerDelegate> delegate;

- (void)startCameraRunning;
- (void)stopCameraRunning;

@end
