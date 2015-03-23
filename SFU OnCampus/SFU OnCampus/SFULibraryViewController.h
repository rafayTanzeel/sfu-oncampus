//
//  SFULibraryViewController.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Custom TableViewController used to display library information; open hours, 
 * current status and computer availability.
 *
 * @author Kevin Grant
 * @version 1.0
 */
@interface SFULibraryViewController : UITableViewController

/**
 * Display a web view of the SFU library catalogue mobile site upon
 * touching the library catalogue button.
 */
- (IBAction)displayLibraryCatalogue:(id)sender;

/**
 * Display a web view of the SFU library books study room mobile page
 * displays the respective book study room page of each library 
 * (Burnaby, Surrey, and Vancouver)
 */
- (IBAction)displayBookStudyRoom:(id)sender;

@end
