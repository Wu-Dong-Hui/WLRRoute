//
//  WLRViewController.m
//  WLRRoute
//
//  Created by Neo on 12/18/2016.
//  Copyright (c) 2016 Neo. All rights reserved.
//

#import "WLRViewController.h"
#import <WLRRoute/WLRRoute.h>
#import "WLRAppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <WLRRoute/WLRRouteInterceptorProtocol.h>

@interface WLRViewController ()<WLRRouteMiddleware, WLRRouteInterceptor>
@property(nonatomic,weak)WLRRouter * router;
@end

@implementation WLRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.router = ((WLRAppDelegate *)[UIApplication sharedApplication].delegate).router;
    [self.router addInterceptor:self];
	// Do any additional setup after loading the view, typically from a nib.
}
-(NSDictionary *)middlewareHandleRequestWith:(WLRRouteRequest *__autoreleasing *)primitiveRequest error:(NSError *__autoreleasing *)error{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.router removeMiddleware:self];
    });
    return nil;
    //test:
//    *error = [NSError WLRMiddlewareRaiseErrorWithMsg:[NSString stringWithFormat:@"%@ raise error",NSStringFromClass([self class])]];
//    return @{@"result":@"yes"};
}
- (IBAction)userClick:(UIButton *)sender {
    [self.router handleURL:[NSURL URLWithString:@"WLRDemo://com.wlrroute.demo/user"] primitiveParameters:@{@"user":@"Neo~🙃🙃"} targetCallBack:^(NSError *error, id responseObject) {
        NSLog(@"UserCallBack %@", responseObject);
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"UserHandleCompletion %@", error);
    }];
    
}
- (IBAction)SiginClick:(UIButton *)sender {
    [self.router handleURL:[NSURL URLWithString:@"/signin/13366376114"] primitiveParameters:@{} targetCallBack:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        if (responseObject && [responseObject objectForKey:@"userid"]) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@", responseObject[@"userid"]]];
        }
    } withCompletionBlock:^(BOOL handled, NSError * _Nonnull error) {
        
    }];
    
    /*
    
    [self.router handleURL:[NSURL URLWithString:@"WLRDemo://x-call-back/signin?x-success=WLRDemo%3A%2F%2Fx-call-back%2Fuser&phone=17621425586"] primitiveParameters:nil targetCallBack:^(NSError *error, id responseObject) {
        NSLog(@"SiginClick %@", responseObject);
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"SiginHandleCompletion %@", error);
    }];
    
    
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WLRRouteInterceptor
- (void)router:(WLRRouter *)router willHandleURL:(NSURL *)URL {
    NSLog(@"WLRRouteInterceptor~router:%@, ~willHandleURL:%@", router, URL);
}
- (void)router:(WLRRouter *)router willHandleURL:(NSURL *)URL request:(WLRRouteRequest *)request {
    NSLog(@"WLRRouteInterceptor~router:%@, ~willHandleURL:%@, ~request:%@", router, URL, request);
}
- (void)router:(WLRRouter *)router willFallbackGlobalRouterForURL:(NSURL *)URL {
    NSLog(@"WLRRouteInterceptor~router:%@, ~willFallbackGlobalRouterForURL:%@", router, URL);
}
- (void)router:(WLRRouter *)router didSuccessHandleURL:(NSURL *)URL {
    NSLog(@"WLRRouteInterceptor~router:%@, ~didSuccessHandleURL:%@", router, URL);
}
- (void)router:(WLRRouter *)router didFailHandleURL:(NSURL *)URL {
    NSLog(@"WLRRouteInterceptor~router:%@, ~didFailHandleURL:%@", router, URL);
}
@end
