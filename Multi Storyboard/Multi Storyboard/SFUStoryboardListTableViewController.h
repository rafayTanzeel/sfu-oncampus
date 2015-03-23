//
//  SFUStoryboardListTableViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This table view controller displays a list of items representing storyboard files.
 Selecting an item will push the inital view controller of the represented object onto the navigation stack.
 */
@interface SFUStoryboardListTableViewController : UITableViewController
@property NSString* targetViewIdentifier;
@end
