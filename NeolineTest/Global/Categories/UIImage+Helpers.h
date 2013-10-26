//
//  UIImage+Helpers.h
//  MikroApp
//
//  Created by Artem Kondrashov on 26.09.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helpers)

- (UIImage*)safeResizableImageWithCapInsets:(UIEdgeInsets)edgeInsets
                               resizingMode:(UIImageResizingMode)resizingMode;
@end
