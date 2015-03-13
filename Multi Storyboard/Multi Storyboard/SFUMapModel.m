//
//  SFUMapModel.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapModel.h"

@implementation SFUMapModel
NSDictionary* d;

-(SFUMapModel*)init
{
    NSBundle* b =[NSBundle mainBundle];
    NSString* path = [b pathForResource:@"buildingData" ofType:@"plist"];
    d= [NSDictionary dictionaryWithContentsOfFile: path];
    d= [d objectForKey:@"buildings"];
    if(d == nil)
    {
        NSLog(@"Not file");
    }
    return self;
}

-(NSString*)displayNameForShortCode:(NSString*)s
{
    NSDictionary* b= [d objectForKey:s];
    NSString* name = [b objectForKey:@"displayName"];
    if(name)
    {
        return name;
    }else
    {
        return @"Untitled, please report to SFU";
    }
    
}

-(MKCoordinateRegion)regionForShortCode:(NSString*)s
{
    //make case insensative
    s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    s = [s uppercaseString];
    
    MKCoordinateRegion r;
    NSDictionary* b= [d objectForKey:s];
    if(b == nil)
    {
        @throw ([NSException exceptionWithName:@"IllegalRegionException" reason:@"That region is not in the database" userInfo:nil]);
    }
    NSDictionary* span = [b objectForKey:@"span"];
    NSDictionary* centre = [b objectForKey:@"centre"];
    
    r.center.latitude = [[centre objectForKey:@"y"]floatValue];
    r.center.longitude = [[centre objectForKey:@"x"]floatValue];
    
    r.span.latitudeDelta = [[span objectForKey:@"y"]floatValue];
    r.span.longitudeDelta = [[span objectForKey:@"x"]floatValue];
    return r;
    
}

/**
 Returns an alphabetically ordered list of SFULocation .
 */
//-(NSArray*)alphabeticalList{}

@end
