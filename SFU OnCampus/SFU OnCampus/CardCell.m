//
//  CardCell.m
//  test
//
//  Created by Kevin Grant on 2/25/15.
//  Copyright (c) 2015 Kevin Grant. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

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

// Updates Labels for five day forecast
- (void)updateForecastLabels:(UILabel*) dayLabel labelHigh:(UILabel*) highLabel labelLow:(UILabel*) lowLabel image:(UIImageView*) imageDay withDictionary: (NSDictionary *) d
{
    NSString *high = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"high"] objectForKey:@"celsius"]];
    NSString *low = [NSString stringWithFormat:@"%@°",[[d objectForKey:@"low"] objectForKey:@"celsius"]];
    
    NSString *icon_URL = [d valueForKey:@"icon_url"];
    imageDay.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon_URL]]];
    
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
    NSString *pop  = [NSString stringWithFormat:@"precip: %@%", [d objectForKey:@"pop"]];
    NSString *conditions = [NSString stringWithFormat:@"%@\t%@", cond, pop];
    
    NSString *icon_URL = [d valueForKey:@"icon_url"];
    imageHour.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:icon_URL]]];
    
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


