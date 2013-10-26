//
//  ContactListCell.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ContactListCell.h"

@implementation ContactListCell

- (void)configureCell:(ContactInfo *)contactInfo
{
    self.lblId.text = [NSString stringWithFormat:@"%d.", contactInfo.contactId];
    self.lblFullName.text = [NSString stringWithFormat:@"%@ %@ %@", contactInfo.firstName, contactInfo.lastName, contactInfo.fatherName];
    [self.imgIcon setImage:contactInfo.imgIcon];
}

- (void)dealloc
{
    [_lblId release];
    [_imgIcon release];
    [_lblFullName release];
    [super dealloc];
}
@end
