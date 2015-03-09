//
//  SFUWebListController.h
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
#import "SFUWebListModel.h"

///Populates the Student Services Tableview with various goSFU, Canvas, Connect, and talkSFU
@interface SFUWebListController : UITableViewController

@property BOOL displayInApp;
@property IBOutlet SFUWebListModel* model;

///Do not use currently
-(void)setModel:(SFUWebListModel*)model;
@end
