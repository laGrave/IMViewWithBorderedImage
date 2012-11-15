//
//  IMColorTableViewController.h
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 02.10.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IMColorTableViewControllerDelegate <NSObject>

- (void)colorTableViewControllerDidSelectColor:(UIColor *)color;

@end

@interface IMColorTableViewController : UITableViewController

@property (nonatomic, weak) id <IMColorTableViewControllerDelegate> delegate;

@end
