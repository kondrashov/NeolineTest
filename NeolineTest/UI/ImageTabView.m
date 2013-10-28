//
//  ImageTabView.m
//  NeolineTest
//
//  Created by Artem Kondrashov on 27.10.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "ImageTabView.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_VIEW_SIZE     45
#define IMAGES_PADDING      20

@interface ImageTabView ()
{
    NSInteger curentIndex;
}

@property (retain, nonatomic) NSMutableArray *imageViewsArray;

@end

@implementation ImageTabView

#pragma mark - Lifecycle

- (id)initWithImagesArray:(NSArray *)imagesArray activeTabIndex:(NSInteger)activeTabIndex
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        curentIndex = activeTabIndex;
        [self updateUI:imagesArray];
    }
    return self;
}

- (void)dealloc
{
    [_imageViewsArray release];
    _delegate = nil;
    [super dealloc];
}

#pragma mark - Methods

- (void)setActiveImage:(NSInteger)index
{
    UIImageView *activeImageView = self.imageViewsArray[index];
    
    for(UIImageView *imgView in self.imageViewsArray)
    {
        if(imgView != activeImageView)
            imgView.layer.borderWidth = 0;
        else
        {
            curentIndex = activeImageView.tag;
            imgView.layer.borderColor = [UIColor redColor].CGColor;
            imgView.layer.borderWidth = 2;
        }
    }
}

- (UIImage *)getActiveImage
{
    return [self.imageViewsArray[curentIndex] image];
}

- (NSInteger)getActiveIndex
{
    return curentIndex;
}

- (void)updateUI:(NSArray *)imagesArray
{
    for(UIView *view in self.subviews)
        [view removeFromSuperview];
    
    [imagesArray retain];
    self.imageViewsArray = [NSMutableArray array];

    CGFloat x = 0;
    for(int i = 0; i < imagesArray.count; i++)
    {
        UIImage *image = imagesArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.frame = CGRectMake(x, 0, IMAGE_VIEW_SIZE, IMAGE_VIEW_SIZE);
        imageView.userInteractionEnabled = YES;
        x += IMAGE_VIEW_SIZE + IMAGES_PADDING;
        [self.imageViewsArray addObject:imageView];
        [self addSubview:imageView];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [tap release];
        
        [imageView release];
    }
    [imagesArray release];
    
    UIImageView *lastImgView = self.imageViewsArray[self.imageViewsArray.count - 1];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lastImgView.x + lastImgView.width, lastImgView.height);
}

#pragma mark - Actions

- (void)tap:(UIGestureRecognizer *)gesture
{
    [self setActiveImage:gesture.view.tag];
    if([self.delegate respondsToSelector:@selector(chooseImage:)])
        [self.delegate chooseImage:gesture.view.tag];
}

@end
