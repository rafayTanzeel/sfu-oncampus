//
//  MasterViewController.h
//  SFU OnCampus
//
//  Created by Abram Wiebe on 2015-02-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @deprecated Replaced By SFUStoryboardList
 */
///This was provided in the template, it is the main menu.
@class DetailViewController;

@interface MasterViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *copyrighLabel;

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

