//
//  ContactDetailController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactDetailController.h"

@interface ContactDetailController ()

@end

@implementation ContactDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Новый";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.navigationItem.rightBarButtonItem = [self createBarButtonWithTitle:@"Готово"
                                                                   delegate:self
                                                                   selector:@selector(onRightBarButton:)];
}

@end
