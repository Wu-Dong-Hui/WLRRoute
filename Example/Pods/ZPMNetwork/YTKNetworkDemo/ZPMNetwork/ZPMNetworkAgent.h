//
//  ZPMNetworkAgent.h
//
//  Copyright (c) 2012-2016 ZPMNetwork http://gitlab.dev.zhaopin.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "ZPMBaseRequest.h"
#import "ZPMNetworkPluginManager.h"
NS_ASSUME_NONNULL_BEGIN

@class ZPMNetworkPluginManager;

@protocol ZPMNetworkGlobalHeaderProtocol

@required;
- (NSDictionary<NSString *,NSString *> *)globalHeaders;

@end

@protocol ZPMNetworkHTTPDNSProtocol

@required;
- (NSMutableURLRequest *)httpdnsFor:(NSMutableURLRequest *)mutableRequest;
- (NSString *)hostForIp:(NSString *)ip;
@end

@protocol ZPMNetworkEncryptProtocol

@required;
- (NSString *)encrypyt:(NSString *)url;

@end
@class ZPMBaseRequest;
@protocol ZPMRequestCustomizable;
///  ZPMNetworkAgent is the underlying class that handles actual request generation,
///  serialization and response handling.
@interface ZPMNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic,strong)id <ZPMNetworkGlobalHeaderProtocol> globalHeader;
@property (nonatomic,strong)id <ZPMNetworkEncryptProtocol> encrypt;
@property (nonatomic,strong) id <ZPMNetworkHTTPDNSProtocol> dns;

///  Get the shared agent.
+ (ZPMNetworkAgent *)sharedAgent;

- (void)addPlugin:(id<ZPMNetworkPluginProtocol>)plugin;
- (void)removePlugin:(id<ZPMNetworkPluginProtocol>)plugin;

///  Add request to session and start it.
- (void)addRequest:(ZPMBaseRequest *)request;

///  Cancel a request that was previously added.
- (void)cancelRequest:(ZPMBaseRequest *)request;

///  Cancel all requests that were previously added.
- (void)cancelAllRequests;

///  Return the constructed URL of request.
///
///  @param request The request to parse. Should not be nil.
///
///  @return The result URL.
- (NSString *)buildRequestUrl:(ZPMBaseRequest *)request;

#pragma mark - common

- (ZPMBaseRequest *)getService:(id <ZPMRequestCustomizable>)service url:(NSString *)url parms:(NSDictionary *)params
                       success:(ZPMRequestCompletionBlock)success
                       failure:(ZPMRequestCompletionBlock)failure;
- (ZPMBaseRequest *)postService:(id <ZPMRequestCustomizable>)service url:(NSString *)url parms:(NSDictionary *)params
                        success:(ZPMRequestCompletionBlock)success
                        failure:(ZPMRequestCompletionBlock)failure;
@end

NS_ASSUME_NONNULL_END
