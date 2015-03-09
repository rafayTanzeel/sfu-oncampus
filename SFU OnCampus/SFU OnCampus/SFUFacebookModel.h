//
//  SFUFacebookModel.h
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


///The model that populates the Facebook Controller
@interface SFUFacebookModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
@property NSString* path;

@end
