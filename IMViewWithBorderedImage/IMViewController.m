//
//  IMViewController.m
//  IMViewWithBorderedImage
//
//  Created by Igor Mischenko on 28.09.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import "IMViewController.h"

#import "IMViewWithBorderedImage.h"
#import "IMContentModeTableViewController.h"
#import "IMColorTableViewController.h"

@interface IMViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, IMContentModeTableViewControllerDelegate, IMColorTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet IMViewWithBorderedImage *borderedImage;
@property (weak, nonatomic) IBOutlet UISlider *borderWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *offsetWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *cornerRadiusSlider;
@property (nonatomic) BOOL isIPad;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *borderColorButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *contentModeButton;


@end

@implementation IMViewController

@synthesize borderedImage = _borderedImage;
@synthesize borderWidthSlider = _borderWidthSlider;
@synthesize offsetWidthSlider = _offsetWidthSlider;
@synthesize cornerRadiusSlider = _cornerRadiusSlider;
@synthesize isIPad = _isIPad;
@synthesize actionSheet = _actionSheet;
@synthesize popover = _popover;
@synthesize cameraButton = _cameraButton;
@synthesize borderColorButton = _borderColorButton;
@synthesize contentModeButton = _contentModeButton;

#pragma mark -
#pragma mark Getters

- (UIPopoverController *)popover {
    
    if (! _popover) {
        _popover = [[UIPopoverController alloc] initWithContentViewController:[[UIViewController alloc] init]];
    }
    return _popover;
}


#pragma mark -
#pragma mark View Controllers lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.isIPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    
    self.borderWidthSlider.maximumValue = self.borderedImage.bounds.size.height;
    self.offsetWidthSlider.maximumValue = self.borderedImage.bounds.size.height/2;
    self.cornerRadiusSlider.maximumValue = self.borderedImage.bounds.size.height/2;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {

    if (self.isIPad) return YES;
    else return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations {

    if (self.isIPad) return UIInterfaceOrientationMaskAll;
    else return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidUnload {
    
    [self setCameraButton:nil];
    [self setBorderedImage:nil];
    [self setBorderWidthSlider:nil];
    [self setOffsetWidthSlider:nil];
    [self setBorderColorButton:nil];
    [self setContentModeButton:nil];
    [self setCornerRadiusSlider:nil];
    [super viewDidUnload];
}


#pragma mark -
#pragma mark Instance methods

- (IBAction)cameraButtonPressed:(id)sender {
    
    if (!self.actionSheet.isVisible) {
        NSString *cameraButtonTitle;
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraButtonTitle = @"Cameras";
        }
        else {
            cameraButtonTitle = nil;
        }
        
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose source"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Library", cameraButtonTitle, nil];
        
        if (self.isIPad) {
            if (self.popover.isPopoverVisible) {
                [self.popover dismissPopoverAnimated:YES];
            }
            [self.actionSheet showFromBarButtonItem:sender animated:YES];
        }
        else [self.actionSheet showInView:self.view];
    }

}


- (IBAction)borderColorButtonPressed:(id)sender {
    
    IMColorTableViewController *colorTableVC = [[IMColorTableViewController alloc] initWithStyle:UITableViewStylePlain];
    colorTableVC.delegate = self;
    if (self.isIPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:YES];
        }
        else {
            self.popover.contentViewController = colorTableVC;
            self.popover.popoverContentSize = CGSizeMake(320, 330);
            [self.popover presentPopoverFromBarButtonItem:self.borderColorButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
    else {
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:colorTableVC];
        [self presentViewController:navVC animated:YES completion:NULL];
    }
}


- (IBAction)contentModeButtonPressed:(id)sender {
    
    IMContentModeTableViewController *tableVC = [[IMContentModeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableVC.delegate = self;
    if (self.isIPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:YES];
        }
        else {
            self.popover.contentViewController = tableVC;
            self.popover.popoverContentSize = CGSizeMake(320, 530);
            [self.popover presentPopoverFromBarButtonItem:self.contentModeButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
    else {
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:tableVC];
        [self presentViewController:navVC animated:YES completion:NULL];
    }
}


- (IBAction)borderWidthSliderValueChanged:(id)sender {
    
    self.borderedImage.borderWidth = (NSUInteger)[(UISlider *)sender value];
}


- (IBAction)offsetWidthSliderValueChanged:(id)sender {

    self.borderedImage.offsetWidth = (NSUInteger)[(UISlider *)sender value];
}


- (IBAction)cornerRadiusSliderValueChanged:(id)sender {
    
    self.borderedImage.cornerRadius = (NSUInteger)[(UISlider *)sender value];
}


#pragma mark -
#pragma mark UIActionSheetDelegate protocol implementation

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = (buttonIndex == actionSheet.firstOtherButtonIndex) ? UIImagePickerControllerSourceTypeSavedPhotosAlbum : UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;

        if (self.isIPad) {
            self.popover.contentViewController = picker;
            self.popover.popoverContentSize = picker.contentSizeForViewInPopover;
            [self.popover presentPopoverFromBarButtonItem:self.cameraButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else [self presentViewController:picker animated:YES completion:NULL];
    }
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate protocol implementation

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    if (self.isIPad) ;
    else [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.borderedImage setImage:image];
    
    if (self.isIPad) [self.popover dismissPopoverAnimated:YES];
    else [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark -
#pragma mark IMContentModeTableViewControllerDelegate protocol implementation

- (void)tableViewDidSelectContentMode:(int)contentMode {

    [self.borderedImage setContentMode:contentMode];
    if (self.isIPad) [self.popover dismissPopoverAnimated:YES];
    else [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark -
#pragma mark IMColorTableViewControllerDelegate protocol implementation

- (void)colorTableViewControllerDidSelectColor:(UIColor *)color {

    [self.borderedImage setBorderColor:color];
    if (self.isIPad) [self.popover dismissPopoverAnimated:YES];
    else [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
