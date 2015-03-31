//
//  SFUMapViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapViewController.h"
#import "SFUShortCodeComposerViewController.h"
#import "SFUMapModel.h"

@interface SFUMapViewController ()
{
    BOOL destinationFieldSelected;
}

@end

@implementation SFUMapViewController

CLLocationManager* locationManager;
- (void)viewDidLoad {
    self.model = [SFUMapModel new];
    [super viewDidLoad];
    NSLog(@"loaded");
    MKCoordinateSpan span = {0.00525,0.00525};
    locationManager = [CLLocationManager new] ;
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    
    //prevent the menu from appearing when we swipt the left hand side of the screen.
    self.splitViewController.presentsWithGesture = NO;
#ifndef DEBUG
    self.debugView.hidden = YES;
#endif
    
        CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:@"Simon Fraser University"
                 completionHandler:^(NSArray* placemarks, NSError* error)
    {
                     if(self.mapView.showsUserLocation)
                     {
                         //location services sucessful so , ignore default geocode.
                         
                     }else
                     {
                     
                     for (CLPlacemark* aPlacemark in placemarks)
                     {
                         MKCoordinateRegion region = { aPlacemark.location.coordinate ,span };
                         //[self.mapView setCenterCoordinate:aPlacemark.location.coordinate animated:YES];
                         [self.mapView setRegion:region animated:NO];
                         // Process the placemark.
                         NSLog(@"%@",aPlacemark.location.description);
                     }
                    
                     }
                     
    }
     ];
                 
    
    
    if(destinationFieldSelected)
    {
        self.destinationField.text=self.returnedString;
    }else
    {
        self.sourceField.text=self.returnedString;
    }
    
    BOOL shouldShowMapHelpOnRun = [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldShowMapHelpOnRun"];
    if(shouldShowMapHelpOnRun)
    {
        [self performSegueWithIdentifier:@"helpSegue" sender:self];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    MKCoordinateSpan span = {0.00525,0.00525};
    self.mapView.showsUserLocation = YES;
    MKCoordinateRegion region = { manager.location.coordinate ,span };
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)captureRegion:(id)sender
{
    NSLog(@"%@\nspan\n{\n%f\n,\n%f\n},\ncentre{\n%f\n,\n%f\n}\n\n",self.regionNameTextField.text,self.mapView.region.span.longitudeDelta,self.mapView.region.span.latitudeDelta,self.mapView.region.center.longitude,self.mapView.region.center.latitude);
    [self.regionNameTextField resignFirstResponder];

}
-(void)reportNullRegion
{
    [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"It looks like one or more of the entered locations doesn't exist. If you manually entered the code, try clicking the arrows to the right of the fields, to automatically get a location name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void)clearAllPins
{
    [self.mapView removeAnnotations:self.mapView.annotations];
}

-(void)clearAllOverlays
{
    [self.mapView removeOverlays:self.mapView.overlays];
}

- (IBAction)hideSearch:(id)sender {
    self.searchView.hidden =YES;
    self.showSearchHelp.hidden=NO;
}
- (IBAction)showSearch:(id)sender {
    self.searchView.hidden =NO;
    self.showSearchHelp.hidden=YES;
}

- (IBAction)findDestination:(id)sender
{
    NSString* dest = self.destinationField.text;
    NSString* src = self.sourceField.text;
    [self.sourceField resignFirstResponder];
    [self.destinationField resignFirstResponder];
    
    [self clearAllPins];
    [self clearAllOverlays];
    
    BOOL hasSrc =NO;
    if(![src isEqualToString:@""])
    {
        hasSrc=YES;
    }
    
    BOOL hasDest =NO;
    if(![dest isEqualToString:@""])
    {
        hasDest=YES;
    }
    SFUMapAnnotation* a,*b;
    @try {
        //TODO, be smarter about where to zoom and draw based on the presenece of a source and dest
        if(hasSrc)
        {
        SFUMapModelResolutionStatus status;
        ///Zoom to and draw source
        MKCoordinateRegion r = [self.model regionForString:src status:&status];
        [self.mapView setRegion:r animated:YES];
        NSLog(@"%@\nspan{%f,%f},centre{%f,%f}\n\n",self.destinationField.text,r.span.longitudeDelta,r.span.latitudeDelta,r.center.longitude,r.center.latitude);
        SFULocation* loc = [self.model locationForShortcode:src];
        NSString* title = loc.displayName;
         a = [[SFUMapAnnotation alloc] initWithTitle:title subtitle:@"" shortcode:src];
        a.coordinate = r.center;
        a.isDestination =NO;
        [self.mapView addAnnotation: a];
        }
        
        if(hasDest)
        {
            SFUMapModelResolutionStatus status;
             MKCoordinateRegion r = [self.model regionForString:src status:&status];
            SFULocation* loc = [self.model locationForShortcode:src];
        ///Zoom to and draw destination
        r = [self.model regionForString:dest status:&status];
        //[self.mapView setRegion:r animated:YES];
        printf("%s\nspan{\n%f\n,\n%f},centre{\n%f\n,\n%f\n}\n\n",self.destinationField.text.UTF8String,r.span.longitudeDelta,r.span.latitudeDelta,r.center.longitude,r.center.latitude);
            NSString* title = loc.displayName;
       b = [[SFUMapAnnotation alloc] initWithTitle:title subtitle:@"" shortcode:dest];
        title = [self.model displayNameForShortCode:dest];
        b.coordinate = r.center;
        b.isDestination =YES;
        [self.mapView addAnnotation: b];
        }
        
        if(hasSrc && hasDest)
        {
        CLLocationCoordinate2D points[2];
        points[0]= a.coordinate;
        points[1]=b.coordinate;
        MKPolyline* line = [MKPolyline polylineWithCoordinates:points count:2];
        [self.mapView addOverlay:line level: MKOverlayLevelAboveLabels];
        }
        
    }
    @catch (NSException *exception) {
        [self reportNullRegion];
    }
    
    
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer* r = [[MKPolylineRenderer alloc]initWithOverlay:overlay];;
    r.lineWidth=5.0;
    r.strokeColor = [UIColor greenColor];
    return r;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //If drawingthe annotation of the current user location, use the system provided one.
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    
    NSString* identifier = @"pin";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(!pin)
    pin =[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    
    if([annotation isKindOfClass: [SFUMapAnnotation class]])
    {
        SFUMapAnnotation* o = annotation;
        
        if(o.isDestination)
            [pin setPinColor: MKPinAnnotationColorRed];
        else
            [pin setPinColor: MKPinAnnotationColorGreen];
            
    }
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
  
    pin.rightCalloutAccessoryView = rightButton;
    pin.animatesDrop = YES;
    
    pin.canShowCallout = YES;
   
    return pin;
    
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    SFUMapAnnotation* a = view.annotation;
    self.detailSelectedShortcode = a.shortcode;
    [self performSegueWithIdentifier:@"interiorMapSegue" sender:self];
}

- (IBAction)swapSourceAndDestination:(id)sender
{
    NSString* s = self.sourceField.text;
    self.sourceField.text = self.destinationField.text;
    self.destinationField.text=s;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.sourceField)
    {
        [textField resignFirstResponder];
        [self.destinationField becomeFirstResponder];
    }
    
    if(textField == self.destinationField)
    {
        [textField resignFirstResponder];
        [self findDestination:self];
    }
    return false;
}
- (IBAction)recordPosition:(UILongPressGestureRecognizer*)sender
{
    CGPoint p= [sender locationInView:self.mapView];
    CLLocationCoordinate2D l = [self.mapView convertPoint:p toCoordinateFromView:self.mapView];
    NSLog(@"Held point %f %f \n",l.longitude,l.latitude);
}

- (IBAction)unwindToSFUMapViewController:(UIStoryboardSegue *)segue {
    NSString* s = [segue.sourceViewController composeShortcode];
    if(destinationFieldSelected)
    {
        self.destinationField.text=s;
    }else
    {
        self.sourceField.text=s;
    }
}



-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Experimenting with autocompletion
//    if(range.length ==0) // was singe character indertion,deletio or edit
//    {
//        if(textField.text.length <3)
//        {
//            //Trying to suggest before 3 characters significantly increases the number of suggestions
//            return YES;
//        }
//        NSString* suggestion = [self.model suggestionForPrefix:textField.text];
//        if(suggestion !=nil)
//        {
//            
//        NSUInteger delta = suggestion.length - textField.text.length;
//            //fromhttps://developer.sinnerschrader-mobile.com/setting-text-selection-and-cursor-position-in-uitextfields/455/
//            NSRange r = NSMakeRange(range.location, delta);
//            UITextPosition *from = [textField positionFromPosition:[textField beginningOfDocument] offset:r.location];
//            UITextPosition *to = [textField positionFromPosition:from offset:-r.length];
//            textField.text = suggestion;
//            [textField setSelectedTextRange:[textField textRangeFromPosition:from toPosition:to]];
//            
//            
//            
//
//            //  [sender setSelectedTextRange:newRange];
//            return NO;
//        }
//        
//    }
    //NSLog(@"shouldchangeCharsInRange:[%d,%d],\"%@\"",range.location,range.length,string);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // gndn
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if([segue.identifier isEqualToString:@"srcSegue"])
   {
       destinationFieldSelected = NO;
   }else
   {
       destinationFieldSelected = YES;
   }
}


@end
