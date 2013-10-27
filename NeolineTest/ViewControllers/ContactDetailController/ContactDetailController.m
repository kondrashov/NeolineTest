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

#define FIRST_NAME      0
#define LAST_NAME       1
#define FATHER_NAME     2
#define PHONE_NUMBER    3

#define DEFAULT_ICON    0


@interface ContactDetailController () <ImageTabViewDelegate>

@property (retain, nonatomic) ContactInfo *contactInfo;
@property (retain, nonatomic) ImageTabView *imageTabView;
@property (retain, nonatomic) IBOutlet UILabel *lblIcon;

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
    [self loadData];
}

- (void)viewDidUnload
{
    [self setLblIcon:nil];
    [super viewDidUnload];
    [self setImageTabView:nil];
}

- (void)dealloc
{
    [_contactInfo release];
    [_imageTabView release];
    [_lblIcon release];
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

- (void)loadData
{
    if(self.contactInfo)
    {
        [textFields[FIRST_NAME] setText:self.contactInfo.firstName];
        [textFields[LAST_NAME] setText:self.contactInfo.lastName];
        [textFields[FATHER_NAME] setText:self.contactInfo.fatherName];
        [textFields[PHONE_NUMBER] setText:self.contactInfo.phoneNumber];
        [self.imageTabView setActiveImage:self.contactInfo.iconId - 1];
    }
    else
        [self.imageTabView setActiveImage:DEFAULT_ICON];
}

- (void)updateView
{
    self.imageTabView.origin = CGPointMake(scrollView.width / 2 - self.imageTabView.width / 2, self.lblIcon.y + 30);
    
    scrollView.contentSize = CGSizeMake(scrollView.width, self.imageTabView.y + self.imageTabView.height + BOTTOM_PADDING);
}

- (void)dismissView
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

#pragma mark - ImageTabView delegate

- (void)chooseImage:(NSInteger)imageIndex
{
//    NSLog(@"%d", imageIndex);
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag < 4)
        [textFields[textField.tag] becomeFirstResponder];
    else
        [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Actions

- (void)onLeftBarButton:(id)sender
{
    [self dismissView];
}

- (void)onRightBarButton:(id)sender
{
    [self dismissView];
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
