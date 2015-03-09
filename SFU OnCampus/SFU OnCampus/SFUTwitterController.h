//
//  SFUTwitterController.h
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
#import "SFUTwitterModel.h"


///Populates the Twitter Tableview with various SFU Twitter Feeds
@interface SFUTwitterController : UITableViewController

@property (strong, nonatomic) IBOutlet SFUTwitterModel *model;



@property NSString* path;

@end
