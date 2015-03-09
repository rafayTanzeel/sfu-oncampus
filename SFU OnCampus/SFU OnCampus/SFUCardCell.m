//
//  SFUCardCell.m
//  OnCampus
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

-(void)cardSetup
{
    [self.cardView setAlpha:1];
    self.cardView.layer.masksToBounds = NO;
    
    // Round the corners
    self.cardView.layer.cornerRadius = 1;
    self.cardView.layer.shadowOffset = CGSizeMake(-.2f, .2f); //%%% this shadow will hang slightly down and to the right
    self.cardView.layer.shadowRadius = 1; //%%% I prefer thinner, subtler shadows, but you can play with this
    self.cardView.layer.shadowOpacity = 2; //%%% same thing with this, subtle is better for me
    
    //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    self.cardView.layer.shadowPath = path.CGPath;
    
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% I prefer choosing colors programmatically than on the storyboard
}

// Get the correct image for the weather from the local folder
// Used for the main weather and the hourly weather
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

// Update image for the five day forecast
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
}

// Updates Labels for five day forecast
- (void)updateForecastLabels:(UILabel*) dayLabel labelHigh:(UILabel*) highLabel labelLow:(UILabel*) lowLabel image:(UIImageView*) imageDay withDictionary: (NSDictionary *) d
{
    NSString *high = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"high"] objectForKey:@"celsius"]];
    NSString *low = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"low"] objectForKey:@"celsius"]];
    
    NSString *icon = [d valueForKey:@"icon"];
    //imageDay.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon_URL]]];
    
    [self updateForecastImage:imageDay current:icon];
    
    dayLabel.text = [[d objectForKey:@"date"] objectForKey:@"weekday_short"];
    highLabel.text = high;
    lowLabel.text = low;
}

// Update labels for hourly forecast
- (void)updateHourlyLables:(UILabel*) hourLabel labelTemp:(UILabel*) tempLabel image:(UIImageView*) imageHour cond:(UILabel*) condLabel withDictionary:(NSDictionary*) d
{
    NSString *hour = [NSString stringWithFormat:@"%@",[[d objectForKey:@"FCTTIME"] objectForKey:@"civil"]];
    NSString *temp = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"temp"] objectForKey:@"metric"]];
    
    NSString *cond = [NSString stringWithFormat:@"%@", [d objectForKey:@"condition"]];
    NSString *pop  = [NSString stringWithFormat:@"precip: %@%%", [d objectForKey:@"pop"]];
    NSString *conditions = [NSString stringWithFormat:@"%@    %@",cond, pop];
    
    //NSString *icon_URL = [d valueForKey:@"icon_url"];
    //imageHour.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon_URL]]];
    
    [self updateImage:imageHour current:cond];
    
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


