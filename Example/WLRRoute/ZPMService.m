//
//  ZPMService.m
//  WLRRoute_Example
//
//  Created by Roy on 2018/5/9.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "ZPMService.h"

@implementation ZPMService
- (NSString *)baseUrl {
    return @"http://127.0.0.1:3000/";
}
- (BOOL)isStatusCodeValid:(ZPMBaseRequest *)req {
    return true;
}
@end
