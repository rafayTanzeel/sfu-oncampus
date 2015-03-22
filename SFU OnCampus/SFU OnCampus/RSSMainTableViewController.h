//
//  RSSMainTableViewController.h
//  OnCampus
//
//  Created by Rafay Tanzeel on 2015-03-16.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSModel.h"
@interface RSSMainTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet RSSModel *model;

@end
