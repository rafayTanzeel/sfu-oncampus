//
//  HourlyViewController.m
//  OnCampus
//
//  Created by Kevin Grant on 2015-03-07.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "HourlyViewController.h"
#import "CardCell.h"

@interface HourlyViewController ()

@end

@implementation HourlyViewController

NSArray *hourlyWeather;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-----------------------
// GET HOURLY WEATHER
//-----------------------
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
        NSLog(@"%@", hourlyWeather);
    }
}

- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.tableView.separatorColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% This is so if you overscroll, the color is still gray
   
    [self getHourlyWeather:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CardCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell"];
    }
    
    NSDictionary *zero = [hourlyWeather objectAtIndex:0];
    [cell updateHourlyLables:cell.hourOne labelTemp:cell.tempHourOne image:cell.iconHourOne cond:cell.condHourOne withDictionary:zero];
    
    NSDictionary *one = [hourlyWeather objectAtIndex:1];
    [cell updateHourlyLables:cell.hourTwo labelTemp:cell.tempHourTwo image:cell.iconHourTwo cond:cell.condHourTwo withDictionary:one];
    
    NSDictionary *two = [hourlyWeather objectAtIndex:2];
    [cell updateHourlyLables:cell.hourThree labelTemp:cell.tempHourThree image:cell.iconHourThree cond:cell.condHourThree withDictionary:two];
    
    NSDictionary *three = [hourlyWeather objectAtIndex:3];
    [cell updateHourlyLables:cell.hourFour labelTemp:cell.tempHourFour image:cell.iconHourFour cond:cell.condHourFour withDictionary:three];
    
    
    
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
