//
//  SFUTwitterModel.h
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


//The model that populates our Twitter Controller
@interface SFUTwitterModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
-(void)sortOnKey: (NSString*)sortKey;
@property NSString* path;

@end
