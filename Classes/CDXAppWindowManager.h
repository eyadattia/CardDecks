//
//
// CDXAppWindowManager.h
//
//
// Copyright (c) 2009-2014 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CDXAppWindowProtocols.h"
#import "CDXAppWindowNoticeView.h"


@interface CDXAppWindowManager : NSObject {
    
@protected
    IBOutlet UIWindow *window;
    IBOutlet UIView *navigationView;
    
    IBOutlet CDXAppWindowNoticeView *noticeView;
    
    UIViewController<CDXAppWindowViewController> *fullScreenViewController;
    UIViewController *navigationViewController;
    
    UIDeviceOrientation deviceOrientation;
}

declare_singleton(sharedAppWindowManager, CDXAppWindowManager);

@property (nonatomic, readonly) UIWindow *window;
@property (nonatomic, readonly) UIDeviceOrientation deviceOrientation;

- (UIViewController *)visibleViewController;
- (void)pushViewController:(UIViewController<CDXAppWindowViewController> *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToInitialViewController;
- (void)makeWindowKeyAndVisible;
- (void)showNoticeWithImageNamed:(NSString *)name text:(NSString *)text timeInterval:(NSTimeInterval)timeInterval orientation:(UIDeviceOrientation)orientation view:(UIView*)viewOrNil;
- (void)presentModalViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentModalViewController:(UIViewController *)viewController fromBarButtonItem:(UIBarButtonItem*)barButtonItem animated:(BOOL)animated;
- (void)dismissModalViewControllerAnimated:(BOOL)animated;
- (void)showActionSheet:(UIActionSheet*)actionSheet fromBarButtonItem:(UIBarButtonItem*)barButtonItem;
- (void)applicationWillEnterForeground;
- (void)applicationDidEnterBackground;

+ (CGAffineTransform)transformForDeviceOrientation:(UIDeviceOrientation)deviceOrientation;

@end


@interface CDXAppWindowActionSheetNonFirstResponder : UIActionSheet {
    
}


@end


