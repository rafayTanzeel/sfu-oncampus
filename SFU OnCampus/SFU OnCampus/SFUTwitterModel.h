//
//  SFUTwitterModel.h
//  OnCampus
//
//  Created by Ashwani Gaba on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUTwitterModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
-(void)initWithPlist:(NSString*) plist;
@property NSString* path;

@end
