//
//  SFUTransitTableViewController.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//
// Changelog: https://github.com/nikhilgaba/sfu-oncampus
//
//
//
// Presently no known bugs

#import <UIKit/UIKit.h>

@interface RSSModel : UITableViewController

-(NSInteger)sizeOfArray;
-(NSString*) titleStringForIndex:(NSUInteger)idx; //Gets the title from the selected cell of RSSMainTableViewController
-(NSString*) urlStringForIndex:(NSUInteger)idx; //Gets the URL from the selected cell of RSSMainTableViewController
-(NSString*) imageNameForIndex:(NSUInteger) idx; //Gets the Image from the selected cell of RSSMainTableViewController
@property NSString* path; //gets that path to the RSS plist

@end
