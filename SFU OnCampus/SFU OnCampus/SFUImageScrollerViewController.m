//
//  SFUImageScrollerViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUImageScrollerViewController.h"

@interface SFUImageScrollerViewController ()
{
@private
    SFUImageMapsModel* _model;
    NSArray* floorNames;
    NSUInteger floorIndex;
    NSUInteger buildingIndex;
    
    CGPoint relativeSrcLocation;
    CGPoint relativeDestLocation;
}
@end

@implementation SFUImageScrollerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    floorIndex =buildingIndex =0;
    [self updateFloorLabel];// Do any additional setup after loading the view.
    _model = [SFUImageMapsModel new];
    NSString*imgPath = [_model nameOfImageForBuildingAtIndex:0 onFloorWithIndex:0];
    [self setScrollImage:[UIImage imageNamed:imgPath]];
    
    relativeSrcLocation.x=.5;
    relativeSrcLocation.y=.5;
    relativeDestLocation.x=.25;
    relativeDestLocation.y=.25;
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
    //tod deelte, used segmented stepper instead.
    //    self.floorNumberStepper.maximumValue= [_model floorCountForBuldingWithIndex:floorIndex];
    //        self.floorNumberLabel.text = [[NSNumber numberWithInteger:self.floorNumberStepper.value] stringValue];
}
- (IBAction)floorChanged:(UIStepper *)sender
{
    [self updateFloorLabel];
    NSString*imgPath = [_model nameOfImageForBuildingAtIndex:buildingIndex onFloorWithIndex:self.floorNumberStepper.value];
    [self setScrollImage:[UIImage imageNamed:imgPath]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [_model nameOfBuildingAtIndex:row];
    }
    else
    {
        return [_model nameOfFloorInBuildingWithIndex:buildingIndex onFloorWithIndex:floorIndex];
    }
    //return @"AQ (Academic Quadrangle";
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}
-(void)setScrollImage:(UIImage*)img
{
    self.imageView.image=[self imageByDrawingCircleOnImage:img];
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
    buildingIndex=row;
}

-(void)setSourceLocationToShortcode:(NSString*)s
{
    
}

-(void)setDestinationLocationToShortcode:(NSString*)s
{
    
}

#pragma mark Custom Drawing

//Derived from https://www.cocoanetics.com/2010/07/drawing-on-uiimages/
- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image
{
    
    if(image == nil)
    {
        return image;
    }
    // begin a graphics context of sufficient size
    UIGraphicsBeginImageContext(image.size);
    
    // draw original image into the context
    [image drawAtPoint:CGPointZero];
    
    // get the context for CoreGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if(ctx == nil)
    {
        return image;
    }
    
    if([self pageIsSrcPage])
    {
        // set stroking color and draw circle
        [[UIColor greenColor] setStroke];
        [[UIColor greenColor] setFill];
        
        // make circle rect 5 px from border
        CGRect circleRect = CGRectMake(relativeSrcLocation.x*image.size.width, relativeSrcLocation.y*image.size.height,
                                       20,
                                       20);
        //circleRect = CGRectInset(circleRect, 5, 5);
        
        // draw circle
        CGContextFillEllipseInRect(ctx, circleRect);
    }
    
    if([self pageIsDestPage])
    {
        // set stroking color and draw circle
        [[UIColor redColor] setStroke];
        [[UIColor redColor] setFill];
        
        // make circle rect 5 px from border
        CGRect circleRect = CGRectMake(relativeDestLocation.x*image.size.width  , relativeDestLocation.y*image.size.height,
                                       20,
                                       20);
        //circleRect = CGRectInset(circleRect, 5, 5);
        
        // draw circle
        CGContextFillEllipseInRect(ctx, circleRect);
    }
    
    
    
    // make image out of bitmap context
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // free the context
    UIGraphicsEndImageContext();
    
    return retImage;
    
}

/**
 Is the currently displayed page the page where the source room is?
 */
-(BOOL) pageIsSrcPage
{
    return true;
}

/**
 Is the currently displayed page the page where the destination room is?
 */
-(BOOL) pageIsDestPage
{
    return true;
}

#pragma mark debug

-(IBAction)recordRelativePosition:(UILongPressGestureRecognizer*)sender
{
    CGPoint p = [self.imageView convertPoint:[sender locationInView:self.imageView] fromView:self.imageView];
    p.x /= self.imageView.image.size.width;
    p.y /= self.imageView.image.size.height;
    printf("held relativePos {%f,%f}\n",p.x,p.y);
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
