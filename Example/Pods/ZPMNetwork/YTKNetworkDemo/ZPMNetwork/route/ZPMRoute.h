//
//  ZPMRoute.h
//  YTKNetworkDemo
//
//  Created by pchen on 2018/4/26.
//  Copyright © 2018年 yuantiku.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZPMRoute : NSObject

@property (nonatomic,strong)UINavigationController *nav;

+ (instancetype)sharedRoute;

- (void)gotoResume;

- (void)gotoHomePage;

- (void)registe:(UIViewController *(^)())block  key:(NSString *)key ;

@end
