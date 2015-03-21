//
//  SFUStoryboardListModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUStoryboardListModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) storyboardStringForIndex:(NSUInteger)idx;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
-(NSString*) targetViewStringForIndex:(NSUInteger)idx;

-(NSString*)selectorForIndex:(NSUInteger)idx;
-(id)parameterForIndex:(NSUInteger)idx;

-(void)initWithPlist:(NSString*) plist;

@end
