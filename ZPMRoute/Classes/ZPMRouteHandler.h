//
//  ZPMRouteHandler.h
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import <Foundation/Foundation.h>
@class ZPMRouteRequest;
/**
 This is a handler object, if a ZPMRouteRequest object matched, ZPMRouter object will invoke shouldHandleWithRequest、handleRequest method and transitionWithWithRequest method,you can overwrite some method to complete viewcontroller transition.
 ZPMRouteHandler对象与ZPMRouteMatcher对象相对应，如果一个ZPMRouteRequest对象匹配到该handler对象，则ZPMRouter将触发 handleRequest 方法和transitionWithWithRequest方法，完成一次视图控制器的转场.
 */
@interface ZPMRouteHandler : NSObject
- (BOOL)shouldHandleWithRequest:(ZPMRouteRequest *)request;
-(UIViewController *)targetViewControllerWithRequest:(ZPMRouteRequest *)request;
-(UIViewController *)sourceViewControllerForTransitionWithRequest:(ZPMRouteRequest *)request;
-(BOOL)handleRequest:(ZPMRouteRequest *)request error:(NSError *__autoreleasing *)error;
-(BOOL)transitionWithWithRequest:(ZPMRouteRequest *)request sourceViewController:(UIViewController *)sourceViewController targetViewController:(UIViewController *)targetViewController isPreferModal:(BOOL)isPreferModal error:(NSError *__autoreleasing *)error;
- (BOOL)preferModalPresentationWithRequest:(ZPMRouteRequest *)request;
@end
