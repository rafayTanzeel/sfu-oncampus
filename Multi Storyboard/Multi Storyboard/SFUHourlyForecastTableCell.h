//
//  SFUHourlyForecastTableCell.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-08.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFUHourlyForecastTableCell : UITableViewCell <NSCoding>
@property (strong, nonatomic) IBOutlet UILabel *timeOfDay;
@property (weak, nonatomic) IBOutlet UIImageView *condImage;
@property (strong, nonatomic) IBOutlet UILabel *conditions;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
/**rafay was here*/

@end
