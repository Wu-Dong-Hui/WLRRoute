//
//  ZPMRouteInterceptorProtocol.h
//  ZPMRoute
//
//  Created by Roy on 2018/5/4.
//

#import <Foundation/Foundation.h>
@class ZPMRouter, ZPMRouteRequest;

@protocol ZPMRouteInterceptor <NSObject>
@optional
- (void)router:(ZPMRouter *)router willHandleURL:(NSURL *)URL;
- (void)router:(ZPMRouter *)router willHandleURL:(NSURL *)URL request:(ZPMRouteRequest *)request;
- (void)router:(ZPMRouter *)router willFallbackGlobalRouterForURL:(NSURL *)URL;
- (void)router:(ZPMRouter *)router didSuccessHandleURL:(NSURL *)URL;
- (void)router:(ZPMRouter *)router didFailHandleURL:(NSURL *)URL;
- (NSURL *)router:(ZPMRouter *)router falsifyURL:(NSURL *)originURL;
@end

