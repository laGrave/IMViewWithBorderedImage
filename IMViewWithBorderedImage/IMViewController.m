//
//  IMViewController.m
//  IMViewWithBorderedImage
//
//  Created by Игорь Мищенко on 28.09.12.
//  Copyright (c) 2012 Igor Mischenko. All rights reserved.
//

#import "IMViewController.h"

#import "IMViewWithBorderedImage.h"
#import "IMContentModeTableViewController.h"

@interface IMViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, IMContentModeTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet IMViewWithBorderedImage *borderedImage;
@property (weak, nonatomic) IBOutlet UISlider *borderWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *offsetWidthSlider;

@end

@implementation IMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.borderWidthSlider.maximumValue = self.borderedImage.bounds.size.height;
    self.offsetWidthSlider.maximumValue = self.borderedImage.bounds.size.height/2;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Instance methods

- (IBAction)cameraButtonPressed:(id)sender {
    
    NSString *cameraButtonTitle;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        cameraButtonTitle = @"Camerass";
    }
    else {
        cameraButtonTitle = nil;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Library", cameraButtonTitle, nil];
    [actionSheet showInView:self.view];
}


- (IBAction)contentModeButtonPressed:(id)sender {
    
    IMContentModeTableViewController *tableVC = [[IMContentModeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableVC.delegate = self;
    [self presentViewController:tableVC animated:YES completion:NULL];
}


- (IBAction)borderWidthSliderValueChanged:(id)sender {
    
    self.borderedImage.borderWidth = (NSUInteger)[(UISlider *)sender value];
}


- (IBAction)offsetWidthSliderValueChanged:(id)sender {

    self.borderedImage.offsetWidth = (NSUInteger)[(UISlider *)sender value];
}



#pragma mark -
#pragma mark UIActionSheetDelegate protocol implementation

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        picker.sourceType = (buttonIndex == actionSheet.firstOtherButtonIndex) ? UIImagePickerControllerSourceTypeSavedPhotosAlbum : UIImagePickerControllerSourceTypeCamera;

        [self presentViewController:picker animated:YES completion:NULL];
    }
}


- (void)dismissPickerControllerAimated:(BOOL)animated {
    
    [self dismissViewControllerAnimated:animated completion:NULL];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate protocol implementation

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.borderedImage setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark -
#pragma mark IMContentModeTableViewControllerDelegate protocol implementation


- (void)tableViewDidSelectContentMode:(int)contentMode {

    [self.borderedImage setContentMode:contentMode];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
