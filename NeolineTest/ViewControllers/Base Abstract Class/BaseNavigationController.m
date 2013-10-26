//
//  BaseNavigationController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"
#import <QuartzCore/QuartzCore.h>

#define BUTTON_FONT_SIZE          15
#define BUTTON_TITLE_PADDING_X    10
#define BUTTON_TITLE_PADDING_Y    5

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)configureNavBar
{
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBackgImg"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [self getTitleView];
//    self.navigationItem.rightBarButtonItem = [self createBarButtonWithTitle:@"Готово" delegate:self selector:@selector(onRightBarButton:)];
//    self.navigationItem.leftBarButtonItem = [self createBarButtonWithTitle:@"Назад" delegate:self selector:@selector(onLeftBarButton:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavBar];
}

- (UIView *)getTitleView
{
    UILabel *label = [UILabel new];
    label.text = self.title;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:22];
    [label sizeToFit];
    return [label autorelease];
}

- (UIBarButtonItem *)createBarButtonWithTitle:(NSString *)title delegate:(id)delegate selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize btnTitleSize = [title sizeWithFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
    UIImage *btnImage = [[UIImage imageNamed:@"navBarButtonBackg"] safeResizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)
                                                                                      resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
    [button setFrame:CGRectMake(0, 0, btnTitleSize.width + BUTTON_TITLE_PADDING_X, btnTitleSize.height + BUTTON_TITLE_PADDING_Y)];
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = RGBCOLOR(146, 162, 172).CGColor;
    button.layer.borderWidth = 1;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [barButtonItem autorelease];
}

#pragma mark - Actions

- (void)onRightBarButton:(id)sender
{
    // Override in childs
}

- (void)onLeftBarButton:(id)sender
{
    // Override in childs    
}

@end
