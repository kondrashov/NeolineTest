//
//  ContactDetailController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactDetailController.h"
#import "ImageTabView.h"
#import "ContactEntity.h"

#define IMAGES_COUNT        4
#define BOTTOM_PADDING      30

#define FIRST_NAME          0
#define LAST_NAME           1
#define FATHER_NAME         2
#define PHONE_NUMBER        3

#define DEFAULT_ICON        0


@interface ContactDetailController () <ImageTabViewDelegate>

@property (retain, nonatomic) ContactEntity *contactInfo;
@property (retain, nonatomic) ImageTabView *imageTabView;
@property (retain, nonatomic) IBOutlet UILabel *lblIcon;

@end

@implementation ContactDetailController

#pragma mark - Lifecycle

- (id)initWithContactInfo:(ContactEntity *)contactInfo
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - Methods

- (void)createObservers
{
    [super createObservers];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveData)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveData)
                                                 name:UIApplicationWillTerminateNotification
                                               object:app];
}

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
        [textFields[PHONE_NUMBER] setText:self.contactInfo.phone];
        [self.imageTabView setActiveImage:self.contactInfo.iconId.integerValue];
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

- (void)saveData
{
    NSString *firstName = [textFields[FIRST_NAME] text];
    NSString *lastName = [textFields[LAST_NAME] text];
    NSString *fatherName = [textFields[FATHER_NAME] text];
    NSString *phone = [textFields[PHONE_NUMBER] text];
    NSData *dataImage = UIImagePNGRepresentation([self.imageTabView getActiveImage]);
    NSNumber *iconId = [NSNumber numberWithInt:[self.imageTabView getActiveIndex]];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:CONTACT_ENTITY inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if(!objects)
        NSLog(@"%@", error);
    
    NSInteger contactId;
    NSManagedObject *contact;

    if(self.detailMode == DetailMode_Add)
    {
        contact = [NSEntityDescription insertNewObjectForEntityForName:CONTACT_ENTITY inManagedObjectContext:context];
        
        if(objects.count)
            contactId = objects.count + 1;
        else
            contactId = 1;
    }
    else
    {
        contact = self.contactInfo;
        contactId = self.contactInfo.contactId.integerValue;
    }
    
    [contact setValue:[NSNumber numberWithInt:contactId] forKey:@"contactId"];
    [contact setValue:firstName forKey:@"firstName"];
    [contact setValue:lastName forKey:@"lastName"];
    [contact setValue:fatherName forKey:@"fatherName"];
    [contact setValue:phone forKey:@"phone"];
    [contact setValue:dataImage forKey:@"icon"];
    [contact setValue:iconId forKey:@"iconId"];
    
    [context save:&error];
}

#pragma mark - ImageTabView delegate

- (void)chooseImage:(NSInteger)imageIndex
{

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
    [self saveData];
    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadDataNotification object:nil];
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
