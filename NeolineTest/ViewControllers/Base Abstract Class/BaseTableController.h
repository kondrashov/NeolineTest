//
//  BaseTableController.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 25.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseTableController : BaseNavigationController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView  *tableView;
@property (nonatomic, retain) NSMutableArray        *dataArray;

- (void)configureTable;
- (UITableViewCell *)createCellWithIndexPath:(NSIndexPath *)indexPath;

@end
