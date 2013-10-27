//
//  BaseNavigationController.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"

#define BAR_BUTTON_FONT_SIZE            15
#define BAR_BUTTON_TITLE_PADDING_X      10
#define BAR_BUTTON_TITLE_PADDING_Y      5

#define RectEdgeNone                    0

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

#pragma mark - Lifecylce

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(206, 231, 244);
    [self configureNavBar];

    // iOS 7
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:RectEdgeNone];
}

#pragma mark - Methods

- (void)configureNavBar
{
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBackgImg"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [self getTitleView];
    
    if(self.navigationController.viewControllers.count > 1)
        [self addBackButton];
}

- (void)addBackButton
{
    self.navigationItem.leftBarButtonItem = [self createBarButtonWithTitle:@"Назад" delegate:self selector:@selector(onLeftBarButton:)];
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

- (ColoredButton *)createButtonWithTitle:(NSString *)title delegate:(id)delegate selector:(SEL)selector normalColor:(UIColor *)normColor highlightColor:(UIColor *)highlightColor fontSize:(NSInteger)fontSize paddingX:(NSInteger)paddingX paddingY:(NSInteger)paddingY
{
    ColoredButton *button = [ColoredButton buttonWithType:UIButtonTypeCustom];
    CGSize btnTitleSize = [title sizeWithFont:[UIFont systemFontOfSize:fontSize]];
    
    [button setNormalColor:normColor];
    [button setBackgroundColor:button.normalColor];
    [button setHighlightColor:highlightColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [button setFrame:CGRectMake(0, 0, btnTitleSize.width + paddingX, btnTitleSize.height + paddingY)];
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = RGBCOLOR(146, 162, 172).CGColor;
    button.layer.borderWidth = 1;
    
    return button;
}

- (UIBarButtonItem *)createBarButtonWithTitle:(NSString *)title delegate:(id)delegate selector:(SEL)selector
{
    ColoredButton *button = [self createButtonWithTitle:title delegate:delegate selector:selector normalColor:RGBCOLOR(206, 231, 244) highlightColor:RGBCOLOR(152, 158, 160) fontSize:BAR_BUTTON_FONT_SIZE paddingX:BAR_BUTTON_TITLE_PADDING_X paddingY:BAR_BUTTON_TITLE_PADDING_Y];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return [barButtonItem autorelease];
}

#pragma mark - Actions

- (void)onRightBarButton:(id)sender
{
    // Override in childs
}

- (void)onLeftBarButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
