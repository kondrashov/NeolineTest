//
//  BaseInputController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 27.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseInputController.h"
#import "AppDelegate.h"

#define KEYBOARD_PADDING    10
#define BOTTOM_PADDING      30

@interface BaseInputController ()

@end

@implementation BaseInputController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createGestures];
    [self createObservers];
    [self configureScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    scrollView = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [scrollView release];
    [textFields release];
    [super dealloc];
}

#pragma mark - Methods

- (void)configureScrollView
{
    UITextField *bottomField = textFields[textFields.count - 1];
    scrollView.contentSize = CGSizeMake(scrollView.width, bottomField.y + bottomField.height + BOTTOM_PADDING);
}

- (void)createGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    tap.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tap];
    [tap release];
}

- (void)createObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Notifications

- (void)keyboardWillShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    NSNumber *duration = [[aNotification userInfo ] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat kbHeight;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsPortrait(orientation))
        kbHeight = kbSize.height;
    else
        kbHeight = kbSize.width;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);    
    UITextField *activeField = (UITextField *)[self.view findFirstResponder];
    
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbHeight;
    if (!CGRectContainsPoint(aRect, CGPointMake(activeField.x, activeField.y + activeField.height)))
    {
        CGPoint scrollPoint = CGPointMake(0.0, ((activeField.y + activeField.height) - aRect.size.height) + KEYBOARD_PADDING);
        
        [UIView animateWithDuration:[duration doubleValue] animations:^{
            [scrollView setContentOffset:scrollPoint animated:NO];
        }];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSNumber *duration = [[aNotification userInfo ] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration doubleValue] animations:^
     {
         scrollView.contentOffset = CGPointZero;
     }
     completion:^(BOOL finished)
     {
         scrollView.contentInset = UIEdgeInsetsZero;
         scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
     }];
}

#pragma mark - Actions

- (void)tapScrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self configureScrollView];
}

@end
