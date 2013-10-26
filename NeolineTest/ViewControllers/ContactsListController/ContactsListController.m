//
//  ContactsListController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactsListController.h"
#import "ContactDetailController.h"

@interface ContactsListController ()

@property (retain, nonatomic) ColoredButton *btnAddContact;

@end

@implementation ContactsListController

#pragma mark - ViewController lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Контакты";
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
    [self.btnAddContact release];
    [super dealloc];
}

#pragma mark - Methods

- (void)setupView
{
    [self createAddButton];
}

- (void)createAddButton
{
    if(!self.btnAddContact)
    {
        self.btnAddContact = [self createButtonWithTitle:@"Добавить"
                                                delegate:self
                                                selector:@selector(onAdd:)
                                             normalColor:RGBCOLOR(0, 127, 37)
                                          highlightColor:RGBCOLOR(0, 255, 0)
                                                fontSize:20
                                                paddingX:20
                                                paddingY:10];
        
        self.btnAddContact.layer.cornerRadius = 7;
        self.btnAddContact.origin = CGPointMake(20, 20);
    }

    if(self.btnAddContact.superview != self.view)
        [self.view addSubview:self.btnAddContact];
}

#pragma mark - Actions

- (void)onAdd:(id)sender
{
    ContactDetailController *contactDetailVC = [[ContactDetailController alloc] init];
    [self.navigationController pushViewController:contactDetailVC animated:YES];
    [contactDetailVC release];
}

@end
