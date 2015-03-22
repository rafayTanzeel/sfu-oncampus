//
//  SFUMapModel.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapModel.h"

@interface SFUMapModel()
{
    @private
    NSDictionary* d;
    NSDictionary* labelToShort;
}

@end

@implementation SFUMapModel


typedef enum SFUMapModelResulutionStatus
{
   FULL,PARTIAL,NONE
}SFUMapModelResulutionStatus;

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
    labelToShort=nil;
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

-(MKCoordinateRegion)regionForString:(NSString*)s status:(SFUMapModelResulutionStatus*)status
{
    if(status != nil)
    {
        *status= NONE;
    }
    
    s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    s = [s uppercaseString];
    NSArray* a = [s componentsSeparatedByString:@"-"];
    NSString* building = [a objectAtIndex:0];
    NSString* roomPart = [a objectAtIndex:1];
    a=[roomPart componentsSeparatedByString:@"."] ;
    NSString* room = [a objectAtIndex:0];
    NSString* partition = [a objectAtIndex:1];
    
    NSMutableDictionary* d = [NSMutableDictionary new];
    
    return [self regionForBuilding:building inRoom:room andPartition:partition];
}

-(MKCoordinateRegion)regionForBuilding:(NSString*)bldg inRoom:(NSString*)room andPartition:(NSString*)part
{
    MKCoordinateRegion r;
    return r;
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
 List the applicable sfu points of interest in the given region
 \todo implement
 */
-(NSArray*)pointsOfInterestInRegion:(MKCoordinateRegion)r
{
    //todo implement, just returns an empty array.
    return [NSArray new];
}

/**
 Returns an alphabetically ordered list of SFULocation .
 */
//-(NSArray*)alphabeticalList{}

/**
 \todo implement
 */
-(NSString*)shortcodeOfClosestPointTo:(CLLocationCoordinate2D)p
{
    return @"AQ";
}

/**Todo*/
-(NSString*)suggestionForPrefix:(NSString*)p
{
    if([p hasPrefix:@"Aca"] )
    {
        return @"Academic Quadrangle";
    }
    return nil;
}

-(NSArray*)listOfDomains
{
    if(labelToShort == nil)
    {
        [self buildReverseIndex];
    }
    return [[[labelToShort keyEnumerator] allObjects] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

/**
 @note could get slow, convert to asyncoprtation if needed.
 */
-(void)buildReverseIndex
{
    //note convert
    NSEnumerator *enumerator = [d keyEnumerator];
    NSString* key;
    NSMutableDictionary* tmp= [NSMutableDictionary new];
    while((key = [enumerator nextObject]))
    {
        NSDictionary* info = [d objectForKey:key];
        [tmp setObject:key forKey:[info objectForKey:@"displayName"]];
    }
    labelToShort = tmp;
}

@end
