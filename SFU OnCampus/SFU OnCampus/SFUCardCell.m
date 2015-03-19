//
//  SFUCardCell.m
//  OnCampus
//  Team fiveOfTen
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//

#import "SFUCardCell.h"


@implementation SFUCardCell

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
    [self.cardView setAlpha:1];
    self.cardView.layer.masksToBounds = NO;
    
    // Round the corners, and give it a shadow
    self.cardView.layer.cornerRadius = 1;
    self.cardView.layer.shadowOffset = CGSizeMake(-.2f, .2f); 
    self.cardView.layer.shadowRadius = 1; 
    self.cardView.layer.shadowOpacity = 1;
    
    // Lowers the performance required to build shadows.
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    self.cardView.layer.shadowPath = path.CGPath;
    
    // Set the background colour
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; 
}

// Get the correct image for the weather from the local folder
// Used for the main weather
- (void)updateImage:(UIImageView*) weatherImage current:(NSString*) currentWeather
{
    // Create an array; each element is one word from the currentWeather string
    // Weather API may return conditions with Light, Heavy, or no prefix, so this
    // is used to ignore this prefix
    NSArray* weatherArray = [currentWeather componentsSeparatedByString:@" "];
    
    if ([currentWeather isEqualToString:(@"Small Hail")]) {
        weatherImage.image = [UIImage imageNamed:@"icyrain_dn.png"];
    }
    else if ([currentWeather isEqualToString:(@"Scattered Clouds")] || [currentWeather isEqualToString:(@"Mostly Cloudy")]) {
        weatherImage.image = [UIImage imageNamed:@"mostly_cloudy_d.png"];
    }
    else if ([currentWeather isEqualToString:(@"Partly Cloudy")]) {
        weatherImage.image = [UIImage imageNamed:@"mostly_sunny.png"];
    }
    else if ([currentWeather isEqualToString:(@"Clear")]) {
        weatherImage.image = [UIImage imageNamed:@"sunny.png"];
    }
    else if ([currentWeather isEqualToString:(@"Overcast")]) {
        weatherImage.image = [UIImage imageNamed:@"cloudy_dn.png"];
    }
    else if ([currentWeather isEqualToString:(@"Partial Fog")] || [currentWeather isEqualToString:(@"Shallow Fog")] || [currentWeather isEqualToString:(@"Patches of Fog")] || [currentWeather isEqualToString:(@"Fog")]) {
        weatherImage.image = [UIImage imageNamed:@"fog_dn.png"];
    }

    NSInteger i;

    // If the first word of the description is 'Light' or 'Heavy', the index is set to one so
    // we can check starting at the second word.
    if([weatherArray[0] isEqualToString:@"Light"] || [weatherArray[0] isEqualToString:@"Heavy"]) {
        i = 1;
    }
    else {
        i = 0;
    }
    
    if ([weatherArray[i] isEqualToString:@"Thunderstorms"] || [weatherArray[i] isEqualToString:@"Thunderstorm"]) {
        weatherImage.image = [UIImage imageNamed:@"storm_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Freezing"]) {
        weatherImage.image = [UIImage imageNamed:@"icyrain_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Hail"] || [weatherArray[i] isEqualToString:@"Small"] || [weatherArray[i] isEqualToString:@"Ice"]) {
        weatherImage.image = [UIImage imageNamed:@"icyrain_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Snow"]) {
        weatherImage.image = [UIImage imageNamed:@"snow_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Rain"] || [weatherArray[i] isEqualToString:@"Spray"] || [weatherArray[i] isEqualToString:@"Drizzle"]) {
        weatherImage.image = [UIImage imageNamed:@"rain_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Fog"]) {
        weatherImage.image = [UIImage imageNamed:@"fog_dn.png"];
    }
    else if ([weatherArray[i] isEqualToString:@"Mist"]) {
        weatherImage.image = [UIImage imageNamed:@"mist_d.png"];
    }
    
}

// Update image for the five day forecast and hourly forecast
- (void)updateForecastImage:(UIImageView*) weatherImage current:(NSString*) icon
{
    if([icon isEqualToString:@"chanceflurries"] || [icon isEqualToString:@"chancesleet"] || [icon isEqualToString:@"chancesnow"] || [icon isEqualToString:@"flurries"] || [icon isEqualToString:@"sleet"] || [icon isEqualToString:@"snow"]) {
        weatherImage.image = [UIImage imageNamed:@"snow_dn.png"];
    }
    else if([icon isEqualToString:@"chancerain"] || [icon isEqualToString:@"rain"]) {
        weatherImage.image = [UIImage imageNamed:@"rain_dn.png"];
    }
    else if([icon isEqualToString:@"chancetstorms"] || [icon isEqualToString:@"tstorms"]) {
        weatherImage.image = [UIImage imageNamed:@"storm_dn.png"];
    }
    else if([icon isEqualToString:@"clear"] || [icon isEqualToString:@"sunny"]) {
        weatherImage.image = [UIImage imageNamed:@"sunny.png"];
    }
    else if([icon isEqualToString:@"cloudy"]) {
        weatherImage.image = [UIImage imageNamed:@"cloudy_dn.png"];
    }
    else if([icon isEqualToString:@"fog"]) {
        weatherImage.image = [UIImage imageNamed:@"fog_dn.png"];
    }
    else if([icon isEqualToString:@"clear"]) {
        weatherImage.image = [UIImage imageNamed:@"sunny.png"];
    }
    else if([icon isEqualToString:@"mostlycloudy"] || [icon isEqualToString:@"partlysunny"]) {
        weatherImage.image = [UIImage imageNamed:@"mostly_cloudy_d.png"];
    }
    else if([icon isEqualToString:@"mostlysunny"] || [icon isEqualToString:@"partlycloudy"]) {
        weatherImage.image = [UIImage imageNamed:@"mostly_sunny.png"];
    }
    else {
        weatherImage.image = [UIImage imageNamed:@"unknown.png"];
    }
}

// Updates Labels for five day forecast
- (void)updateForecastLabels:(UILabel*) dayLabel labelHigh:(UILabel*) highLabel labelLow:(UILabel*) lowLabel image:(UIImageView*) imageDay withDictionary: (NSDictionary *) d
{
    // Strings representing high and low temperatures
    NSString *high = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"high"] objectForKey:@"celsius"]];
    NSString *low = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"low"] objectForKey:@"celsius"]];
    
    // Get and set icon
    NSString *icon = [d valueForKey:@"icon"];    
    [self updateForecastImage:imageDay current:icon];
    
    // Set day, high, and low labels
    dayLabel.text = [[d objectForKey:@"date"] objectForKey:@"weekday_short"];
    highLabel.text = high;
    lowLabel.text = low;
}

// Update labels for hourly forecast
- (void)updateHourlyLables:(UILabel*) hourLabel labelTemp:(UILabel*) tempLabel image:(UIImageView*) imageHour cond:(UILabel*) condLabel withDictionary:(NSDictionary*) d
{
    // Strings representing current hour and temperature
    NSString *hour = [NSString stringWithFormat:@"%@",[[d objectForKey:@"FCTTIME"] objectForKey:@"civil"]];
    NSString *temp = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"temp"] objectForKey:@"metric"]];
    
    // Strings represening description of current weather and pop
    NSString *cond = [NSString stringWithFormat:@"%@", [d objectForKey:@"condition"]];
    NSString *pop  = [NSString stringWithFormat:@"precip: %@%%", [d objectForKey:@"pop"]];
    NSString *conditions = [NSString stringWithFormat:@"%@    %@",cond, pop];
    
    // Update the weather icon    
    NSString *icon = [NSString stringWithFormat:@"%@", [d objectForKey:@"icon"]]; 
    [self updateForecastImage:imageHour current:icon];
    
    // Set the hour, temperature, and conditions label
    hourLabel.text = hour;
    tempLabel.text = temp;
    condLabel.text = conditions;
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end


