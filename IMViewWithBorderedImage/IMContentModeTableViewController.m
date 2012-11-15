//
//  IMContentModeTableViewController.m
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 29.09.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import "IMContentModeTableViewController.h"

@interface IMContentModeTableViewController ()

@end

@implementation IMContentModeTableViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Content mode";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *textToCell = nil;
    switch (indexPath.row) {
        case 0:
            textToCell = @"Scale to Fill";
            break;
        case 1:
            textToCell = @"Aspect Fit";
            break;
        case 2:
            textToCell = @"Aspect Fill";
            break;
        case 3:
            textToCell = @"Top Left";
            break;
        case 4:
            textToCell = @"Top";
            break;
        case 5:
            textToCell = @"Top Right";
            break;
        case 6:
            textToCell = @"Left";
            break;
        case 7:
            textToCell = @"Center";
            break;
        case 8:
            textToCell = @"Right";
            break;
        case 9:
            textToCell = @"Bottom Left";
            break;
        case 10:
            textToCell = @"Bottom";
            break;
        case 11:
            textToCell = @"Bottom Right";
            break;
        default:
            break;
    }
    
    cell.textLabel.text = textToCell;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.delegate tableViewDidSelectContentMode:indexPath.row];
}

@end
