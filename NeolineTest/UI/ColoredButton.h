//
//  ColoredButton.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColoredButton : UIButton

@property (retain, nonatomic) UIColor *normalColor;
@property (retain, nonatomic) UIColor *highlightColor;

@end
