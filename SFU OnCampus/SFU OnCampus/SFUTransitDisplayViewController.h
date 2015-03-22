//
//  SFUTransitDisplayViewController.h
//  OnCampus
//
//  Created by Nikhil Gaba on 2015-03-14.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUTransitModel.h"
@interface SFUTransitDisplayViewController :UIViewController <NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>{
NSTimer *countDownTimer;
float secondsCount;

}
@property (weak, atomic) NSIndexPath *BusPath;
@property (strong, nonatomic) IBOutlet SFUTransitModel *model;

@property (strong, atomic) NSString *loopName;

@property (weak, nonatomic) IBOutlet UILabel *nextBusTime;
@property (weak, nonatomic) IBOutlet UILabel *nextBusDeltaTime;


@property (weak, nonatomic) IBOutlet UITableView *upcomingTableView;


@end
