//
//  ContactListCell.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 26.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"

@interface ContactListCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lblId;
@property (retain, nonatomic) IBOutlet UIImageView *imgIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblFullName;

- (void)configureCell:(ContactInfo *)contactInfo;

@end
