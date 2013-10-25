//
//  BaseNavigationController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"
#import <QuartzCore/QuartzCore.h>

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
}

@end
