//
//  SFUImageScrollerViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFUImageScrollerViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *floorNumberLabel;
@property (strong, nonatomic) IBOutlet UIStepper *floorNumberStepper;
- (IBAction)floorChanged:(UIStepper *)sender;

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;

@end
