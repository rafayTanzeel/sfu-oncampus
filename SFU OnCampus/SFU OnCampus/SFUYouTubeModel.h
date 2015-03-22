//
//  SFUYouTubeModel.h
//  OnCampus
//
//  Created by Sunny Chowdhury on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUYouTubeModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
-(void)sortOnKey: (NSString*)sortKey;
@property NSString* path;



@end
