//
//  ImageTabView.h
//  NeolineTest
//
//  Created by Artem Kondrashov on 27.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageTabViewDelegate <NSObject>

- (void)chooseImage:(NSInteger)imageIndex;

@end

@interface ImageTabView : UIView

- (id)initWithImagesArray:(NSArray *)imagesArray activeTabIndex:(NSInteger)activeTabIndex;
- (void)updateUI:(NSArray *)imagesArray;

@property (assign, nonatomic) id<ImageTabViewDelegate> delegate;

@end
