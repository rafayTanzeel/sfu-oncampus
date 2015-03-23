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
#import "RSSModel.h"
@interface RSSMainTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet RSSModel *model;

@end
