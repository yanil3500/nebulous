//
//  testCurrentForecast.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CurrentForecast.h"
@interface testCurrentForecast : XCTestCase
@property(strong, nonatomic)CurrentForecast *testForecast;
@property(strong, nonatomic)NSString *testString;
@end

@implementation testCurrentForecast

- (void)setUp {
    [super setUp];
    self.testString = [[NSString alloc]init];
    self.testForecast = [[CurrentForecast alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testString = nil;
    self.testForecast = nil;
    [super tearDown];
}

- (void)testWindBearingForCompassSectors{
    id value = [self.testForecast windBearingForCompassSectors:self.testString];
    //Assert 7
    //Checks to see if the return is a NSNumber
    XCTAssert([value isKindOfClass:[NSNumber class]],@"Return type is not of type NSNumber.");
    //Assert 8
    //Checks to see if the method throws an exception if given nil
    XCTAssertThrows([self.testForecast windBearingForCompassSectors:nil],@"Failed to throw an exception.");
}

-(void)testFahrenheitToCelsius{
    id value = [self.testForecast fahrenheitToCelsius:self.testString];
    //Assert 9
    //Checks to see if the return is  string
    XCTAssert([value isKindOfClass:[NSString class]],@"Return type is not of type NSString");
    //Assert 10
    //Checks to see if the method throws an exception if given nil
    XCTAssertThrows([self.testForecast fahrenheitToCelsius:nil],@"Failed to throw an exception.");
}

-(void)testTemperatureFormatter{
    id value = [self.testForecast temperatureFormatter:self.testString];
    //Assert 11
    //Checks to see if the return is  string
    XCTAssert([value isKindOfClass:[NSString class]],@"Return type is not of type NSString");
    //Assert 12
    //Checks to see if the method throws an exception if given nil
    XCTAssertThrows([self.testForecast temperatureFormatter:nil],@"Failed to throw an exception.");
}

@end
