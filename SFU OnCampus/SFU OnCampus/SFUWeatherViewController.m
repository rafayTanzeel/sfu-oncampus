//
//  SFUWeatherViewController.m
//  OnCampus
//	Team fiveOfTen
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//
//	Known bug: announcement cell does not align properly. However, this is
// 			   a storyboard alignment issue, not an implementation issue.
//
//  To implement: Actually HTML parsing for the SFUAnnouncementCell.
//

#import "SFUWeatherViewController.h"
#import "SFUCardCell.h"
#import "SFUAnnouncementCell.h"

@interface SFUWeatherViewController ()

@end

@implementation SFUWeatherViewController

// Global dictionary and array used for storing JSON data
NSMutableDictionary *currentObservation;
NSArray *forecastDay;

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
    @finally {
        
    }
    if(currentWeatherData == nil)
    {
        // Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Weather cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //Read JSON and convert to object
    NSError *error;
    if(currentWeatherData != nil)
    {
        error = nil;
    }
    NSMutableDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
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
    NSData *forecastWeatherData = [NSData dataWithContentsOfURL:url];
 
    //Read JSON and convert to object   
    NSMutableDictionary *simpleForecast;
    
    NSError *error;
    if(forecastWeatherData != nil)
    {
        error = nil;
    }
    else {
    	// Display the error pop up
        [[[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"Weather cannot be displayed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    NSMutableDictionary *forecastDictionary = [NSJSONSerialization JSONObjectWithData:forecastWeatherData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        simpleForecast = [[forecastDictionary objectForKey:@"forecast"] objectForKey:@"simpleforecast"];
    }

	// Store the data in the forecastDay global array
    forecastDay = [simpleForecast objectForKey:@"forecastday"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    // If user overscrolls, colour is still grey
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; 
    
    [self getCurrentWeather:self];
    [self getForecastWeather:self];
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
    return 2;
}

/**
 * Loads the table view cells. If it is the first cell in the view, it loads an SFUCardCell. If not,
 * it loads an SFUAnnouncementCell.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // index of current row
    int tableIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    
    //-----------------------------
    // Main weather module
    //-----------------------------
    if (tableIndex == 0) {
        
        SFUCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFUCardCell"];
        
        // Configure the cell
        if (cell == nil) {
            cell = [[SFUCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SFUCardCell"];
        }
        
        // Set weather location
        cell.location.text = @"SFU Burnaby";
        
        // Current conditions description
        NSString *condition = [currentObservation valueForKey:@"weather"];
        cell.weatherDescription.text = condition;
        
        // Current wind and Precipitation
        NSNumber *wind = [currentObservation valueForKey:@"wind_kph"];
        NSInteger windInt = [wind integerValue];
        NSString *precipitation = [currentObservation valueForKey: @"precip_today_metric"];
        if ([precipitation isEqualToString:@"--"]) {
            precipitation = @"0";
        }
        NSString *pw = [NSString stringWithFormat:@"wind %ldkm/h • precip %@mm",(long)windInt,precipitation];
        cell.windAndPrecip.text = pw;
        
        // Large temperature icon and string
        NSString *tempString = [currentObservation valueForKey:@"temp_c"];
        NSInteger temp = [tempString integerValue];
        cell.temperature.text = [NSString stringWithFormat:@"%ld°",(long)temp];
        
        [cell updateImage:cell.weatherIcon current:condition];
        
        // Day One Lables
        NSDictionary *zero = [forecastDay objectAtIndex:0];
        [cell updateForecastLabels:cell.dayOne labelHigh:cell.dayOneHigh labelLow:cell.dayOneLow image:cell.iconDayOne withDictionary:zero];
        
        // Day Two Labels
        NSDictionary *one = [forecastDay objectAtIndex:1];
        [cell updateForecastLabels:cell.dayTwo labelHigh:cell.dayTwoHigh labelLow:cell.dayTwoLow image:cell.iconDayTwo withDictionary:one];
        
        // Day Three Labels
        NSDictionary *two = [forecastDay objectAtIndex:2];
        [cell updateForecastLabels:cell.dayThree labelHigh:cell.dayThreeHigh labelLow:cell.dayThreeLow image:cell.iconDayThree withDictionary:two];
        
        // Day Four Labels
        NSDictionary *three = [forecastDay objectAtIndex:3];
        [cell updateForecastLabels:cell.dayFour labelHigh:cell.dayFourHigh labelLow:cell.dayFourLow image:cell.iconDayFour withDictionary:three];
        
        // Day Five Labels
        NSDictionary *four = [forecastDay objectAtIndex:4];
        [cell updateForecastLabels:cell.dayFive labelHigh:cell.dayFiveHigh labelLow:cell.dayFiveLow image:cell.iconDayFive withDictionary:four];
        
        return cell;
    }
    
    //-----------------------------
    // Announcements
    //-----------------------------
    else {
        
        SFUAnnouncementCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFUAnnouncementCell"];
        
        // Announcements
        cell.AnnouncementsTitle.text = @"Announcements";

        // To be updated to actual html. this is just to show the view behaves correctly
        cell.AnnouncementsBody.text = @"It is currently 12°C on campus with few clouds in the sky. Roadways, parking lots and walkways are dry. Driving conditions and visibility are good.\
        \n\nPlease drive with caution and watch for any areas that are currently under construction, as well as any road closures on campus.\
        \n\nThis report will be updated as conditions change.";
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return 350;
    }
    else {
        return 210;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
