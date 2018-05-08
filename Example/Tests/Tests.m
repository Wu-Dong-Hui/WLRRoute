//
//  ZPMRouteTests.m
//  ZPMRouteTests
//
//  Created by Neo on 12/18/2016.
//  Copyright (c) 2016 Neo. All rights reserved.
//

@import XCTest;
#import <ZPMRoute/ZPMRoute.h>
#import "HBXCALLBACKHandler.h"
@interface Tests : XCTestCase
@property(nonatomic,strong)ZPMRouter * router;

@end

@implementation Tests

- (void)setUp
{
    self.router = [[ZPMRouter alloc]init];
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    self.router = [[ZPMRouter alloc]init];
    [self.router registerHandler:[[HBXCALLBACKHandler alloc]init] forRoute:@"x-call-back/:path(.*)"];
    NSURL * url = [NSURL URLWithString:@"ZPMDemo://x-call-back/user/register?x-success=ZPMDemo%3a%2f%2fx-call-back%2fuser%2fregister_success&x-error=ZPMDemo%3a%2f%2fx-call-back%2falert%26message%3dregister+fail&phone=15890077643"];
    [self.router handleURL:url primitiveParameters:nil targetCallBack:^(NSError *error, id responseObject) {
        
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        
    }];
}

@end

