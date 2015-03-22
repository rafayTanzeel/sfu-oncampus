//
//  SFUTransitModel.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//
// Changelog: https://github.com/nikhilgaba/sfu-oncampus
//
//
//
// Presently no known bugs

#import <Foundation/Foundation.h>
//model that holds plist for each loop
@interface SFUTransitModel : NSObject


//size of plist
-(NSInteger)sizeOfArray;

//title for bus
-(NSString*) titleStringForIndex:(NSUInteger)idx;

//stop number for bus
-(NSString*) stopStringForIndex:(NSUInteger)idx;

//route number for bus
-(NSString*) routeStringForIndex:(NSUInteger) idx;

//initializer
-(SFUTransitModel*)initWithPlist:(NSString*) plistName;

@property NSString* path;


@end
