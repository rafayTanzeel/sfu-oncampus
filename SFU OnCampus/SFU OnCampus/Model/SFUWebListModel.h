//
//  SFUWebListModel.h
//  OnCampus
//
//  Created by Abram Wiebe on 2015-02-25.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUWebListModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;

@property NSString* path;



@end
