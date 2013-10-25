//
//  UIView+Helpers.h
//  MikroApp
//
//  Created by Artem Kondrashov on 21.09.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helpers)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;

- (void)frameRoundToInt;
- (UIView *)findFirstResponder;

@end
