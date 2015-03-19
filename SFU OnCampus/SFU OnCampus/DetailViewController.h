//
//  DetailViewController.h
//  SFU OnCampus
//
//  Created by Abram Wiebe on 2015-02-19.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This is a placeholder for unimplemented
 @note do not include in shipped products.
 */
@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

