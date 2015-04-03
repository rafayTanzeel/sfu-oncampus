//
//  SFULibraryCell.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//
//  Created by Kevin Grant on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUBookRoomButton.h"

/**
 * Custom UITableViewCell Class that is used to display library information for the SFULibraryViewController Class.
 *
 * @author Kevin Grant
 * @version 1.0
 */
@interface SFULibraryCell : UITableViewCell

/**
 * Updates information for the computer availability for each location of each library
 * Uses SFU Library API to determine availability.
 *
 * @param available		label representing the number of computers available for a certain location
 * @param inUse			label representing the number of computers in use for a certain location
 * @param location 		label representing the location's name to be set
 * @param name 			name of the location to be set as the location's name
 * @param value 		the name for the location as returned by the API
 * @param progressView	the progress bar representing the number of computers available
 * @param d 			dictionary returned by API containing all the computer information
 */
- (void)updateComputerAvaiability:(UILabel*) available used:(UILabel*) inUse locationLabel:(UILabel*) location locationName: (NSString*) name locationValue:(NSString*) value progressBar:(UIProgressView*) progressView withDictionary:(NSDictionary*) d;

/**
 * Updates the library hours label and the library status label, and sets the status label
 * to the correct colour - red if closed, green if open. Uses the "in_range" key returned
 * by the API to determine if the library is open.
 *
 * @param hours         label representing the hours the library is open
 * @param status		label representing the open / closed status of the library
 * @param d 			dictionary returned by API containing all hours information
 */
-(void)updateLibraryStatusLabels:(UILabel*) hours status:(UILabel*) status withDictionary:(NSDictionary*) d;

/**
 * Sets any text that is not needed for a library to empty and sets the progress bars to a clear colour.
 * The SFULibraryCell was built to have enough information for all locations of SFU Burnaby; SFU Surrey and SFU Vancouver
 * do not require as much information. So to hide these excess labels, they are made invisibile.
 *
 * @param available		label representing the number of computers available for a certain location
 * @param inUse			label representing the number of computers in use for a certain location
 * @param location 		label representing the location's name to be set
 * @param progressView	the progress bar representing the number of computers available
 */
-(void)emptyComputerLabels:(UILabel*) available used:(UILabel*) inUse locationLabel:(UILabel*) location progressBar:(UIProgressView*) progressView;

/**
 * updates the computer labels for all locations at SFU Burnaby library
 * Calls {@link #updateComputerAvailability() updateComputerAvailability} the appropriate number of times
 * on the appropriate rooms.
 *
 * @param cell          cell containing all computer labels
 * @param computers     dictionary containing all computer data
 */
- (void)updateBurnabyComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers;

/**
 * updates the computer labels for all locations at SFU Surrey library
 * Calls {@link #updateComputerAvailability() updateComputerAvailability} the appropriate number of times
 * on the appropriate rooms.
 * Calls {@link #emptyComputerLabels() emptyComputerLabels} the appropriate number of times
 * on the appropriate rooms.
 *
 * @param cell          cell containing all computer labels
 * @param computers     dictionary containing all computer data
 */
- (void)updateSurreyComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers;

/**
 * updates the computer labels for all locations at SFU Vancouver library
 * Calls {@link #updateComputerAvailability() updateComputerAvailability} the appropriate number of times
 * on the appropriate rooms.
 * Calls {@link #emptyComputerLabels() emptyComputerLabels} the appropriate number of times
 * on the appropriate rooms.
 *
 * @param cell          cell containing all computer labels
 * @param computers     dictionary containing all computer data
 */
- (void) updateVancouverComputerLabels:(SFULibraryCell*) cell withDictionary:(NSDictionary*) computers;

// UI View
@property (weak, nonatomic) IBOutlet UIView *libraryView;

// Library Name
@property (weak, nonatomic) IBOutlet UILabel *libraryName;

// Library Hours
@property (weak, nonatomic) IBOutlet UILabel *hours;

// Computer Availability Labels
@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *available;

// Open or closed
@property (weak, nonatomic) IBOutlet UILabel *libraryStatus;

// Location Names
@property (weak, nonatomic) IBOutlet UILabel *locationOne;
@property (weak, nonatomic) IBOutlet UILabel *locationTwo;
@property (weak, nonatomic) IBOutlet UILabel *locationThree;
@property (weak, nonatomic) IBOutlet UILabel *locationFour;
@property (weak, nonatomic) IBOutlet UILabel *locationFive;
@property (weak, nonatomic) IBOutlet UILabel *locationSix;
@property (weak, nonatomic) IBOutlet UILabel *locationSeven;
@property (weak, nonatomic) IBOutlet UILabel *locationEight;

// Computers Available at each location
@property (weak, nonatomic) IBOutlet UILabel *availableOne;
@property (weak, nonatomic) IBOutlet UILabel *availableTwo;
@property (weak, nonatomic) IBOutlet UILabel *availableThree;
@property (weak, nonatomic) IBOutlet UILabel *availableFour;
@property (weak, nonatomic) IBOutlet UILabel *availableFive;
@property (weak, nonatomic) IBOutlet UILabel *availableSix;
@property (weak, nonatomic) IBOutlet UILabel *availableSeven;
@property (weak, nonatomic) IBOutlet UILabel *availableEight;

// Progress Bars for each location
@property (weak, nonatomic) IBOutlet UIProgressView *progressOne;
@property (weak, nonatomic) IBOutlet UIProgressView *progressTwo;
@property (weak, nonatomic) IBOutlet UIProgressView *progressThree;
@property (weak, nonatomic) IBOutlet UIProgressView *progressFour;
@property (weak, nonatomic) IBOutlet UIProgressView *progressFive;
@property (weak, nonatomic) IBOutlet UIProgressView *progressSix;
@property (weak, nonatomic) IBOutlet UIProgressView *progressSeven;
@property (weak, nonatomic) IBOutlet UIProgressView *progressEight;

// Computers in use at each location
@property (weak, nonatomic) IBOutlet UILabel *usedOne;
@property (weak, nonatomic) IBOutlet UILabel *usedTwo;
@property (weak, nonatomic) IBOutlet UILabel *usedThree;
@property (weak, nonatomic) IBOutlet UILabel *usedFour;
@property (weak, nonatomic) IBOutlet UILabel *usedFive;
@property (weak, nonatomic) IBOutlet UILabel *usedSix;
@property (weak, nonatomic) IBOutlet UILabel *usedSeven;
@property (weak, nonatomic) IBOutlet UILabel *usedEight;
@property (weak, nonatomic) IBOutlet SFUBookRoomButton *bookRoomButton;

// URL for book study room for each library
@property (nonatomic) NSString *URL;

@end
