//
//  ContactDetailController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactDetailController.h"
#import "ImageTabView.h"

#define IMAGES_COUNT        4
#define BOTTOM_PADDING      30

@interface ContactDetailController () <ImageTabViewDelegate>

@property (retain, nonatomic) ContactInfo *contactInfo;
@property (retain, nonatomic) ImageTabView *imageTabView;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setImageTabView:nil];
}

- (void)dealloc
{
    [_contactInfo release];
    [_imageTabView release];
    [super dealloc];
}

#pragma mark - Methods

- (void)setupView
{
    self.navigationItem.rightBarButtonItem = [self createBarButtonWithTitle:@"Готово"
                                                                   delegate:self
                                                                   selector:@selector(onRightBarButton:)];

    NSMutableArray *imagesArray = [NSMutableArray array];
    for(int i = 0; i< IMAGES_COUNT; i++)
        [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"icon%d", i+1]]];
    
    self.imageTabView = [[[ImageTabView alloc] initWithImagesArray:imagesArray activeTabIndex:1] autorelease];
    
    self.imageTabView.delegate = self;
    [scrollView addSubview:self.imageTabView];
}

- (void)updateView
{
    UITextField *lastTextField = textFields[textFields.count - 1];
    
    self.imageTabView.origin = CGPointMake(scrollView.width / 2 - self.imageTabView.width / 2, lastTextField.y + lastTextField.height + 40);
    
    scrollView.contentSize = CGSizeMake(scrollView.width, self.imageTabView.y + self.imageTabView.height + BOTTOM_PADDING);
}

#pragma mark - ImageTabView delegate

- (void)chooseImage:(NSInteger)imageIndex
{
    NSLog(@"%d", imageIndex);
}

#pragma mark - Actions

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

- (void)onRightBarButton:(id)sender
{

}

#pragma mark - Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [UIView animateWithDuration:0.1 animations:^
    {
        [self updateView];
    }];
}

@end
