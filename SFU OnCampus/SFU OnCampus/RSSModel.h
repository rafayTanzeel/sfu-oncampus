//
//  RSSModel.h
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-03-16.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSModel : UITableViewController

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) urlStringForIndex:(NSUInteger)idx;
-(NSString*) imageNameForIndex:(NSUInteger) idx;
@property NSString* path;

@end
