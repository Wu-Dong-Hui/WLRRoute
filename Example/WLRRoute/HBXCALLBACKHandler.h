//
//  HBXCALLBACKHandler.h
//  ZPMRoute_Example
//
//  Created by Neo on 2018/4/11.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "ZPMRouteHandler.h"
#import <ZPMRoute/ZPMRouteRequest.h>
@protocol  HBModuleProtocol<NSObject>
+(BOOL)handleRequest:(ZPMRouteRequest *)request actionName:(NSString *)actionName completionHandler:(ZPMRouteCompletionHandler)completionHandler;
@optional
+(UIViewController *)targetViewControllerWithRequest:(ZPMRouteRequest *)request actionName:(NSString *)actionName completionHandler:(ZPMRouteCompletionHandler)completionHandler;
+(void)transitionWithTargetViewController:(UIViewController *)ViewController request:(ZPMRouteRequest *)request actionName:(NSString *)actionName;
@end
@class ZPMRouter;
@interface HBXCALLBACKHandler : ZPMRouteHandler
@property(nonatomic,weak)ZPMRouter * router;
@property(nonatomic)BOOL enableException;
-(void)registeModuleProtocol:(Protocol *)moduleProtocol implClass:(Class)implClass forActionName:(NSString *)actionName;
@end
