//
//  UINavigationController+ios6fix.m
//  TestSplitVC
//
//  Created by Numeral on 11/7/12.
//  Copyright (c) 2012 laGrave. All rights reserved.
//

#import "UINavigationController+ios6fix.h"

@implementation UINavigationController (ios6fix)

- (NSUInteger)supportedInterfaceOrientations {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate {
    
    return YES;
}
@end
