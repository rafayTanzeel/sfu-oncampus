//
//  SFUImageScrollerViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUImageScrollerViewController.h"

@interface SFUImageScrollerViewController ()

@end

@implementation SFUImageScrollerViewController
NSUInteger floorIndex;
SFUImageMapsModel* _model;
NSArray* floorNames;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateFloorLabel];// Do any additional setup after loading the view.
    _model = [SFUImageMapsModel new];
    NSString*imgPath = [_model nameOfImageForBuildingAtIndex:0 onFloorWithIndex:0];
    [self setScrollImage:[UIImage imageNamed:imgPath]];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateFloorLabel
{
        self.floorNumberLabel.text = [[NSNumber numberWithInteger:self.floorNumberStepper.value] stringValue];
}
- (IBAction)floorChanged:(UIStepper *)sender
{
    [self updateFloorLabel];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [_model nameOfBuildingAtIndex:row];
    return @"AQ (Academic Quadrangle";
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [_model numberOfBuildings];
}
-(void)setScrollImage:(UIImage*)img
{
    self.imageView.image=img;
    self.scrollView.contentSize = self.imageView.image.size;
}
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    NSString*imgPath = [_model nameOfImageForBuildingAtIndex:row onFloorWithIndex:self.floorNumberStepper.value];
    [self setScrollImage:[UIImage imageNamed:imgPath]];
    //set floots
    //set stepper to floors count
    //set prefered floor if applicable
        [self updateFloorLabel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
