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
@property(nonatomic,readonly,copy) NSString* title;
@property(nonatomic,readonly,copy) NSString* subtitle;
@property(nonatomic,readonly,copy) NSString* shortcode;

-(SFUMapAnnotation*)initWithTitle:(NSString*)t subtitle:(NSString*)sub shortcode:(NSString*)aShortcode;

@end
