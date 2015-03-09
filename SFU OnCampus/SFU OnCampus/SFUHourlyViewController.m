//
//  SFUHourlyViewController.m
//  OnCampus
//  Team fiveOfTen
//
//  Created by Kevin Grant on 2015-03-07.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//
//  Known Issue: temperature values to not align well on ipad.
//

#import "SFUHourlyViewController.h"
#import "SFUCardCell.h"

@interface SFUHourlyViewController ()

@end

@implementation SFUHourlyViewController

// Global array used to store JSON data from weather API
NSArray *hourlyWeather;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 * Gets the hourly weather data from the Wunderground Weather API.
 */
 -(IBAction)getHourlyWeather:(id)sender {
    
    // Prepare the URL that we'll get the weather info data from.
    NSURL *url = [NSURL URLWithString:@"http://api.wunderground.com/api/3ff62c9b4941d736/hourly/q/Canada/Burnaby.json"];
   
    //Get URL page into NSData Object
    NSData *hourlyWeatherData = [NSData dataWithContentsOfURL:url];
    
    //Read JSON and convert to object
    NSError *error;
    if(hourlyWeatherData != nil)
    {
        error = nil;
    }
    NSMutableDictionary *hourlyDictionary = [NSJSONSerialization JSONObjectWithData:hourlyWeatherData options:kNilOptions error:&error];
    
    if (error != nil) {
         NSLog(@"%@", [error localizedDescription]);
    }
    else{
        hourlyWeather = [hourlyDictionary objectForKey:@"hourly_forecast"];
        // NSLog(@"%@", hourlyWeather);  // used for debugging
    }
}

- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.tableView.separatorColor = [UIColor clearColor];
    
    // Colour remains grey if user overscrolls
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; 
   
    [self getHourlyWeather:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1;
}

/**
 * Loads the table view cell. 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFUCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SFUCardCell"];
    
    // Configure the cell
    if (cell == nil) {
        cell = [[SFUCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SFUCardCell"];
    }
    
    // -----------------------------------------------------
    // Time, icon, conditions, and temperature for each hour
    // -----------------------------------------------------
    NSDictionary *zero = [hourlyWeather objectAtIndex:0];
    [cell updateHourlyLables:cell.hourOne labelTemp:cell.tempHourOne image:cell.iconHourOne cond:cell.condHourOne withDictionary:zero];
    
    NSDictionary *one = [hourlyWeather objectAtIndex:1];
    [cell updateHourlyLables:cell.hourTwo labelTemp:cell.tempHourTwo image:cell.iconHourTwo cond:cell.condHourTwo withDictionary:one];
    
    NSDictionary *two = [hourlyWeather objectAtIndex:2];
    [cell updateHourlyLables:cell.hourThree labelTemp:cell.tempHourThree image:cell.iconHourThree cond:cell.condHourThree withDictionary:two];
    
    NSDictionary *three = [hourlyWeather objectAtIndex:3];
    [cell updateHourlyLables:cell.hourFour labelTemp:cell.tempHourFour image:cell.iconHourFour cond:cell.condHourFour withDictionary:three];
    
    NSDictionary *four = [hourlyWeather objectAtIndex:4];
    [cell updateHourlyLables:cell.hourFive labelTemp:cell.tempHourFive image:cell.iconHourFive cond:cell.condHourFive withDictionary:four];
    
    NSDictionary *five = [hourlyWeather objectAtIndex:5];
    [cell updateHourlyLables:cell.hourSix labelTemp:cell.tempHourSix image:cell.iconHourSix cond:cell.condHourSix withDictionary:five];
    
    NSDictionary *six = [hourlyWeather objectAtIndex:6];
    [cell updateHourlyLables:cell.hourSeven labelTemp:cell.tempHourSeven image:cell.iconHourSeven cond:cell.condHourSeven withDictionary:six];
    
    NSDictionary *seven = [hourlyWeather objectAtIndex:7];
    [cell updateHourlyLables:cell.hourEight labelTemp:cell.tempHourEight image:cell.iconHourEight cond:cell.condHourEight withDictionary:seven];
    
    NSDictionary *eight = [hourlyWeather objectAtIndex:8];
    [cell updateHourlyLables:cell.hourNine labelTemp:cell.tempHourNine image:cell.iconHourNine cond:cell.condHourNine withDictionary:eight];
    
    NSDictionary *nine = [hourlyWeather objectAtIndex:9];
    [cell updateHourlyLables:cell.hourTen labelTemp:cell.tempHourTen image:cell.iconHourTen cond:cell.condHourTen withDictionary:nine];
    
    NSDictionary *ten = [hourlyWeather objectAtIndex:10];
    [cell updateHourlyLables:cell.hourEleven labelTemp:cell.tempHourEleven image:cell.iconHourEleven cond:cell.condHourEleven withDictionary:ten];
    
    NSDictionary *eleven = [hourlyWeather objectAtIndex:11];
    [cell updateHourlyLables:cell.hourTwelve labelTemp:cell.tempHourTwelve image:cell.iconHourTwelve cond:cell.condHourTwelve withDictionary:eleven];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
