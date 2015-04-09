//
//  SFUWeatherViewController.m
//  OnCampus
//	Team fiveOfTen
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//

#import "SFUWeatherViewController.h"
#import "SFUCardCell.h"
#import "SFUAnnouncementCell.h"
#import "SFUWebListModel.h"
#import "SFUWebListController.h"

// HTML Parsing
#import "TFHpple.h"

@interface SFUWeatherViewController ()
{
    // Global dictionary and array used for storing JSON data
    NSMutableDictionary *currentObservation;
    NSArray *forecastDay;
    
    // Array for the announcement
    NSArray *announcementArray;
}

@end

@implementation SFUWeatherViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark get weather data

/**
 * Gets the current weather data from the Wunderground Weather API.
 * If it cannot retrieve any data, a pop up is displayed to the user
 * informing them of the error.
 */
-(IBAction)getCurrentWeather:(id)sender {
    
    // Prepare the URL that we'll get the weather info data from.
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/3ff62c9b4941d736/conditions/q/Canada/Burnaby.json"];
    
    //Get URL page into NSData Object
    NSData *currentWeatherData =nil;
    
    @try {
        currentWeatherData= [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }

    if(currentWeatherData == nil) {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Weather cannot be displayed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(currentWeatherData != nil) {
        error = nil;
    }
    NSMutableDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        // store the data into the global currentObservation dictionary
        currentObservation = [currentDictionary objectForKey:@"current_observation"];
    }
}


/**
 * Gets the five day forecast weather data from the Wunderground Weather API.
 * If it cannot retrieve any data, a pop up is displayed to the user
 * informing them of the error.
 */
-(IBAction)getForecastWeather:(id)sender {
    
    // Prepare the URL that we'll get the country info data from.
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/3ff62c9b4941d736/forecast10day/q/Canada/Burnaby.json"];
   
    //Get URL page into NSData Object
    NSData *forecastWeatherData = nil;
    
    @try {
        forecastWeatherData = [NSData dataWithContentsOfURL:url];
    }
    @catch (NSException *exception) {
        
    }

    //Read JSON and convert to object   
    NSMutableDictionary *simpleForecast;
    
    NSError *error;
    if(forecastWeatherData != nil) {
        error = nil;
    }
    else {
        return;
    }
    
    NSMutableDictionary *forecastDictionary = [NSJSONSerialization JSONObjectWithData:forecastWeatherData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        simpleForecast = [[forecastDictionary objectForKey:@"forecast"] objectForKey:@"simpleforecast"];
    }

	// Store the data in the forecastDay global array
    forecastDay = [simpleForecast objectForKey:@"forecastday"];
}

/**
 * Get the road conditions data returned by the SFU Road Report API
 */
-(IBAction)getRoadConditionsData:(id)sender {
    
    // Prepare the URL
    NSURL *url = [NSURL URLWithString:@"http://www.sfu.ca/security/sfuroadconditions/api/2/current"];
    
    //Get URL page into NSData Object
    NSData *roadConditionsData = [NSData dataWithContentsOfURL:url];
    
    //Read JSON and convert to object
    NSError *error;
    
    if(roadConditionsData != nil) {
        error = nil;
    }
    else {
        return;
    }
    
    // Store the data in dictionary
    NSMutableDictionary *roadConditionsDictionary = [NSJSONSerialization JSONObjectWithData:roadConditionsData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSLog(@"%@", roadConditionsDictionary);
        NSString *announcements = [NSString stringWithFormat:@"%@", [roadConditionsDictionary valueForKey:@"announcements"]];
        
        // Remove the HTML formatting characters from the string
        announcements = [self removeHtmlTagsFromString:announcements];
        
        // Split string via the \n character and store each component in global array
        announcementArray = [announcements componentsSeparatedByString:@"\\n"];
    }
}

/**
 * Remove the html tags and other extra data from string returned by SFU Road Report API
 */
- (NSString*)removeHtmlTagsFromString:(NSString*) string
{
    // Removes occurences of '<xxxx>'
    NSRange r;
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    }
    
    // Remove some other extra stuff
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&deg;" withString:@"°"];
    string = [string stringByReplacingOccurrencesOfString:@"    " withString:@""];
    
    // Remove the new line returned by the API at beginning of string (not new line character, actual line)
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    // Remove (, ), ", ; characters
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"()\";"];
    string = [[string componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    
    return string;
}

- (void)refresh:(id)sender
{
    // Refresh the data
    [self getCurrentWeather:self];
    [self getForecastWeather:self];
    [self getRoadConditionsData:self];
    [self.tableView reloadData];
    
    // End refreshing
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    announcementArray = [NSMutableArray arrayWithObjects: @"1", @"2", @"3", @"4", nil];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    // If user overscrolls, colour is still grey
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
    // Locks to portrait
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:(166/255.f) green:(25/255.f) blue:(46/255.f) alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self getCurrentWeather:self];
    [self getForecastWeather:self];
    [self getRoadConditionsData:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

/**
 * Loads the table view cells. If it is the first cell in the view, it loads an SFUCardCell. If not,
 * it loads an SFUAnnouncementCell.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //-----------------------------
    // Main weather module
    //-----------------------------
    if (indexPath.row == 0) {
        
        SFUCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFUCardCell"];
        
        // Set weather location
        cell.location.text = @"SFU Burnaby";
        
        // Update current conditions
        [cell updateCurrentConiditionLabels:cell withDictionary:currentObservation];
        
        // Five Day forecast labels
        [cell updateFiveDayForecastLabels:cell withDictionary:forecastDay];
        
        return cell;
    }
    
    //-----------------------------
    // Announcements
    //-----------------------------
    else if(indexPath.row == 1) {
        
        SFUAnnouncementCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFUAnnouncementCell"];
        
        // Announcements
        cell.AnnouncementsTitle.text = @"Announcements";
        
        // Body
        NSString *announce = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", [announcementArray objectAtIndex:0], [announcementArray objectAtIndex:1], [announcementArray objectAtIndex:2]];
        
        cell.AnnouncementsBody.text = announce;
        
        return cell;
    }
    
    else {
        SFUCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"webcamCell"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return 350;
    }
    else if(indexPath.row == 1){
        return 210;
    }
    else {
        return 40;
    }
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"webcamSegue"]) {
        
        SFUWebListModel* m = [SFUWebListModel alloc];
        [ m initWithPlist:@"SFUWebcamURLs"];
        ((SFUWebListController*)[segue destinationViewController]).model =m;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/






@end
