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

// Empty the computer labels
-(void)emptyComputerLabels:(UILabel*) available used:(UILabel*) inUse locationLabel:(UILabel*) location progressBar:(UIProgressView*) progressView
{
    available.text = @"";
    inUse.text = @"";
    location.text = @"";

    [progressView setProgressTintColor:[UIColor clearColor]];
    [progressView setTrackTintColor:[UIColor clearColor]];

}

// Update the computer labels for SFU Burnaby
- (void)updateBurnabyComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers
{
    // 6th floor
    [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"6th floor" locationValue:@"ben-6-pc" progressBar:cell.progressOne withDictionary:computers];
    
    // 5th floor
    [cell updateComputerAvaiability:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo locationName:@"5th floor" locationValue:@"ben-5-pc" progressBar:cell.progressTwo withDictionary:computers];
    
    // 4th floor
    [cell updateComputerAvaiability:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree locationName:@"4th floor" locationValue:@"ben-4-4009-pc" progressBar:cell.progressThree withDictionary:computers];
    
    // 3rd floor east PCs
    [cell updateComputerAvaiability:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour locationName:@"3rd floor East - PCs" locationValue:@"ben-3-e-pc" progressBar:cell.progressFour withDictionary:computers];
    
    // 3rd floor east Macs
    [cell updateComputerAvaiability:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive locationName:@"3rd floor East - Macs" locationValue:@"ben-3-e-mac" progressBar:cell.progressFive withDictionary:computers];
    
    // 3rd floor west
    [cell updateComputerAvaiability:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix locationName:@"3rd floor West" locationValue:@"ben-3-w-pc" progressBar:cell.progressSix withDictionary:computers];
    
    // 2nd floor
    [cell updateComputerAvaiability:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven locationName:@"2nd floor" locationValue:@"ben-2-2105-pc" progressBar:cell.progressSeven withDictionary:computers];
    
    // Laptops
    [cell updateComputerAvaiability:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight locationName:@"Laptops" locationValue:@"ben-checkout-laptops" progressBar:cell.progressEight withDictionary:computers];
}

// Update computer labels for SFU Surrey library
- (void)updateSurreyComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers
{
    // PCs
    [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"Library PCs" locationValue:@"surrey-lib" progressBar:cell.progressOne withDictionary:computers];
    
    // Macs
    [cell updateComputerAvaiability:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo locationName:@"Library Macs" locationValue:@"surrey-lib-mac" progressBar:cell.progressTwo withDictionary:computers];
    
    // Empty the rest of the values
    [cell emptyComputerLabels:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree progressBar:cell.progressThree];
    
    [cell emptyComputerLabels:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour progressBar:cell.progressFour];
    
    [cell emptyComputerLabels:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive progressBar:cell.progressFive];
    
    [cell emptyComputerLabels:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix progressBar:cell.progressSix];
    
    [cell emptyComputerLabels:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven progressBar:cell.progressSeven];
    
    [cell emptyComputerLabels:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight progressBar:cell.progressEight];
}

// Update computer labels for SFU Vancouver library
- (void) updateVancouverComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers
{
    [cell updateComputerAvaiability:cell.availableOne used:cell.usedOne locationLabel:cell.locationOne locationName:@"Library Computers" locationValue:@"bel-pc" progressBar:cell.progressOne withDictionary:computers];
    
    // Empty the rest of the values
    [cell emptyComputerLabels:cell.availableTwo used:cell.usedTwo locationLabel:cell.locationTwo progressBar:cell.progressTwo];
    
    [cell emptyComputerLabels:cell.availableThree used:cell.usedThree locationLabel:cell.locationThree progressBar:cell.progressThree];
    
    [cell emptyComputerLabels:cell.availableFour used:cell.usedFour locationLabel:cell.locationFour progressBar:cell.progressFour];
    
    [cell emptyComputerLabels:cell.availableFive used:cell.usedFive locationLabel:cell.locationFive progressBar:cell.progressFive];
    
    [cell emptyComputerLabels:cell.availableSix used:cell.usedSix locationLabel:cell.locationSix progressBar:cell.progressSix];
    
    [cell emptyComputerLabels:cell.availableSeven used:cell.usedSeven locationLabel:cell.locationSeven progressBar:cell.progressSeven];
    
    [cell emptyComputerLabels:cell.availableEight used:cell.usedEight locationLabel:cell.locationEight progressBar:cell.progressEight];
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
