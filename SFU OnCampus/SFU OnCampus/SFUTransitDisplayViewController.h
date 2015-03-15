//
//  SFUTransitDisplayViewController.h
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUTransitModel.h"
@interface SFUTransitDisplayViewController : UIViewController
@property (weak, atomic) NSIndexPath *BusPath;
@property (strong, nonatomic) IBOutlet SFUTransitModel *model;
@property (weak, nonatomic) IBOutlet UILabel *nextBusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextBus;
@property (weak, nonatomic) IBOutlet UILabel *upcomingBuses;
@property (weak, nonatomic) IBOutlet UILabel *firstBusUpcoming;
@property (weak, nonatomic) IBOutlet UILabel *secondBusUpcoming;
@property (weak, nonatomic) IBOutlet UILabel *thirdBusUpcoming;
@property (weak, nonatomic) IBOutlet UILabel *fourthBusUpcoming;

@end
