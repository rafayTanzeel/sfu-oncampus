//
//  SFULocation.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFULocation : NSObject

@property NSString* displayName;
@property NSString* shortCode;
@property NSString* buildingCode;
@property NSString* roomCode;
@property NSString* partitionNumber;

-(SFULocation*)initWithShortcodeString:(NSString*)shortcode;

@end
