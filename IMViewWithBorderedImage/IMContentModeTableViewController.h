//
//  IMContentModeTableViewController.h
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 29.09.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IMContentModeTableViewControllerDelegate <NSObject>

- (void)tableViewDidSelectContentMode:(int)contentMode;

@end

@interface IMContentModeTableViewController : UITableViewController

@property (nonatomic, weak) id <IMContentModeTableViewControllerDelegate> delegate;

@end
