//
//  SFUWeatherViewController.h
//  OnCampus
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Custom TableViewController used to display weather, and to display announcements from http://www.sfu.ca/security/sfuroadconditions/
 */
@interface SFUWeatherViewController : UITableViewController
- (IBAction)getCurrentWeather:(id)sender;

@end
