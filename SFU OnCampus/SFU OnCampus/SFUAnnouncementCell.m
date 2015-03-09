//
//  SFUAnnouncementCell.m
//  OnCampus
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

-(void)cardSetup
{
    [self.announcementView setAlpha:1];
    self.announcementView.layer.masksToBounds = NO;
    
    // Round the corners
    self.announcementView.layer.cornerRadius = 1;
    self.announcementView.layer.shadowOffset = CGSizeMake(-.2f, .2f); //%%% this shadow will hang slightly down and to the right
    self.announcementView.layer.shadowRadius = 1; //%%% I prefer thinner, subtler shadows, but you can play with this
    self.announcementView.layer.shadowOpacity = 2; //%%% same thing with this, subtle is better for me
    
    //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.announcementView.bounds];
    self.announcementView.layer.shadowPath = path.CGPath;
    
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
