//
//  SFUMapModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFULocation.h"
@import MapKit;
@import CoreLocation;

/**
 Stores necessary information regarding locations descriptions , names and shortcodes of buildings and in the future rooms.
 */
@interface SFUMapModel : NSObject

typedef enum SFUMapModelResolutionStatus
{
    FULL,PARTIAL,NONE
}SFUMapModelResolutionStatus;

-(MKCoordinateRegion)regionForShortCode:(NSString*)s;
-(NSString*)suggestionForPrefix:(NSString*)p;
-(NSArray*)listOfDomains;
-(NSString*)shortCodeForDisplayName:(NSString*)s;
-(NSString*)displayNameForShortCode:(NSString*)s;

-(SFULocation*)locationForShortcode:(NSString*)s;

-(MKCoordinateRegion)regionForString:(NSString*)s status:(SFUMapModelResolutionStatus*)status;
@property BOOL shouldTrackHistory;


@end
