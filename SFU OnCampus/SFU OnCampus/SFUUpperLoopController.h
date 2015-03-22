//
//  SFUUpperLoopController.h
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
#import "SFUTransitModel.h"
#import "SFUTransitDisplayViewController.h"
//loads the indidual busses for each loop
@interface SFUUpperLoopController : UITableViewController

@property BOOL displayInApp;

//refers to the model that operates on plist
@property IBOutlet SFUTransitModel* model;

//name of plist set by previous scene 
@property (strong, atomic) NSString *loopName;




@end
