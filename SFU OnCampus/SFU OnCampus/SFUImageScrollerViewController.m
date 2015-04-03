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
    floorIndex = 0;
    buildingIndex =0;
    
    //prevent the menu from appearing when we swipt the left hand side of the screen.
    self.splitViewController.presentsWithGesture = NO;

    self.model = [SFUImageMapsModel new];
    
    if(self.defaultLocation != nil)
    {
    buildingIndex = [self.model indexOfBuildingWithShortcode:self.defaultLocation.buildingCode];
    floorIndex = [self.model indexOfPageWithName:self.defaultLocation.pageName inBuildingAtIndex:buildingIndex];
        [self.pickerView selectRow:buildingIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:floorIndex inComponent:1 animated:YES];
    }

    
    NSString* floor = [self.model nameOfFloorInBuildingWithIndex:buildingIndex onFloorWithIndex:floorIndex];
    BOOL rightSrcPage = [floor characterAtIndex:0] == [self.src.pageName characterAtIndex:0];
    BOOL rightDestPage = [floor characterAtIndex:0] == [self.dest.pageName characterAtIndex:0];
    
    BOOL rightSrcBuilding = [[self.model shortCodeForBuildingAtIndex:buildingIndex ] isEqualToString: self.dest.buildingCode ];
    BOOL rightDestBuilding = [[self.model shortCodeForBuildingAtIndex:buildingIndex ] isEqualToString: self.dest.buildingCode ];
    
    self.pageIsSrcPage = rightSrcBuilding && rightSrcPage;
    self.pageIsDestPage = rightDestPage && rightDestBuilding;
    
    NSString*imgPath = [self.model nameOfImageForBuildingAtIndex:buildingIndex onFloorWithIndex:floorIndex];
    UIImage* img =[UIImage imageNamed:imgPath];
    [self setScrollImage:img];
    
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{

    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(self.model == nil)
        self.model = [SFUImageMapsModel new];
    
    if(component == 0)
    {
        return [self.model nameOfBuildingAtIndex:row];
    }
    else
    {
        return [self.model nameOfFloorInBuildingWithIndex:buildingIndex onFloorWithIndex:row];
    }
    //return @"AQ (Academic Quadrangle";
}

- (IBAction)centreDestinationButtonClicked:(id)sender {
    [self centreDestination];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(self.model == nil)
        self.model = [SFUImageMapsModel new];
    
    if(component == 0)
    {
        return  [self.model numberOfBuildings];
    }
    else
    {
        return [self.model numberOfFloorsForBuildingAtIndex:buildingIndex];
    }
}
-(void)setScrollImage:(UIImage*)img
{
    relativeSrcLocation = [self.model relativeLocationOfRoom:self.src.roomCode onFloorAtIndex: floorIndex inBuildingAtIndex: buildingIndex];
    relativeDestLocation = [self.model relativeLocationOfRoom:self.dest.roomCode onFloorAtIndex: floorIndex inBuildingAtIndex: buildingIndex];
    self.imageView= [self.imageView initWithImage:img];
    self.scrollView.contentSize = self.imageView.frame.size;


   
    
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{

 
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    
    
    if(component == 0)
    {
        buildingIndex = row;
        floorIndex=0;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
    }
    else
    {
        floorIndex = row;
    }
    
    NSString*imgPath = [self.model nameOfImageForBuildingAtIndex:buildingIndex onFloorWithIndex:floorIndex];
    
    NSString* floor = [self.model nameOfFloorInBuildingWithIndex:buildingIndex onFloorWithIndex:row];
    BOOL rightSrcPage = [floor characterAtIndex:0] == [self.src.pageName characterAtIndex:0];
    BOOL rightDestPage = [floor characterAtIndex:0] == [self.dest.pageName characterAtIndex:0];
    
    
    BOOL rightSrcBuilding = [[self.model shortCodeForBuildingAtIndex:buildingIndex ] isEqualToString: self.dest.buildingCode ];
    BOOL rightDestBuilding = [[self.model shortCodeForBuildingAtIndex:buildingIndex ] isEqualToString: self.dest.buildingCode ];
    
    self.pageIsSrcPage = rightSrcBuilding && rightSrcPage;
    self.pageIsDestPage = rightDestPage && rightDestBuilding;
    
    [self setScrollImage:[UIImage imageNamed:imgPath]];
    

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
        self.centreDestinationButton.enabled =YES;
    }else
    {
        self.centreDestinationButton.enabled =NO;

    }
    
    
    
    // make image out of bitmap context
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // free the context
    UIGraphicsEndImageContext();
    
    return retImage;
    
}

///**
// Is the currently displayed page the page where the source room is?
// */
//-(BOOL) pageIsSrcPage
//{
//    return true;
//}
//
///**
// Is the currently displayed page the page where the destination room is?
// */
//-(BOOL) pageIsDestPage
//{
//    return true;
//}

#pragma mark debug

-(IBAction)recordRelativePosition:(UILongPressGestureRecognizer*)sender
{
    CGPoint p = [self.imageView convertPoint:[sender locationInView:self.imageView] fromView:self.imageView];
    p.x /= self.imageView.image.size.width;
    p.y /= self.imageView.image.size.height;
    printf("held relativePos {%f,%f}\n",p.x,p.y);
}

-(CGPoint)relativePositionToRealPosition:(CGPoint)p
{
    p.x *= self.imageView.image.size.width;
    p.y *= self.imageView.image.size.height;
    return p;
}

-(void)scrollToRelativePosition:(CGPoint)p
{
    p = [self relativePositionToRealPosition:p];
    p.x -= (self.scrollView.frame.size.width/2.0);
    p.y -= (self.scrollView.frame.size.height /2.0);
    [self.scrollView setContentOffset:p animated:YES];
}

-(void)centreDestination
{
    [self scrollToRelativePosition:relativeDestLocation];
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
