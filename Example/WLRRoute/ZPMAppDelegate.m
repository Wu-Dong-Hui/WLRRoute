//
//  ZPMAppDelegate.m
//  ZPMRoute
//
//  Created by Neo on 12/18/2016.
//  Copyright (c) 2016 Neo. All rights reserved.
//

#import "ZPMAppDelegate.h"
#import <ZPMRoute/ZPMRoute.h>
#import "ZPMSignHandler.h"
#import "ZPMUserHandler.h"
#import "HBXCALLBACKHandler.h"
#import "ZPMSignViewController.h"
#import "ZPMResumeViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ZPMMiddleware: NSObject <ZPMRouteMiddleware>

@end

@implementation ZPMMiddleware
- (NSDictionary *)middlewareHandleRequestWith:(ZPMRouteRequest *__autoreleasing *)primitiveRequest error:(NSError *__autoreleasing *)error {
    return @{@"key": @"value"};
}
@end


@interface ZPMAppDelegate()
@end
@implementation ZPMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 100)];
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    
    ZPMRouter *router = [ZPMRouter globalRouter];
    [router registerHandler:[[ZPMSignHandler alloc]init] forRoute:@"/signin/:phone([0-9]+)"];
    [router registerHandler:[[ZPMUserHandler alloc]init] forRoute:@"/user"];
    
    
    /*
    [self.router addMiddleware:[[ZPMMiddleware alloc] init]];
    
    HBXCALLBACKHandler * x_call_back_handler =[[HBXCALLBACKHandler alloc]init];
    x_call_back_handler.enableException = YES;
    Class signModuleImplClass = NSClassFromString(@"ZPMSignViewController");
    Class userModuleImplClass = NSClassFromString(@"ZPMUserViewController");
    
    [x_call_back_handler registeModuleProtocol:@protocol(HBSignModuleProtocol) implClass:signModuleImplClass forActionName:@"/signin"];
    [x_call_back_handler registeModuleProtocol:@protocol(HBModuleProtocol) implClass:userModuleImplClass forActionName:@"/user"];
    [self.router registerHandler:x_call_back_handler forRoute:@"x-call-back/:path(.*)"];
    x_call_back_handler.router = self.router;
    
    
    */
    
    
    [router setUnhandledURLHandler:^(ZPMRouter * _Nonnull routes, NSURL * _Nullable URL, NSDictionary<NSString *,id> * _Nullable parameters) {
        NSLog(@"%@, %@, %@", routes, URL, parameters);
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"can not handle the URL %@", URL.absoluteString]];
    }];
    
    
    
    
    
    
    [router registerBlock:^ZPMRouteRequest *(ZPMRouteRequest *request) {
        ZPMResumeViewController *vc = [[ZPMResumeViewController alloc] init];
        vc.zpm_request = request;
        [(UINavigationController *)self.window.rootViewController pushViewController:vc animated:true];
        return request;
    } forRoute:@"/resume/detail"];
    
    
    
//    for (int i = 0; i < 10; i++) {
//        [self performSelector:@selector(thread) withObject:nil afterDelay:3];
//        [self performSelector:@selector(registerRouter:) withObject:[NSString stringWithFormat:@"/path/%@", [NSNumber numberWithInt:i]] afterDelay:2];
//    }
    
#pragma mark - 16.用户收到推送则打开对应的页面，如职位详情
    /*
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    
    
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    noti.timeZone = [NSTimeZone defaultTimeZone];
    noti.applicationIconBadgeNumber = 1;
    noti.soundName = UILocalNotificationDefaultSoundName;
    noti.alertTitle = @"title";
    noti.alertBody = @"body";
    noti.userInfo = @{@"path": @"resume", @"id": @"123456"};
    [application scheduleLocalNotification:noti];
    */
    
    return YES;
}

- (void)registerRouter:(NSString *)path {
    dispatch_async(dispatch_queue_create([path cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_CONCURRENT), ^{
        [[ZPMRouter globalRouter] registerHandler:[[ZPMUserHandler alloc] init] forRoute:path];
    });
}
- (void)thread {
    NSString *name = [NSString stringWithFormat:@"com.zhaopin.r%u", arc4random()];
    dispatch_async(dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_CONCURRENT), ^{
        [ZPMRouter routerForScheme:name];
    });
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification.userInfo && notification.userInfo[@"path"] && notification.userInfo[@"id"]) {
        if ([notification.userInfo[@"path"] isEqualToString:@"resume"]) {
            [[ZPMRouter globalRouter] handleURL:[NSURL URLWithString:@"/resume/detail"] primitiveParameters:notification.userInfo targetCallBack:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
                
            } withCompletionBlock:^(BOOL handled, NSError * _Nonnull error) {
                
            }];
        }
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
#pragma mark - 15.在浏览器打开智联相关链接，如果手机上有安装APP，则打开APP的相关页面，如职位详情
    // ZPMRouteDemo://zhaopin.com/resume/detail?id=123456
    if (url && url.host && url.path.length > 0) {
        NSLog(@"url: %@, host: %@, pathComponts: %@, query: %@\n", url, url.host, url.pathComponents, url.query);
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        for (NSURLQueryItem *qitem in [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:false].queryItems) {
            NSLog(@"%@ = %@", qitem.name, qitem.value);
            params[qitem.name] = qitem.value;
        }
        
        
        if ([url.pathComponents containsObject:@"resume"]) {
            [[ZPMRouter globalRouter] handleURL:[NSURL URLWithString:@"/resume/detail"] primitiveParameters:[params copy] targetCallBack:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
                
            } withCompletionBlock:^(BOOL handled, NSError * _Nonnull error) {
                
            }];
        }
    }
    return true;
}

@end
