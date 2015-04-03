//
//  SFUImageMapsModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Retrieves metadata for maps that are represented using a static image, such as interiors.
 */
@interface SFUImageMapsModel : NSObject

-(NSString*)nameOfBuildingAtIndex:(NSUInteger)i;
-(NSUInteger)numberOfBuildings;
-(NSString*)nameOfImageForBuildingAtIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j;
-(NSUInteger)floorCountForBuldingWithIndex:(NSUInteger)i;
-(NSString*)nameOfFloorInBuildingWithIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j;
-(NSUInteger)numberOfFloorsForBuildingAtIndex:(NSUInteger)i;
-(NSString*)shortCodeForBuildingAtIndex:(NSUInteger)i;

-(NSUInteger)indexOfBuildingWithShortcode:(NSString*)s;
-(NSUInteger)indexOfPageWithName:(NSString*)s inBuildingAtIndex:(NSUInteger)i;

@end
