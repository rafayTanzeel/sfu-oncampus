//
//  SFULibraryCell.h
//  Multi Storyboard
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFULibraryCell : UITableViewCell

// UI View
@property (weak, nonatomic) IBOutlet UIView *libraryView;

// Library Name
@property (weak, nonatomic) IBOutlet UILabel *libraryName;

// Library Hours
@property (weak, nonatomic) IBOutlet UILabel *hours;

// Computer Availability Label
@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;

// Location Names
@property (weak, nonatomic) IBOutlet UILabel *locationOne;
@property (weak, nonatomic) IBOutlet UILabel *locationTwo;
@property (weak, nonatomic) IBOutlet UILabel *locationThree;
@property (weak, nonatomic) IBOutlet UILabel *locationFour;
@property (weak, nonatomic) IBOutlet UILabel *locationFive;
@property (weak, nonatomic) IBOutlet UILabel *locationSix;
@property (weak, nonatomic) IBOutlet UILabel *locationSeven;
@property (weak, nonatomic) IBOutlet UILabel *locationEight;

// Computers Available
@property (weak, nonatomic) IBOutlet UILabel *availableOne;
@property (weak, nonatomic) IBOutlet UILabel *availableTwo;
@property (weak, nonatomic) IBOutlet UILabel *availableThree;
@property (weak, nonatomic) IBOutlet UILabel *availableFour;
@property (weak, nonatomic) IBOutlet UILabel *availableFive;
@property (weak, nonatomic) IBOutlet UILabel *availableSix;
@property (weak, nonatomic) IBOutlet UILabel *availableSeven;
@property (weak, nonatomic) IBOutlet UILabel *availableEight;

// Progress Bars
@property (weak, nonatomic) IBOutlet UIProgressView *progressOne;
@property (weak, nonatomic) IBOutlet UIProgressView *progressTwo;
@property (weak, nonatomic) IBOutlet UIProgressView *progressThree;
@property (weak, nonatomic) IBOutlet UIProgressView *progressFour;
@property (weak, nonatomic) IBOutlet UIProgressView *progressFive;
@property (weak, nonatomic) IBOutlet UIProgressView *progressSix;
@property (weak, nonatomic) IBOutlet UIProgressView *progressSeven;
@property (weak, nonatomic) IBOutlet UIProgressView *progressEight;

// Computers in use
@property (weak, nonatomic) IBOutlet UILabel *usedOne;
@property (weak, nonatomic) IBOutlet UILabel *usedTwo;
@property (weak, nonatomic) IBOutlet UILabel *usedThree;
@property (weak, nonatomic) IBOutlet UILabel *usedFour;
@property (weak, nonatomic) IBOutlet UILabel *usedFive;
@property (weak, nonatomic) IBOutlet UILabel *usedSix;
@property (weak, nonatomic) IBOutlet UILabel *usedSeven;
@property (weak, nonatomic) IBOutlet UILabel *usedEight;



@end
