//
//  IMColorTableViewController.m
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 02.10.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import "IMColorTableViewController.h"

@interface IMColorTableViewController ()

@end

@implementation IMColorTableViewController

@synthesize delegate = _delegate;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Border color";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *cellText = nil;
    switch (indexPath.row) {
        case 0:
            cellText = @"White";
            break;
        case 1:
            cellText = @"Black";
            break;
        case 2:
            cellText = @"Blue";
            break;
        case 3:
            cellText = @"Red";
            break;
        case 4:
            cellText = @"Green";
            break;
        case 5:
            cellText = @"Yellow";
            break;
        case 6:
            cellText = @"Brown";
            break;
        default:
            break;
    }
    
    cell.textLabel.text = cellText;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIColor *selectedColor = nil;
    switch (indexPath.row) {
        case 0:
            selectedColor = [UIColor whiteColor];
            break;
        case 1:
            selectedColor = [UIColor blackColor];
            break;
        case 2:
            selectedColor = [UIColor blueColor];
            break;
        case 3:
            selectedColor = [UIColor redColor];
            break;
        case 4:
            selectedColor = [UIColor greenColor];
            break;
        case 5:
            selectedColor = [UIColor yellowColor];
            break;
        case 6:
            selectedColor = [UIColor brownColor];
        default:
            break;
    }
    
    [self.delegate colorTableViewControllerDidSelectColor:selectedColor];
}

@end
