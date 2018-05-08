//
//  ZPMGeneralRequest.h
//  ZPMNetworkDemo
//
//  Created by Roy on 2018/3/14.
//  Copyright © 2018年 zhaopin.com. All rights reserved.
//

#import "ZPMRequest.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZPMRequestCustomizable;

@interface ZPMGeneralRequest : ZPMRequest

- (_Nullable instancetype)initWithMethod:(ZPMRequestMethod)method path:(NSString *_Nonnull)path parms:(NSDictionary *_Nullable)params;
@property (nonatomic, strong) id <ZPMRequestCustomizable> customizable;

@end

NS_ASSUME_NONNULL_END
