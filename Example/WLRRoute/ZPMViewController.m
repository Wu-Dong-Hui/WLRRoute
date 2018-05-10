//
//  ZPMViewController.m
//  ZPMRoute
//
//  Created by Neo on 12/18/2016.
//  Copyright (c) 2016 Neo. All rights reserved.
//

#import "ZPMViewController.h"
#import <ZPMRoute/ZPMRoute.h>
#import "ZPMAppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <ZPMNetwork/ZPMNetwork.h>
#import "ZPMService.h"
#import "ZPMResumeWebViewController.h"

@interface ZPMViewController ()<ZPMRouteMiddleware, ZPMRouteInterceptor>
@property(nonatomic,weak)ZPMRouter * router;


@property (nonatomic, copy) NSArray *falsifyURLs;
@end

@implementation ZPMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.router = [ZPMRouter globalRouter];
    [self.router addInterceptor:self];
	// Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    
    [[ZPMNetworkAgent sharedAgent] getService:[[ZPMService alloc] init] url:@"route_config" parms:@{} success:^(__kindof ZPMBaseRequest * _Nonnull request) {
        NSLog(@"success %@", request.responseObject);
        weakSelf.falsifyURLs = [request.responseObject copy];
    } failure:^(__kindof ZPMBaseRequest * _Nonnull request) {
        NSLog(@"fail %@", request.error);
    }];
    
    
    
}
-(NSDictionary *)middlewareHandleRequestWith:(ZPMRouteRequest *__autoreleasing *)primitiveRequest error:(NSError *__autoreleasing *)error{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.router removeMiddleware:self];
    });
    return nil;
    //test:
//    *error = [NSError ZPMMiddlewareRaiseErrorWithMsg:[NSString stringWithFormat:@"%@ raise error",NSStringFromClass([self class])]];
//    return @{@"result":@"yes"};
}
- (IBAction)userClick:(UIButton *)sender {
    [self.router handleURL:[NSURL URLWithString:@"/user"] primitiveParameters:@{@"user":@"Neo~🙃🙃"} targetCallBack:^(NSError *error, id responseObject) {
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
    
    [self.router handleURL:[NSURL URLWithString:@"ZPMDemo://x-call-back/signin?x-success=ZPMDemo%3A%2F%2Fx-call-back%2Fuser&phone=17621425586"] primitiveParameters:nil targetCallBack:^(NSError *error, id responseObject) {
        NSLog(@"SiginClick %@", responseObject);
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"SiginHandleCompletion %@", error);
    }];
    
    
    */
}
- (IBAction)go2resumeDetail:(UIButton *)sender {
    ZPMResumeWebViewController *vc = [[ZPMResumeWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ZPMRouteInterceptor
- (void)router:(ZPMRouter *)router willHandleURL:(NSURL *)URL {
    NSLog(@"ZPMRouteInterceptor~router:%@, ~willHandleURL:%@", router, URL);
}
- (void)router:(ZPMRouter *)router willHandleURL:(NSURL *)URL request:(ZPMRouteRequest *)request {
    NSLog(@"ZPMRouteInterceptor~router:%@, ~willHandleURL:%@, ~request:%@", router, URL, request);
}
- (void)router:(ZPMRouter *)router willFallbackGlobalRouterForURL:(NSURL *)URL {
    NSLog(@"ZPMRouteInterceptor~router:%@, ~willFallbackGlobalRouterForURL:%@", router, URL);
}
- (void)router:(ZPMRouter *)router didSuccessHandleURL:(NSURL *)URL {
    NSLog(@"ZPMRouteInterceptor~router:%@, ~didSuccessHandleURL:%@", router, URL);
}
- (void)router:(ZPMRouter *)router didFailHandleURL:(NSURL *)URL {
    NSLog(@"ZPMRouteInterceptor~router:%@, ~didFailHandleURL:%@", router, URL);
}
- (NSURL *)router:(ZPMRouter *)router falsifyURL:(NSURL *)originURL {
    for (NSDictionary *dic in self.falsifyURLs) {
        if ([[dic objectForKey:@"originPath"] isEqualToString:originURL.absoluteString]) {
            return [NSURL URLWithString:[dic objectForKey:@"newPath"]];
        }
    }
    return originURL;
}
@end
