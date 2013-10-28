//
//  ContactListCell.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactListCell.h"

@implementation ContactListCell

- (void)configureCell:(ContactEntity *)contactInfo
{
    self.lblId.text = [NSString stringWithFormat:@"%d.", contactInfo.contactId.integerValue];
    self.lblFullName.text = [NSString stringWithFormat:@"%@ %@ %@", contactInfo.lastName, contactInfo.firstName, contactInfo.fatherName];
    [self.imgIcon setImage:[UIImage imageWithData:contactInfo.icon]];
}

- (void)dealloc
{
    [_lblId release];
    [_imgIcon release];
    [_lblFullName release];
    [super dealloc];
}
@end
