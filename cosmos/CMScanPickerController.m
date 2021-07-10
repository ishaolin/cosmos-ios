//
//  CMScanPickerController.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import "CMScanPickerController.h"
#import "CMScanViewController.h"

@interface CMScanPickerController()<CMScanViewControllerDelegate> {
    
}

@property (nonatomic, copy) CMScanPickerCompletionBlock completionBlock;

@end

@implementation CMScanPickerController

+ (instancetype)showFromViewController:(UIViewController *)viewController
                            completion:(CMScanPickerCompletionBlock)completion{
    CMScanPickerController *pickerController = [[self alloc] initWithFromViewController:viewController];
    pickerController.completionBlock = completion;
    [pickerController invoke];
    return pickerController;
}

- (void)invoke{
    [super invoke];
    
    CMScanViewController *scanViewController = [[CMScanViewController alloc] init];
    scanViewController.delegate = self;
    [self setContentController:scanViewController];
}

- (void)scanViewControllerDidCancel:(CMScanViewController *)scanViewController{
    self.completionBlock(self, CXPickerFinishStateCancelled, nil);
    [self finish];
}

- (BOOL)scanViewController:(CMScanViewController *)scanViewController didFinishedWithQRCodeText:(NSString *)codeText error:(NSString **)error{
    [scanViewController dismissAnimated:YES completion:nil];
    
    self.completionBlock(self, CXPickerFinishStateSucceed, codeText);
    [self finish];
    return YES;
}

@end
