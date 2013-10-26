//
//  ContactInfo.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

@property (assign, nonatomic) NSInteger contactId;
@property (retain, nonatomic) NSString  *firstName;
@property (retain, nonatomic) NSString  *lastName;
@property (retain, nonatomic) NSString  *fatherName;
@property (retain, nonatomic) NSString  *phoneNumber;
@property (retain, nonatomic) UIImage   *imgIcon;

@end
