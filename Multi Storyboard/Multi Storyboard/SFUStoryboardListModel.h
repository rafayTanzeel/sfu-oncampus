//
//  SFUStoryboardListModel.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represents a series of storyboards on disk, and the titles and icons which identiy their corrosponding module.
 */
@interface SFUStoryboardListModel : NSObject

-(NSInteger)sizeOfArray;
/**
 Get the path name to be passesd to [UIStoryboard storyboardWithName:]
 */
-(NSString*) storyboardStringForIndex:(NSUInteger)idx;

/**
 this is what should be displayed to the user
 */
-(NSString*) titleStringForIndex:(NSUInteger)idx;
/**
 If an image exists at this path itshould be displayed nextto the title.
 */
-(NSString*) imageNameForIndex:(NSUInteger) idx;
/**
 If not null a view besides the initial view controller should be used when this storyboard is loaded
 */
-(NSString*) targetViewStringForIndex:(NSUInteger)idx;
-(void)initWithPlist:(NSString*) plist;

@end
