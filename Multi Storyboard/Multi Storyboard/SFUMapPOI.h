//
//  SFUMapPOI.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SFUMapPOI : NSObject
 typedef enum SFUPOIType
{
    SFUPOITypeFood=0,
    SFUPOITypeComputer=0
    
}SFUPOIType;
@property MKCoordinateRegion region;
@property NSString* name;
@end
