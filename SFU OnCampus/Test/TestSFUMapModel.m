//
//  TestSFUMapModel.m
//  OnCampus
//
//  Created by Sunny on 2015-04-06.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "SFUMapModel.h"

@interface TestSFUMapModel : XCTestCase {
    SFUMapModel *m;
}

@end

@implementation TestSFUMapModel

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
     m = [SFUMapModel new];
    // m = [[SFUMAPModel alloc]init]
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testshortCodeForDisplayName {
    
    NSString* shortCode = @"BLU";
    NSString* expect = @"Blusson Hall";
    BOOL t = [[m displayNameForShortCode:shortCode] isEqualToString:expect];
    XCTAssertTrue(t);
    
    
    
    
    
    
    
    /*NSString* shortCode = @"AQ";
    NSString* expeect = @"Academic Quadrangle";
    BOOL t = [[m displayNameForShortCode:shortCode] isEqualToString:expeect];
    XCTAssertTrue(t);*/
    
    
}

@end
