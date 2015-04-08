//
//  LoyaltyCardModelTest.m
//  OnCampus
//
//  Created by Sunny on 2015-04-06.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SFULoyaltyCardModel.h"
#include <limits.h>

@interface LoyaltyCardModelTest : XCTestCase {
    SFULoyaltyCardModel *m;
}



@end

@implementation LoyaltyCardModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    m = [[SFULoyaltyCardModel alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddBalance{
    // This is an example of a functional test case.
    //XCTAssert(YES, @"Pass");
    NSInteger oldBalance = [m getBalance];
    [m addBalance:UINT32_MAX]; //add a big ol number
   [m addBalance:500];
    XCTAssertTrue([m getBalance] == ( UINT32_MAX + oldBalance +500 )  && ( ( UINT32_MAX + oldBalance +500) > oldBalance ) ); //false if wrapped around, in practice shouldn't happen

    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end



