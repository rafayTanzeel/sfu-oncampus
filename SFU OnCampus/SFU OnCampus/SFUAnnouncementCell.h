//
//  SFUAnnouncementCell.h
//  OnCampus
//  Team fiveOfTen
//
//  Created by Kevin Grant on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Custom UITableViewCell Class that is used to display the weather announcements for the SFUWeatherViewController Class.
 *
 * @author Kevin Grant
 * @version 1.0
 */
@interface SFUAnnouncementCell : UITableViewCell

// UI View
@property (weak, nonatomic) IBOutlet UIView *announcementView;

//----------------------------------
// ANNOUNCEMENTS
//----------------------------------
@property (weak, nonatomic) IBOutlet UILabel *AnnouncementsTitle;
@property (weak, nonatomic) IBOutlet UILabel *AnnouncementsBody;

@end
