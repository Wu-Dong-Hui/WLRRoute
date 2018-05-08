//
//  ZPMUserViewController.m
//  ZPMRoute
//
//  Created by Neo on 2016/12/18.
//  Copyright © 2016年 Neo. All rights reserved.
//

#import "ZPMUserViewController.h"
#import <ZPMRoute/ZPMRoute.h>
@interface ZPMUserViewController ()

@property (weak, nonatomic) IBOutlet UILabel *user;

@end

@implementation ZPMUserViewController
+(BOOL)handleRequest:(ZPMRouteRequest *)request actionName:(NSString *)actionName completionHandler:(ZPMRouteCompletionHandler)completionHandler{
    UIViewController * controller = [self targetViewControllerWithRequest:request actionName:actionName completionHandler:completionHandler];
    if (!controller) {
        return NO;
    }
    controller.zpm_request = request;
    [self transitionWithTargetViewController:controller request:request actionName:actionName];
    return YES;
}
+(UIViewController *)targetViewControllerWithRequest:(ZPMRouteRequest *)request actionName:(NSString *)actionName completionHandler:(ZPMRouteCompletionHandler)completionHandler{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [story instantiateViewControllerWithIdentifier:@"ZPMUserViewController"];
    return vc;
}
+(void)transitionWithTargetViewController:(UIViewController *)ViewController request:(ZPMRouteRequest *)request actionName:(NSString *)actionName{
    UIViewController * sourceViewController =[UIApplication sharedApplication].windows[0].rootViewController;
    if ([sourceViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)sourceViewController;
        [nav pushViewController:ViewController animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * user = self.zpm_request[@"user"];
    self.user.text = user;
    self.user.userInteractionEnabled = true;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.user addGestureRecognizer:tap];
}
- (void)tap {
    ZPMRouter *userRouter = [ZPMRouter routerForScheme:@"user"];
    userRouter.shouldFallbackGlobalRouter = true;
    
    [userRouter handleURL:[NSURL URLWithString:@"/user/info"] primitiveParameters:@{} targetCallBack:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        NSLog(@"%@, %@", error, responseObject);
    } withCompletionBlock:^(BOOL handled, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    [userRouter setUnhandledURLHandler:^(ZPMRouter * _Nonnull routes, NSURL * _Nullable URL, NSDictionary<NSString *,id> * _Nullable parameters) {
        
        self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    }];
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
