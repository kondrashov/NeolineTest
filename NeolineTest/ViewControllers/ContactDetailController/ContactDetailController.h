//
//  ContactDetailController.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseInputController.h"
#import "ContactInfo.h"

typedef enum
{
    DetailMode_Add,
    DetailMode_Edit
}DetailMode;

@interface ContactDetailController : BaseInputController

@property (assign, nonatomic) DetailMode detailMode;

- (id)initWithContactInfo:(ContactInfo *)contactInfo;

@end
