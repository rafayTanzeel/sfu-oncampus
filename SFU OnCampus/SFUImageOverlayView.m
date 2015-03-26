//
//  SFUImageOverlayView.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-26.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUImageOverlayView.h"

@implementation SFUImageOverlayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawInContext:(CGContextRef)context
{
    // Drawing lines with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    
    // Each dash entry is a run-length in the current coordinate system
    // The concept is first you determine how many points in the current system you need to fill.
    // Then you start consuming that many pixels in the dash pattern for each element of the pattern.
    // So for example, if you have a dash pattern of {10, 10}, then you will draw 10 points, then skip 10 points, and repeat.
    // As another example if your dash pattern is {10, 20, 30}, then you draw 10 points, skip 20 points, draw 30 points,
    // skip 10 points, draw 20 points, skip 30 points, and repeat.
    // The dash phase factors into this by stating how many points into the dash pattern to skip.
    // So given a dash pattern of {10, 10} with a phase of 5, you would draw 5 points (since phase plus 5 yields 10 points),
    // then skip 10, draw 10, skip 10, draw 10, etc.
    
    //CGContextSetLineDash(context, 1.0f, 1.0f, 1.0);
    
    // Draw a horizontal line, vertical line, rectangle and circle for comparison
    CGContextMoveToPoint(context, 10.0, 20.0);
    CGContextAddLineToPoint(context, 310.0, 20.0);
    CGContextMoveToPoint(context, 160.0, 30.0);
    CGContextAddLineToPoint(context, 160.0, 130.0);
    CGContextAddRect(context, CGRectMake(10.0, 30.0, 100.0, 100.0));
    CGContextAddEllipseInRect(context, CGRectMake(210.0, 30.0, 100.0, 100.0));
    // And width 2.0 so they are a bit more visible
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
}

-(void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
}


@end
