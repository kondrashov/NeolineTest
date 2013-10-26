//
//  BaseNavigationController.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredButton.h"
#import <QuartzCore/QuartzCore.h>

@interface BaseNavigationController : UIViewController

- (ColoredButton *)createButtonWithTitle:(NSString *)title
                                delegate:(id)delegate
                                selector:(SEL)selector
                             normalColor:(UIColor *)normColor
                          highlightColor:(UIColor *)highlightColor
                                fontSize:(NSInteger)fontSize
                                paddingX:(NSInteger)paddingX
                                paddingY:(NSInteger)paddingY;

- (UIBarButtonItem *)createBarButtonWithTitle:(NSString *)title
                                     delegate:(id)delegate
                                     selector:(SEL)selector;


- (void)onRightBarButton:(id)sender;
- (void)onLeftBarButton:(id)sender;

@end
