//
//  SFUAnnouncementCell.h
//  OnCampus
//
//  Created by Kevin Grant on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFUAnnouncementCell : UITableViewCell

// UI View
@property (weak, nonatomic) IBOutlet UIView *announcementView;

//----------------------------------
// ANNOUNCEMENTS
//----------------------------------
@property (weak, nonatomic) IBOutlet UILabel *AnnouncementsTitle;
@property (weak, nonatomic) IBOutlet UILabel *AnnouncementsBody;

@end
