//
//  ZPMRoute.m
//  YTKNetworkDemo
//
//  Created by pchen on 2018/4/26.
//  Copyright © 2018年 yuantiku.com. All rights reserved.
//

#import "ZPMRoute.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZPMRoute()

@property (nonatomic,strong)NSMutableDictionary *dicM;

@end

@implementation ZPMRoute

static ZPMRoute *sharedInstance = nil;
+ (instancetype)sharedRoute; {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.dicM = [NSMutableDictionary dictionary];
    });
    return sharedInstance;
}

- (void)registe:(UIViewController *(^)())block  key:(NSString *)key  {
    [_dicM setObject:block forKey:key];
}

- (void)gotoResume{
    UIViewController *(^block)() = _dicM[@"resume"];
    UIViewController *view =block();
    [self.nav pushViewController:view animated:YES];
}

- (void)gotoHomePage{
    UIViewController *(^block)() = _dicM[@"home"];
    UIViewController *view =block();
    [self.nav pushViewController:view animated:YES];
}



@end
