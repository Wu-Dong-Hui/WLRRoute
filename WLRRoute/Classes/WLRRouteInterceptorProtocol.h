//
//  WLRRouteInterceptorProtocol.h
//  WLRRoute
//
//  Created by Roy on 2018/5/4.
//

#import <Foundation/Foundation.h>
@class WLRRouter, WLRRouteRequest;

@protocol WLRRouteInterceptor <NSObject>
@optional
- (void)router:(WLRRouter *)router willHandleURL:(NSURL *)URL;
- (void)router:(WLRRouter *)router willHandleURL:(NSURL *)URL request:(WLRRouteRequest *)request;
- (void)router:(WLRRouter *)router willFallbackGlobalRouterForURL:(NSURL *)URL;
- (void)router:(WLRRouter *)router didSuccessHandleURL:(NSURL *)URL;
- (void)router:(WLRRouter *)router didFailHandleURL:(NSURL *)URL;

@end

