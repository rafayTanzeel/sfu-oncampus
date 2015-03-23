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
#import "SFUYouTubeModel.h"
@interface SFUYouTubeController : UITableViewController

@property (strong, nonatomic) IBOutlet SFUYouTubeModel *model; //on=bject that extract data from youtube plist

@end
