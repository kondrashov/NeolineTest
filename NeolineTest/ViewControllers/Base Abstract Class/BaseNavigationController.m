//
//  BaseNavigationController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"

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

- (void)setupView
{
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBackgImg"]
                                                  forBarMetrics:UIBarMetricsDefault];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

@end
