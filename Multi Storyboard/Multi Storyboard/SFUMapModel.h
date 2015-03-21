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
-(MKCoordinateRegion)regionForShortCode:(NSString*)s;
-(NSString*)suggestionForPrefix:(NSString*)p;
@property BOOL shouldTrackHistory;
@end
