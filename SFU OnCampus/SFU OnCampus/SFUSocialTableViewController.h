//
//  SFUSocialTableViewController.h
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


#import "DetailViewController.h"
#import "SFUWebListModel.h"

///Holds buttons for Facebook and Twitter
@interface SFUSocialTableViewController : UITableViewController

@property (strong, nonatomic) SFUWebListModel* model;

@property (strong, nonatomic) IBOutlet NSObject *otherModel;

@property BOOL displayInApp;

@end
