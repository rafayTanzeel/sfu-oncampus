//
//  SFUMapViewController.h
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUMapModel.h"
#import "SFUMapAnnotation.h"
@import CoreLocation;
@import MapKit;

@interface SFUMapViewController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)captureRegion:(id)sender;
- (IBAction)findDestination:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *regionNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *destinationField;
@property (strong, nonatomic) IBOutlet UITextField *sourceField;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UIView *showSearchHelp;

@property SFUMapModel* model;

@property (weak, nonatomic) IBOutlet UIView *debugView;

///When the interior view needs information on the selected annotaiton it asks about this, even though is no strict protocol.
@property  NSString* detailSelectedShortcode;

//When the composer view ends, this is used to hold the resulting shorcode
@property NSString* returnedString;

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay;
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)overlay;

- (void)textFieldDidEndEditing:(UITextField *)textField;



@end
