//
//  IMAppDelegate.h
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 28.09.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMViewController;

@interface IMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IMViewController *viewController;

@end
