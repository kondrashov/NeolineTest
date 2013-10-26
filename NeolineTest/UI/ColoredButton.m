//
//  ColoredButton.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ColoredButton.h"

@implementation ColoredButton

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
        self.backgroundColor = self.highlightColor;
    else
        self.backgroundColor = self.normalColor;
}

- (void)dealloc
{
    [_normalColor release];
    [_highlightColor release];
    [super dealloc];
}

@end
