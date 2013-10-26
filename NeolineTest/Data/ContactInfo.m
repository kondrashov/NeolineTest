//
//  ContactInfo.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactInfo.h"

@implementation ContactInfo

- (void)dealloc
{
    [_firstName release];
    [_lastName release];
    [_fatherName release];
    [_phoneNumber release];
    [_imgIcon release];
    [super dealloc];
}

@end
