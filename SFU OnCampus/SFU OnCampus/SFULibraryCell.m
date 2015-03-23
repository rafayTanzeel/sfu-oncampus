//
//  SFULibraryCell.m
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULibraryCell.h"

@implementation SFULibraryCell

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

// Sets up the aesthetics of the cell
-(void)cardSetup
{
    [self.libraryView setAlpha:1];
    self.libraryView.layer.masksToBounds = NO;
    
    // Round the corners, and give it a shadow
    self.libraryView.layer.cornerRadius = 1;
    self.libraryView.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    self.libraryView.layer.shadowRadius = 1;
    self.libraryView.layer.shadowOpacity = 1;
    
    // Lowers the performance required to build shadows.
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.libraryView.bounds];
    self.libraryView.layer.shadowPath = path.CGPath;
    
    // Set the background colour
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
}

- (void)updateComputerAvaiability:(UILabel*) available used:(UILabel*) inUse locationLabel:(UILabel*) location locationName: (NSString*) name locationValue:(NSString*) value progressBar:(UIProgressView*) progressView withDictionary:(NSDictionary*) d
{
    // Set the location name
    location.text = name;
    
    // Get computers available
    NSDictionary *locationKeys = [d valueForKey:@"locations"];
    NSNumber *numberAvailable = [locationKeys valueForKey:value];
    
    // Get totals
    NSDictionary *totals = [d valueForKey:@"totals"];
    NSNumber *numberTotal = [totals valueForKey:value];
    
    // Get number in use
    NSInteger integerInUse = [numberTotal integerValue] - [numberAvailable integerValue];
    
    // store number available as int value
    NSInteger integerAvailable = [numberAvailable intValue];

    // Set computers available
    available.text = [NSString stringWithFormat:@"%ld", (long)integerAvailable];
    inUse.text = [NSString stringWithFormat:@"%ld", (long)integerInUse];
    
    // Calculate progress
    float progress = [numberAvailable floatValue] / [numberTotal floatValue];

    //-------------------------------------------------------------------
    // CALCULATE PROGRESS BAR COLOUR
    // the progress bar colour shifts from red to green.
    // the higher percentage the progress bar is at, the greener it is.
    //-------------------------------------------------------------------

    const float intensityShift =0.9;
    const float redShift = .05;     // cause red to occur faster, so it's not just orange until it's so small it isn't visible.
    
    // Cause progress to make the bars converge on yellow
    float r = 2*(1.0- progress +redShift);
    float g = 2.0*(progress -redShift);
    
    
    // The blue portion makes up 1/3 of the color space
    float b = 0;
    
    // Make the colors not so bright(especially good for yellow
    r*=intensityShift;
    g*=intensityShift;
    
    
    // Actually set the color
    UIColor* c  = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
    [progressView setProgressTintColor: c];
    
    // Set progress
    [progressView setProgress:progress];
}

-(void)updateLibraryStatusLabels:(UILabel*) hoursLabel status:(UILabel*) statusLabel withDictionary:(NSDictionary*) d
{
    // Library Hours
    NSString *open = [d valueForKey:@"open_time"];
    NSString *close = [d valueForKey:@"close_time"];
    NSString *hours = [NSString stringWithFormat:@"%@ - %@", open, close];
    hoursLabel.text = hours;
    
    // Library Status (open or closed)
    NSNumber *status = [d valueForKey:@"in_range"];

    // Open
    if ([status integerValue] == 1) {
        statusLabel.text = @"OPEN";
        statusLabel.textColor = [UIColor colorWithRed:(0/255.f) green:(150/255.f) blue:(0/255.f) alpha:1.0f];   // Set to Green
    }
    // Closed
    else {
        statusLabel.text = @"CLOSED";
        statusLabel.textColor = [UIColor colorWithRed:(226/255.f) green:(8/255.f) blue:(19/255.f) alpha:1.0f];  // Set to Red
    }
}

-(void)emptyComputerLabels:(UILabel*) available used:(UILabel*) inUse locationLabel:(UILabel*) location progressBar:(UIProgressView*) progressView
{
    available.text = @"";
    inUse.text = @"";
    location.text = @"";

    [progressView setProgressTintColor:[UIColor clearColor]];
    [progressView setTrackTintColor:[UIColor clearColor]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setURL:(NSString *)URL
{
    self.bookRoomButton.URL = URL;
}

@end
