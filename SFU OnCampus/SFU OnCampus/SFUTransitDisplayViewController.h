//
//  SFUTransitDisplayViewController.h
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
@interface SFUTransitDisplayViewController :UIViewController <NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>

//sets the bus number from previous scene
@property (weak, atomic) NSIndexPath *BusPath;

//model that allows us to manipulate plist
@property (strong, nonatomic) IBOutlet SFUTransitModel *model;

//sets the loop name from previous scene
@property (strong, atomic) NSString *loopName;

//label that displays the next bus time
@property (weak, nonatomic) IBOutlet UILabel *nextBusTime;

//label that displays how much time till next bus
@property (weak, nonatomic) IBOutlet UILabel *nextBusDeltaTime;

//table view holding upcoming buses
@property (weak, nonatomic) IBOutlet UITableView *upcomingTableView;


@end
