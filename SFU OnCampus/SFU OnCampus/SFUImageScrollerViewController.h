//
//  SFUImageScrollerViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUImageMapsModel.h"
#import "SFULocation.h"

/**
 Changes the map image according to the building and floor selected by the spinner.
 @todo Not enough screen real-estate on iOS, use a sectioned spinner instead of a spinner and stepper.
 */
@interface SFUImageScrollerViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property SFULocation* src;
@property SFULocation* dest;
@property SFULocation* defaultLocation;

@property BOOL pageIsSrcPage;
@property BOOL pageIsDestPage;

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;

 @property (strong, atomic)   SFUImageMapsModel* model;

- (IBAction)centreDestinationButtonClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *centreDestinationButton;

@end
