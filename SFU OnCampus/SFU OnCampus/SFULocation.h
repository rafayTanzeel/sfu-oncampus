//
//  SFULocation.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 An abstract container used to represent a location on campus, not currently used
 */
@interface SFULocation : NSObject

@property NSString* displayName;
@property NSString* shortCode;
@property NSString* buildingCode;
@property NSString* pageName;
@property NSString* roomCode;
@property NSString* partitionNumber;
@property CGPoint pageInset;


@end
