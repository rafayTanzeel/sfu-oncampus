//
//  SFULibraryCell.m
//  Multi Storyboard
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
    NSString *numberAvailable = [locationKeys valueForKey:value];
    NSDictionary *totals = [d valueForKey:@"totals"];
    NSString *numberTotal = [totals valueForKey:value];
    
    NSInteger numberInUse = [numberTotal integerValue] - [numberAvailable integerValue];
    
    // Set computers available
    available.text = numberAvailable;
    inUse.text = [NSString stringWithFormat:@"%ld", (long)numberInUse];
    
    // Calulate progress
    float progress;

    if ([numberAvailable integerValue] != 0) {
        progress = [numberAvailable floatValue] / [numberTotal floatValue];
    }
    else {
        progress = 0.0;
    }
    
    
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
    if ([status integerValue] == 1) {
        statusLabel.text = @"OPEN";
        statusLabel.textColor = [UIColor colorWithRed:(0/255.f) green:(150/255.f) blue:(0/255.f) alpha:1.0f];
    }
    else {
        statusLabel.text = @"CLOSED";
        statusLabel.textColor = [UIColor colorWithRed:(226/255.f) green:(8/255.f) blue:(19/255.f) alpha:1.0f];
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

@end
