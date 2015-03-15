//
//  SFUMapViewController.m
//  Multi Storyboard
//
//  Created by Abram Wiebe on 2015-03-13.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMapViewController.h"

@interface SFUMapViewController ()

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
    
    
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:@"Simon Fraser University"
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     for (CLPlacemark* aPlacemark in placemarks)
                     {
                         MKCoordinateRegion region = { aPlacemark.location.coordinate ,span };
                         //[self.mapView setCenterCoordinate:aPlacemark.location.coordinate animated:YES];
                         [self.mapView setRegion:region animated:NO];
                         // Process the placemark.
                         NSLog(@"%@",aPlacemark.location.description);
                     }
                 }];
    
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    self.mapView.showsUserLocation = YES;
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

- (IBAction)captureRegion:(id)sender
{
    NSLog(@"%@\nspan{%f,%f},centre{%f,%f}\n\n",self.regionNameTextField.text,self.mapView.region.span.longitudeDelta,self.mapView.region.span.latitudeDelta,self.mapView.region.center.longitude,self.mapView.region.center.latitude);
    [self.regionNameTextField resignFirstResponder];

}
-(void)reportNullRegion
{
    [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"It looks like the place you're looking for doesn't exist. If you manually entered the code, try clicking the arrows to automatically get a destionation name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
    
    @try {
        //TODO, be smarter about where to zoom and draw based on the presenece of a source and dest
        
        ///Zoom to and draw source
        MKCoordinateRegion r = [self.model regionForShortCode:src];
        [self.mapView setRegion:r animated:YES];
        NSLog(@"%@\nspan{%f,%f},centre{%f,%f}\n\n",self.destinationField.text,r.span.longitudeDelta,r.span.latitudeDelta,r.center.longitude,r.center.latitude);
        SFUMapAnnotation* a = [SFUMapAnnotation new];
        a.coordinate = r.center;
        a.isDestination =NO;
        [self.mapView addAnnotation: a];
        
        ///Zoom to and draw destination
        r = [self.model regionForShortCode:dest];
        //[self.mapView setRegion:r animated:YES];
        NSLog(@"%@\nspan{%f,%f},centre{%f,%f}\n\n",self.destinationField.text,r.span.longitudeDelta,r.span.latitudeDelta,r.center.longitude,r.center.latitude);
        SFUMapAnnotation* b = [SFUMapAnnotation new];
        b.coordinate = r.center;
        b.isDestination =YES;
        [self.mapView addAnnotation: b];
        
        CLLocationCoordinate2D points[2];
        points[0]= a.coordinate;
        points[1]=b.coordinate;
        MKPolyline* line = [MKPolyline polylineWithCoordinates:points count:2];
        [self.mapView addOverlay:line level: MKOverlayLevelAboveLabels];
        
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
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)overlay
{
    NSString* identifier = @"pin";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(!pin)
    pin =[[MKPinAnnotationView alloc] initWithAnnotation:overlay reuseIdentifier:identifier];
    
    if([overlay isKindOfClass: [SFUMapAnnotation class]])
    {
        SFUMapAnnotation* o = overlay;
        
        if(o.isDestination)
            [pin setPinColor: MKPinAnnotationColorRed];
        else
            [pin setPinColor: MKPinAnnotationColorGreen];
            
    }
    return pin;
    
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
    //nothing goes here
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


@end
