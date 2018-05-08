//
//  GeneralRequest.m
//  ZPMNetworkDemo
//
//  Created by Roy on 2018/3/14.
//  Copyright © 2018年 zhaopin.com. All rights reserved.
//

#import "ZPMGeneralRequest.h"
#import "ZPMNetworkPrivate.h"
#import "ZPMRequestCustomizable.h"

@implementation ZPMGeneralRequest {
    NSString *_url;
    NSDictionary *_params;
    ZPMRequestMethod _method;
}

- (instancetype)initWithMethod:(ZPMRequestMethod)method path:(NSString *)path parms:(NSDictionary *)params {
    if (self = [super init]) {
        _params = params;
        _url = path;
        _method = method;
    }
    return self;
}
- (ZPMRequestMethod)requestMethod {
    return _method;
}
- (NSString *)baseUrl {
    if (self.customizable && [self.customizable respondsToSelector:@selector(baseUrl)]) {
        return [self.customizable baseUrl];
    }
    return @"https://apiapp.zhaopin.com/";
}
- (ZPMRequestSerializerType)requestSerializerType {
    return ZPMRequestSerializerTypeHTTP;
}
- (ZPMResponseSerializerType)responseSerializerType {
    return ZPMResponseSerializerTypeJSON;
}
- (id)requestArgument {
    return _params;
}
- (NSString *)requestUrl {
    return _url;
}
- (BOOL)statusCodeValidator {
    if (self.customizable && [self.customizable respondsToSelector:@selector(isStatusCodeValid:)]) {
        return [self.customizable isStatusCodeValid:self];
    }
    return [super statusCodeValidator];
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    if (self.customizable && [self.customizable respondsToSelector:@selector(addtionalHttpHeaders)]) {
        return [self.customizable addtionalHttpHeaders];
    }
    return [super requestHeaderFieldValueDictionary];
}
- (void)dealloc {
    ZPMNetworkLog(@"%@ dealloc", self.classForCoder);
}
@end

