//
//  IMViewWithBorderedImage.h
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

#import <UIKit/UIKit.h>

@interface IMViewWithBorderedImage : UIView

enum IMViewWithBorderedImageContentMode {
    /* Scales the content to fit the size of the view. This option changes the aspect ratio of the content if necessary. */
    IMViewWithBorderedImageContentModeScaleToFill = 0, 
    
    /* Scales the content to fit the size of the view. This option maintains the aspect ratio of the content. */
    IMViewWithBorderedImageContentModeAspectFit = 1,
    /* Scales the content to fill the size of the view. Some portion of the content may be clipped to fill the view’s bounds. */
    IMViewWithBorderedImageContentModeAspectFill = 2,
    
    /* The other modes keep the original size. 
     The differces between them is what part of image will be visible on a view */
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

@property (nonatomic, strong) UIImage *image;       //Image which will be added to center of view

@property (nonatomic) NSUInteger borderWidth;       //Border width. Default is 0;
@property (nonatomic, strong) UIColor *borderColor; //Border color. Default color is black

@property (nonatomic) NSUInteger offsetWidth;       //Offset width. Offset looks like another border, which always sticks around image
@property (nonatomic, strong) UIColor *offsetColor; //Offset color. Default color is white and it's the same as background color of a view

@property (nonatomic) NSUInteger cornerRadius; //corner raduis

/* Represents the way image positioning on a view.
 The default value is IMViewWithBorderedImageContentModeScaleToFill */
@property (nonatomic) enum IMViewWithBorderedImageContentMode contentMode; 

@end