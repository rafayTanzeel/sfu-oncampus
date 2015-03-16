//
//  SFUImageMapsModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-15.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUImageMapsModel : NSObject

-(NSString*)nameOfBuildingAtIndex:(NSUInteger)i;
-(NSUInteger)numberOfBuildings;
-(NSString*)nameOfImageForBuildingAtIndex:(NSUInteger)i onFloorWithIndex:(NSUInteger)j;
-(NSUInteger)floorCountForBuldingWithIndex:(NSUInteger)i;

@end
