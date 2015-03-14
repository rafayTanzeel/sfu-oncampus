//
//  SFUTransitModel.h
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUTransitModel : NSObject

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx;
-(NSString*) stopStringForIndex:(NSUInteger)idx;
-(NSString*) routeStringForIndex:(NSUInteger) idx;
@property NSString* path;


@end
