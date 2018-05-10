//
//  ZPMResumeWebViewController.m
//  WLRRoute_Example
//
//  Created by Roy on 2018/5/10.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "ZPMResumeWebViewController.h"
#import <WebKit/WebKit.h>
#import <ZPMRoute/ZPMRoute.h>

@interface ZPMResumeWebViewController () <WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webview;
@end

@implementation ZPMResumeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webview];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"resumeDetail" withExtension:@"html"];
    [self.webview loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    [config.userContentController addScriptMessageHandler:self name:@"goToResumeDetail"];
    
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@", message);
    if ([message.name isEqualToString:@"goToResumeDetail"]) {
        [[ZPMRouter globalRouter] handleURL:[NSURL URLWithString:@"/resume/detail"] primitiveParameters:message.body targetCallBack:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
            
        } withCompletionBlock:^(BOOL handled, NSError * _Nonnull error) {
            
        }];
    }
}


- (void)dealloc {
    [self.webview.configuration.userContentController removeScriptMessageHandlerForName:@"goToResumeDetail"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
