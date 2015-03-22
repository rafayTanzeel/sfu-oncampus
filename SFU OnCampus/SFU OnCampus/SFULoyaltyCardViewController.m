//
//  SFULoyaltyCardViewController.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoyaltyCardViewController.h"

@interface SFULoyaltyCardViewController ()

@end

@implementation SFULoyaltyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)foundCodeWithStringRepresentation:(NSString*)s
{
    NSLog(@"loyaty card view controll foudCodeWithStringRep: %@",s);
    //model redeem s
    //update label
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((SFUQRCaptureViewController*)segue.destinationViewController).delegate=self;     // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)scanCode:(id)sender
{
//    SFUQRCaptureViewController* c = [[UIStoryboard storyboardWithName:@"QRScan" bundle:nil] instantiateInitialViewController];
//    c.delegate=self;
//    [self.navigationController pushViewController:c animated:YES];
}

-(IBAction)unwindToSFULoyaltyCardViewController:(UIStoryboardSegue *)segue 
{
    SFUQRCaptureViewController* q = (SFUQRCaptureViewController*)[segue sourceViewController];
    NSString *s = [q composeShortcode];
    [self foundCodeWithStringRepresentation:s];
}
@end
