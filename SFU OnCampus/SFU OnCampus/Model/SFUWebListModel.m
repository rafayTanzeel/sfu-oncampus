//
//  SFUWebListModel.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-02-25.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUWebListModel.h"

@implementation SFUWebListModel
NSArray* array;
-(SFUWebListModel*)init
{
    //This is a user defined path in interface builder
    //Take a look under the identity panel to see it.
    @try{
        NSString* path=[[NSBundle mainBundle]pathForResource:@"SFUStudentServiceURLs" ofType:@"plist"];
        array = [NSArray arrayWithContentsOfFile:path];
    }
    @catch (NSException* e)
    {
        
    }
    
    
    return self;
}


-(SFUWebListModel*)initWithPlist:(NSString*) plist
{
    //This is a user defined path in interface builder
    //Take a look under the identity panel to see it.
    @try{
        NSString* path=[[NSBundle mainBundle]pathForResource:plist ofType:@"plist"];
        array = [NSArray arrayWithContentsOfFile:path];
    }
    @catch (NSException* e)
    {
        
    }
    
    
    return self;
}


-(NSString*) urlStringForIndex:(NSUInteger)idx
{
    NSDictionary* d = [array objectAtIndex:idx];
    return [d objectForKey:@"url"];
}
-(NSString*) titleStringForIndex:(NSUInteger)idx
{
    NSDictionary* d = [array objectAtIndex:idx];
    return [d objectForKey:@"title"];
}

-(NSInteger)sizeOfArray
{
    return [array count];
}

-(NSString*) imageNameForIndex: (NSUInteger) idx
{
    NSDictionary* d = [array objectAtIndex:idx];
    return [d objectForKey:@"image"];
}
@end
