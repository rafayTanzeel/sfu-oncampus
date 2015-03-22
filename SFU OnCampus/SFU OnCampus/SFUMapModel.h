//
//  SFUMapModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@import CoreLocation;
@interface SFUMapModel : NSObject

typedef enum SFUMapModelResolutionStatus
{
    FULL,PARTIAL,NONE
}SFUMapModelResolutionStatus;

-(MKCoordinateRegion)regionForShortCode:(NSString*)s;
-(NSString*)suggestionForPrefix:(NSString*)p;
-(NSArray*)listOfDomains;
-(NSString*)shortCodeForDisplayName:(NSString*)s;
-(MKCoordinateRegion)regionForString:(NSString*)s status:(SFUMapModelResolutionStatus*)status;
@property BOOL shouldTrackHistory;


@end
