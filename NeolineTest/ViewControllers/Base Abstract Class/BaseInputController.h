//
//  BaseInputController.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 27.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseInputController : BaseNavigationController <UITextFieldDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutletCollection(UITextField) NSArray *textFields;
}

- (void)createGestures;
- (void)createObservers;

@end
