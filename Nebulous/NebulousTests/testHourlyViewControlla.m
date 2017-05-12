//
//  testHourlyViewControlla.m
//  Nebulous
//
//  Created by Elyanil Liranzo Castro on 5/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HourlyWeatherViewControlla.h"

@interface testHourlyViewControlla : XCTestCase
@property(strong, nonatomic)HourlyWeatherViewControlla *testHourlyWeatherViewControlla;
@property(strong, nonatomic)NSString *testString;
@property(strong, nonatomic)NSDate *testDate;
@end

@implementation testHourlyViewControlla

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testHourlyWeatherViewControlla = [[HourlyWeatherViewControlla alloc]init];
    self.testString = [[NSString alloc]initWithString:[[NSDate date]description]];
    self.testDate = [[NSDate alloc] initWithTimeIntervalSinceNow:NSTimeIntervalSince1970];
}

- (void)tearDown {
    self.testHourlyWeatherViewControlla = nil;
    self.testString = nil;
    self.testDate = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFormatDate{
    id value = [self.testHourlyWeatherViewControlla formatDate:self.testDate];
    //Assert 3
    //Checks to see if the return is a string
    XCTAssert([value isKindOfClass:[NSString class]],@"Return is not a string");
    
    //Assert 4
    //Checks to see if method throws an exception if given nil
    XCTAssertThrows([self.testHourlyWeatherViewControlla formatDate:nil],@"Failed to throw an exception");
}

-(void)testUnixTimeStampToNSDate{
    id value = [self.testHourlyWeatherViewControlla unixTimeStampToNSDate:self.testString];
    //Assert 5
    //Checks to see if the return is a string
    XCTAssert([value isKindOfClass:[NSString class]],@"Return is not a string");
    //Assert 6
    //Checks to see if method throws an exception if given nil
    XCTAssertThrows([self.testHourlyWeatherViewControlla unixTimeStampToNSDate:nil],@"Failed to throw an exception");
}

@end
