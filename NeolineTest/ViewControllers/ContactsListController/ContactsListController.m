//
//  ContactsListController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactsListController.h"
#import "ContactDetailController.h"
#import "ContactInfo.h"
#import "ContactListCell.h"

#define CONTACET_LIST_CELL_ID   @"ContactListCell"

@interface ContactsListController ()

@property (retain, nonatomic) ColoredButton *btnAddContact;

@end

@implementation ContactsListController

#pragma mark - Lifecycle

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
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setBtnAddContact:nil];
}

- (void)dealloc
{
    [_btnAddContact release];
    [super dealloc];
}

#pragma mark - Methods

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    NSInteger iconCount = 1;
    for(int i = 0; i < 25; i++)
    {
        ContactInfo *contactInfo = [ContactInfo new];
        contactInfo.contactId = i + 1;
        contactInfo.firstName = @"Артем";
        contactInfo.lastName = @"Кондрашов";
        contactInfo.fatherName = @"Валерьевич";
        contactInfo.phoneNumber = @"0996572548";
        contactInfo.imgIcon = [UIImage imageNamed:[NSString stringWithFormat:@"icon%d", iconCount]];
        contactInfo.iconId = iconCount;
        
        if(iconCount < 4)
            iconCount++;
        else
            iconCount = 1;
        
        [self.dataArray addObject:contactInfo];
        [contactInfo release];
    }
    [self.tableView reloadData];
}

- (void)setupView
{
    [self createAddButton];
    [self configureTable];
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

#pragma - TableView

- (void)configureTable
{
    [super configureTable];

    self.tableView.frame = CGRectMake(0, self.btnAddContact.y + self.btnAddContact.height + 20, self.view.width, self.view.height - (self.btnAddContact.y + self.btnAddContact.height + 20));
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];

    if(self.tableView.superview != self.view)
        [self.view addSubview:self.tableView];
}

- (UITableViewCell *)createCellWithIndexPath:(NSIndexPath *)indexPath
{
    ContactListCell *cell = (ContactListCell *)[self createCellWithNib:CONTACET_LIST_CELL_ID forTableView:self.tableView withCellId:CONTACET_LIST_CELL_ID];
    
    ContactInfo *contactInfo = self.dataArray[indexPath.row];
    [cell configureCell:contactInfo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    ContactDetailController *contactDetailVC = [[[ContactDetailController alloc] initWithContactInfo:self.dataArray[indexPath.row]] autorelease];
    
    [UIView animateWithDuration:FLIP_ANIM_DURATION animations:^
    {
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [self.navigationController pushViewController:contactDetailVC animated:NO];
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark - Actions

- (void)onAdd:(id)sender
{
    ContactDetailController *contactDetailVC = [[ContactDetailController alloc] initWithContactInfo:nil];
    [self.navigationController pushViewController:contactDetailVC animated:YES];
    [contactDetailVC release];
}

@end
