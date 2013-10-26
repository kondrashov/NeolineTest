//
//  ContactDetailController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactDetailController.h"


@interface ContactDetailController ()

@property (retain, nonatomic) ContactInfo *contactInfo;

@end

@implementation ContactDetailController

#pragma mark - Lifecycle

- (id)initWithContactInfo:(ContactInfo *)contactInfo
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        if(contactInfo)
        {
            self.title = @"Изменить";
            self.contactInfo = contactInfo;
            self.detailMode = DetailMode_Edit;
        }
        else
        {
            self.title = @"Новый";
            self.detailMode = DetailMode_Add;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)dealloc
{
    [_contactInfo release];
    [super dealloc];
}

#pragma mark - Methods

- (void)setupView
{
    self.navigationItem.rightBarButtonItem = [self createBarButtonWithTitle:@"Готово"
                                                                   delegate:self
                                                                   selector:@selector(onRightBarButton:)];
}

- (void)onLeftBarButton:(id)sender
{
    if(self.detailMode == DetailMode_Add)
       [self.navigationController popViewControllerAnimated:YES];
    else
    {
        [UIView animateWithDuration:FLIP_ANIM_DURATION animations:^
        {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
         }];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

@end
