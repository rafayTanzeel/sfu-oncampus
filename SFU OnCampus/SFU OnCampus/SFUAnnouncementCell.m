//
//  SFUAnnouncementCell.m
//  OnCampus
//  Team fiveOfTen
//
//  Created by Kevin Grant on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUAnnouncementCell.h"

@implementation SFUAnnouncementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    [self cardSetup];
}

// Set up the aesthetics of the cell
-(void)cardSetup
{
    [self.announcementView setAlpha:1];
    self.announcementView.layer.masksToBounds = NO;
    
    // Round the corners, and give it a shadow
    self.announcementView.layer.cornerRadius = 1;
    self.announcementView.layer.shadowOffset = CGSizeMake(-.2f, .2f); 
    self.announcementView.layer.shadowRadius = 1; 
    self.announcementView.layer.shadowOpacity = 1;
    
    // Lowers the performance required to build shadows
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.announcementView.bounds];
    self.announcementView.layer.shadowPath = path.CGPath;
    
    // Set the background colour
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% I prefer choosing colors programmatically than on the storyboard
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
