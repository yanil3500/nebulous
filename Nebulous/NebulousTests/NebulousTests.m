//
//  NebulousTests.m
//  NebulousTests
//
//  Created by Elyanil Liranzo Castro on 5/8/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CurrentWeatherViewControlla.h"

@interface NebulousTests : XCTestCase
@property(strong, nonatomic)NSTimeZone *testTimeZone;
@property(strong, nonatomic)NSString *testTemperature;
@property(strong, nonatomic)CurrentWeatherViewControlla *testViewControlla;
@end

@implementation NebulousTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testViewControlla = [[CurrentWeatherViewControlla alloc] init];
    self.testTimeZone = [[NSTimeZone defaultTimeZone] init];
    self.testTemperature = [[NSString alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testTimeZone = nil;
    self.testTemperature = nil;
    [super tearDown];
}

- (void)testforeignTimeZoneDateFormatter{
    id date = [self.testViewControlla foreignTimeZoneDateFormatter:self.testTimeZone];
    //Assertion 1
    //Checks to see if it returns a string
    XCTAssert([date isKindOfClass:[NSString class]],@"The foreignTimeZoneDateFormatter did not return a string.");
    //Assertion 2
    //Checks to see if the method throws an exception when given nil
    self.testTimeZone = nil;
    XCTAssertThrows([self.testViewControlla foreignTimeZoneDateFormatter:nil],@"foreignTimeZoneDateFormatter did not throw an exception.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
