//
//  SFULoyaltyCardViewController.m
//  OnCampus
//
//  Created by Abram Wiebe on 2015-03-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoyaltyCardViewController.h"
#import "SFULoyaltyCardModel.h"

@interface SFULoyaltyCardViewController ()

@end

@implementation SFULoyaltyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber* n = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSFUPointCardBalance"];
    
    self.pointsLabel.text=[n stringValue];

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
    ///This is a dummy url, sfu will need to implement server.
    NSString* user = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSString* urlString = [NSString stringWithFormat:@"http://www.burningthumb.com/API/SFU/loyalty.php?username=%@&token=%@&useget=1",user,s];
    NSURL* url = [NSURL URLWithString:urlString];
    NSError* e;
    NSString* response = [[NSString alloc]initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&e];
    NSMutableArray *lines = [[response componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    NSString* value = [lines objectAtIndex:0];
    NSLog(@"redeem code value=%@",value);
    NSInteger i = [value integerValue];
    SFULoyaltyCardModel* model=[SFULoyaltyCardModel new];
    NSInteger balancelabel=[model setBalance:i];
    if(i <0)
    {
        self.statusLine.text = @"Bad code or no value";
    }else
    {
        self.statusLine.text = [NSString stringWithFormat:@"Redeemed code for %@ points",value];
    }
    
    //update label
    self.pointsLabel.text=[NSString stringWithFormat:@"%ld",(long)balancelabel];
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
