//
//  SFUFacebookController.h
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
#import "SFUFacebookModel.h"

/// Populates the Facebook Tableview with various SFU Facebook Feeds
@interface SFUFacebookController : UITableViewController

@property (strong, nonatomic) IBOutlet SFUFacebookModel *model;


@property BOOL displayInApp;

@end
