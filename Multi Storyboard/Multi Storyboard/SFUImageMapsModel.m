//
//  SFUImageMapsModel.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUImageMapsModel.h"

@implementation SFUImageMapsModel
NSArray* a;

-(SFUImageMapsModel*)init
{
    NSBundle* b = [NSBundle mainBundle]
    ;
    a = [NSArray arrayWithContentsOfFile:[b pathForResource:@"floorplans" ofType:@"plist"]];
    return self;
}

-(NSString*)nameOfBuildingAtIndex:(NSUInteger)i
{
    NSDictionary* d = [a objectAtIndex:i];
    return [d objectForKey:@"displayName"];
}

-(NSUInteger)numberOfBuildings
{
    return [a count];
}

-(NSString*)nameOfImageForBuildingAtIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j
{
    NSDictionary* d = [a objectAtIndex:i];
    NSArray* ps = [d objectForKey:@"pages"];
    return [[ps objectAtIndex:j] objectForKey:@"image"];
}
-(NSString*)nameOfFloorInBuildingWithIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j
{
    NSDictionary* d = [a objectAtIndex:i];
    NSArray* ps = [d objectForKey:@"pages"];
    return [[ps objectAtIndex:j] objectForKey:@"name"];
}


@end
