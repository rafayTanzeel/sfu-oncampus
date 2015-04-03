//
//  SFUImageMapsModel.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUImageMapsModel.h"

@interface SFUImageMapsModel()
{
    @private
    NSArray* a;
}

@end

@implementation SFUImageMapsModel


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


-(NSUInteger)numberOfFloorsForBuildingAtIndex:(NSUInteger)i
{
    return [[[a objectAtIndex:i] objectForKey:@"pages"]count];
}

-(NSString*)nameOfImageForBuildingAtIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j
{
    @try{
    NSDictionary* d = (NSDictionary*)[a objectAtIndex:i];
    NSArray* ps = [d objectForKey:@"pages"];
    NSDictionary* p = [ps objectAtIndex:j];
    if(p == nil)return nil;
    return [@"maps/" stringByAppendingString:[p objectForKey:@"image"]];
    }@catch(NSException* e)
    {
        return nil;
    }
}
-(NSString*)nameOfFloorInBuildingWithIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j
{
    NSDictionary* d = [a objectAtIndex:i];
    NSArray* ps = [d objectForKey:@"pages"];
    return [[ps objectAtIndex:j] objectForKey:@"name"];
}
-(NSUInteger)floorCountForBuldingWithIndex:(NSUInteger)i
{
    NSDictionary* d = [a objectAtIndex:i];
    NSArray* ps = [d objectForKey:@"pages"];
    return [ps count];
}

-(NSString*)shortCodeForBuildingAtIndex:(NSUInteger)i;
{
    NSDictionary* d = (NSDictionary*)[a objectAtIndex:i];
    return [d objectForKey:@"shortcode"];
}

-(NSUInteger)indexOfBuildingWithShortcode:(NSString*)s
{
    return [a indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
            {
                NSDictionary *d = (NSDictionary*)obj;
                if([[d objectForKey:@"shortcode" ] isEqualToString:s])
                {
                    return YES;
                }
                return NO;
            }];
}
-(NSUInteger)indexOfPageWithName:(NSString*)s inBuildingAtIndex:(NSUInteger)i
{
    NSArray* ps = [[a objectAtIndex:i]objectForKey:@"pages"];
    return [ps indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
    {
        NSDictionary *d = (NSDictionary*)obj;
        if([[d objectForKey:@"name" ] isEqualToString:s])
           {
               return YES;
           }
           return NO;
    }];
    return 0;

}

-(CGPoint) relativeLocationOfRoom:(NSString*)roomName onFloorAtIndex: (NSUInteger)floorIndex inBuildingAtIndex: (NSUInteger)buildingIndex
{
    NSDictionary* p = [[[a objectAtIndex:buildingIndex] objectForKey:@"pages"] objectAtIndex:floorIndex];
    NSString* point = [[p objectForKey:@"rooms"]objectForKey:roomName];
    return CGPointFromString(point);
}


@end
