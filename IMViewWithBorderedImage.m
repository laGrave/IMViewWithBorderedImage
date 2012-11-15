//
//  IMViewWithBorderedImage.m
//  UIViewExtension
//
//  Created by Igor Mischenko on 28.08.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "IMViewWithBorderedImage.h"

#import <QuartzCore/QuartzCore.h>

@interface IMViewWithBorderedImage()

@property (nonatomic, strong) UIImage *resizedImage;

@end

@implementation IMViewWithBorderedImage

@synthesize offsetWidth = _offsetWidth;
@synthesize borderWidth = _borderWidth;
@synthesize image = _image;
@synthesize borderColor = _borderColor;
@synthesize contentMode = _contentMode;
@synthesize resizedImage = _resizedImage;
@synthesize cornerRadius = _cornerRadius;
@synthesize offsetColor = _offsetColor;


- (void)setImage:(UIImage *)image {

    _image = image;
    [self updateImage];
}


- (void)setCornerRadius:(NSUInteger)cornerRadius {

    self.layer.cornerRadius = cornerRadius;
    self.layer.opaque = NO;
    self.layer.masksToBounds = YES;
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}


- (void)setContentMode:(enum IMViewWithBorderedImageContentMode)contentMode {

    _contentMode = contentMode;
    [self updateImage];
}


- (void)setBorderWidth:(NSUInteger)borderWidth {

    self.layer.borderWidth = borderWidth;
    _borderWidth = borderWidth;
    [self setNeedsLayout];
}


- (void)setOffsetWidth:(NSUInteger)offsetWidth {

    _offsetWidth = offsetWidth;
    [self setNeedsDisplay];
}


- (void)setOffsetColor:(UIColor *)offsetColor {

    [self setBackgroundColor:offsetColor];
}


- (void)setBorderColor:(UIColor *)borderColor {

    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    [self setNeedsLayout];
}


- (UIColor *)borderColor {

    if (!_borderColor) {
        _borderColor = [UIColor blackColor];
    }
    return _borderColor;
}


- (void)updateImage {

    switch (self.contentMode) {
        case IMViewWithBorderedImageContentModeAspectFit:
            self.resizedImage = [self image:self.image ByScalingProportionallyToSize:self.bounds.size];
            break;
        case IMViewWithBorderedImageContentModeAspectFill:
            self.resizedImage = [self image:self.image ScaledProportionallyToMinimumSize:self.bounds.size];
            break;
        case IMViewWithBorderedImageContentModeTopLeft:
        case IMViewWithBorderedImageContentModeTop:
        case IMViewWithBorderedImageContentModeTopRight:
        case IMViewWithBorderedImageContentModeLeft:
        case IMViewWithBorderedImageContentModeCenter:
        case IMViewWithBorderedImageContentModeRight:
        case IMViewWithBorderedImageContentModeBottomLeft:
        case IMViewWithBorderedImageContentModeBottom:
        case IMViewWithBorderedImageContentModeBottomRight:
            self.resizedImage = [self image:self.image AtRect:[self rectToCrop:self.contentMode]];
            break;
        default:
            self.resizedImage = [self image:self.image ByScalingToSize:self.bounds.size];
            break;
    }

    [self setNeedsDisplay];
}


- (CGRect)rectToCrop:(enum IMViewWithBorderedImageContentMode)contentMode {

    CGRect rect = CGRectNull;
    switch (self.contentMode) {
        case IMViewWithBorderedImageContentModeTopLeft:
            rect.origin = CGPointMake(0, 0);
            break;
        case IMViewWithBorderedImageContentModeTop:
            rect.origin = CGPointMake((self.image.size.width - self.bounds.size.width) / 2, 0);            
            break;
        case IMViewWithBorderedImageContentModeTopRight:
            rect.origin = CGPointMake(self.image.size.width - self.bounds.size.width, 0);
            break;
        case IMViewWithBorderedImageContentModeLeft:
            rect.origin = CGPointMake(0, (self.image.size.height - self.bounds.size.height) / 2);
            break;
        case IMViewWithBorderedImageContentModeCenter:
            rect.origin = CGPointMake((self.image.size.width - self.bounds.size.width) / 2, (self.image.size.height - self.bounds.size.height) / 2);
            break;
        case IMViewWithBorderedImageContentModeRight:
            rect.origin = CGPointMake(self.image.size.width - self.bounds.size.width, (self.image.size.height - self.bounds.size.height) / 2);
            break;
        case IMViewWithBorderedImageContentModeBottomLeft:
            rect.origin = CGPointMake(0, self.image.size.height - self.bounds.size.height);
            break;
        case IMViewWithBorderedImageContentModeBottom:
            rect.origin = CGPointMake((self.image.size.width - self.bounds.size.width) / 2, self.image.size.height - self.bounds.size.height);
            break;
        case IMViewWithBorderedImageContentModeBottomRight:
            rect.origin = CGPointMake(self.image.size.width - self.bounds.size.width, self.image.size.height - self.bounds.size.height);
            break;
        default:
            break;
    }
    
    rect.size = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    
    return rect;
}


#pragma mark -
#pragma mark Work with image

- (UIImage *)image:(UIImage*)image AtRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
}


- (UIImage *)image:(UIImage *)image ScaledProportionallyToMinimumSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // scaling image:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)image:(UIImage *)image ByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // scaling image:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)image:(UIImage *)image ByScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    // scaling image:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}



#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGRect imageRect = rect;
    imageRect.size.width -= self.offsetWidth * 2;
    imageRect.size.height -= self.offsetWidth * 2;
    imageRect.origin.x += self.offsetWidth;
    imageRect.origin.y += self.offsetWidth;

    [self.resizedImage drawInRect:imageRect];
}


@end
