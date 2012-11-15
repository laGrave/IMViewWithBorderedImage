//
//  IMViewWithBorderedImage.h
//  UIViewExtension
//
//  Created by Игорь Мищенко on 28.08.12.
//  Copyright (c) 2012 Игорь Мищенко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMViewWithBorderedImage : UIView

enum IMViewWithBorderedImageContentMode {
    IMViewWithBorderedImageContentModeScaleToFill = 0,
    
    IMViewWithBorderedImageContentModeAspectFit = 1,
    IMViewWithBorderedImageContentModeAspectFill = 2,
    
    IMViewWithBorderedImageContentModeTopLeft = 3,
    IMViewWithBorderedImageContentModeTop = 4,
    IMViewWithBorderedImageContentModeTopRight = 5,
    IMViewWithBorderedImageContentModeLeft = 6,
    IMViewWithBorderedImageContentModeCenter = 7,
    IMViewWithBorderedImageContentModeRight = 8,
    IMViewWithBorderedImageContentModeBottomLeft = 9,
    IMViewWithBorderedImageContentModeBottom = 10,
    IMViewWithBorderedImageContentModeBottomRight = 11
};

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) NSUInteger offsetWidth;
@property (nonatomic, strong) UIColor *offsetColor;
@property (nonatomic) NSUInteger borderWidth;
@property (nonatomic) NSUInteger cornerRadius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) enum IMViewWithBorderedImageContentMode contentMode;
//@property (nonatomic) NSUInteger cornerRaduis;

@end