//
//  ZPMRequestCustomizable.h
//  ZPMNetworkDemo
//
//  Created by Roy on 2018/3/14.
//  Copyright © 2018年 zhaopin.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZPMBaseRequest;

@protocol ZPMRequestCustomizable <NSObject>
- (NSString *)baseUrl;

@optional
- (BOOL)isStatusCodeValid:(ZPMBaseRequest *)req;
- (NSDictionary<NSString *,NSString *> *)addtionalHttpHeaders;
@end

