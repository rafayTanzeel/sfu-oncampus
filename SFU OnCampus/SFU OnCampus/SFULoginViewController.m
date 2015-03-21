//
//  SFULoginViewController.m
//  OnCampus
//
//  Created by Kevin Grant on 2015-03-21.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFULoginViewController.h"

@interface SFULoginViewController ()

@end

@implementation SFULoginViewController

// Round the corners, and give it a shadow
- (void)signinButtonProperties
{
    // Round the corners, and give it a shadow
    self.signinButton.layer.cornerRadius = 5;
    self.signinButton.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    self.signinButton.layer.shadowRadius = 5;
    self.signinButton.layer.shadowOpacity = 0.3;
    
    // Lowers the performance required to build shadows.
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.signinButton.bounds];
    self.signinButton.layer.shadowPath = path.CGPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self signinButtonProperties];
    // Do any additional setup after loading the view.
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

- (IBAction)signinButtonClicked:(id)sender
{
    
}

@end
