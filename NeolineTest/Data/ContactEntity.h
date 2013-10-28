//
//  ContactEntity.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 27.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * contactId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * fatherName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSData * icon;
@property (nonatomic, retain) NSNumber * orderingValue;
@property (nonatomic, retain) NSNumber * iconId;

@end
