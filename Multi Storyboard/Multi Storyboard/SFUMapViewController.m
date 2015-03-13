//
//  SFUMapViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapViewController.h"
@import CoreLocation;
@import MapKit;
@interface SFUMapViewController ()

@end

@implementation SFUMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:@"1 Infinite Loop"
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     for (CLPlacemark* aPlacemark in placemarks)
                     {
                         // Process the placemark.
                         NSLog(@"%@",aPlacemark.location.description);
                     }
                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
