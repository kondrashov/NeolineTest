//
//  UIImage+Helpers.m
//  MikroApp
//
//  Created by Artem Kondrashov on 26.09.13.
//  Copyright (c) 2013 Artem Kondrashov. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)

- (UIImage*)safeResizableImageWithCapInsets:(UIEdgeInsets)edgeInsets
                               resizingMode:(UIImageResizingMode)resizingMode
{
    if ([UIImage resolveInstanceMethod:@selector(resizableImageWithCapInsets:)])
        return [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    else
        return [self stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
    
    return nil;
}

- (UIImage *)scaledImageForSize:(CGSize)maxSize
{
    // pick the target dimensions, as though applying
    // UIViewContentModeScaleAspectFit; seed some values first

    CGSize sizeOfImage = [self size];
    CGSize targetSize; // to store the output size
    
    // logic here: we're going to scale so as to apply some multiplier
    // to both the width and height of the input image. That multiplier
    // is either going to make the source width fill the output width or
    // it's going to make the source height fill the output height. Of the
    // two possibilities, we want the smaller one, since the larger will
    // make the other axis too large
    if(maxSize.width / sizeOfImage.width < maxSize.height / sizeOfImage.height)
    {
        // we'll letter box then; scaling width to fill width, since
        // that's the smaller scale of the two possibilities
        targetSize.width = maxSize.width;
        
        // height is the original height adjusted proportionally
        // to match the proportional adjustment in width
        targetSize.height =
        (maxSize.width / sizeOfImage.width) * sizeOfImage.height;
    }
    else
    {
        // basically the same as the above, except that we pillar box
        targetSize.height = maxSize.height;
        targetSize.width =
        (maxSize.height / sizeOfImage.height) * sizeOfImage.width;
    }
    
    // images can be integral sizes only, so round up
    // the target size and width, then construct a target
    // rect that centres the output image within that size;
    // this all ensures sub-pixel accuracy
    CGRect targetRect;
    
    // store the original target size and round up the original
    targetRect.size = targetSize;
    targetSize.width = ceilf(targetSize.width);
    targetSize.height = ceilf(targetSize.height);
    
    // work out how to centre the source image within the integral-sized
    // output image
    targetRect.origin.x = (targetSize.width - targetRect.size.height) * 0.5f;
    targetRect.origin.y = (targetSize.height - targetRect.size.width) * 0.5f;
    
    // now create a CGContext to draw to, draw the image to it suitably
    // scaled and positioned, and turn the thing into a UIImage
    
    // get a suitable CoreGraphics context to draw to, in RGBA;
    // I'm assuming iOS 4 or later here, to save some manual memory
    // management.
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context  = CGBitmapContextCreate(
                                                  NULL,
                                                  targetSize.width, targetSize.height,
                                                  8, targetSize.width * 4,
                                                  colourSpace,
                                                  kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    // clear the context, since it may currently contain anything.
    CGContextClearRect(context,
                       CGRectMake(0.0f, 0.0f, targetSize.width, targetSize.height));
    
    // draw the given image to the newly created context
    CGContextDrawImage(context, targetRect, [self CGImage]);
    
    // get an image from the CG context, wrapping it as a UIImage
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    
    // clean up
    CGContextRelease(context);
    CGImageRelease(cgImage);
    
    return returnImage;
}

@end
