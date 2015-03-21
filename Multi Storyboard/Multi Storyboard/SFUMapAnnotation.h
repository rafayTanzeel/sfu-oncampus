//
//  SFUMapAnnotation.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@import CoreLocation;
@interface SFUMapAnnotation : NSObject <MKAnnotation>

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic) BOOL isDestination;

@end
