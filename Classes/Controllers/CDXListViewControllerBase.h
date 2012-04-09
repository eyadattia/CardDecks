//
//
// CDXListViewControllerBase.h
//
//
// Copyright (c) 2009-2012 Arne Harren <ah@0xc0.de>
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


typedef enum {
    CDXListViewControllerBasePerformActionStateNone = 0,
    CDXListViewControllerBasePerformActionStateTableView
} CDXListViewControllerBasePerformActionState;


@interface CDXListViewControllerBase : UIViewController<CDXAppWindowViewController> {
    
@protected
    BOOL useReducedGraphicsEffects;

    IBOutlet UITableView *viewTableView;
    IBOutlet UIToolbar *viewToolbar;
    CGFloat viewTableViewContentOffsetY;
    IBOutlet UIBarButtonItem *editButton;
    IBOutlet UIBarButtonItem *settingsButton;
    
    UIActivityIndicatorView *activityIndicator;
    
    UIFont *tableCellTextFont;
    UIFont *tableCellTextFontAction;
    UIColor *tableCellTextTextColor;
    UIColor *tableCellTextTextColorNoCards;
    UIColor *tableCellTextTextColorAction;
    UIColor *tableCellTextTextColorActionInactive;
    UIFont *tableCellDetailTextFont;
    UIColor *tableCellDetailTextTextColor;
    UIImage *tableCellBackgroundImage;
    UIImage *tableCellBackgroundImageAlt;
    CGSize tableCellImageSize;
    
    NSString *titleText;
    NSString *backButtonText;
    
    NSString *reuseIdentifierSection1;
    NSString *reuseIdentifierSection2;
    
    CDXListViewControllerBasePerformActionState performActionState;
    NSIndexPath *performActionTableViewIndexPath;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil titleText:(NSString*)titleText backButtonText:(NSString *)backButtonText;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath marked:(BOOL)marked;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSection:(NSUInteger)section;

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (void)performAction:(SEL)action withSender:(id)sender tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
- (void)updateToolbarButtons;

- (IBAction)editButtonPressed;

- (void)performBlockingSelector:(SEL)selector withObject:(NSObject *)object;
- (void)performBlockingSelectorEnd;

@end

