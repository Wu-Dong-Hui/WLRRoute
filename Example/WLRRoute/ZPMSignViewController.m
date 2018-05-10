//
//  ZPMSignViewController.m
//  ZPMRoute
//
//  Created by Neo on 2016/12/18.
//  Copyright © 2016年 Neo. All rights reserved.
//

#import "ZPMSignViewController.h"
#import <ZPMRoute/ZPMRoute.h>
#import "ZPMAppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ZPMSignViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Phone;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ZPMSignViewController
#pragma mark -Module Protocol impl
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
    UIViewController * vc = [self signViewControllerWithPhone:request[@"phone"]];
    return vc;
}
+(UIViewController *)signViewControllerWithPhone:(NSString *)phone{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZPMSignViewController * vc = [story instantiateViewControllerWithIdentifier:@"ZPMSignViewController"];
    vc.Phone.text = phone;
    return vc;
}
+(void)transitionWithTargetViewController:(UIViewController *)ViewController request:(ZPMRouteRequest *)request actionName:(NSString *)actionName{
    UIViewController * sourceViewController =[UIApplication sharedApplication].windows[0].rootViewController;
    if ([sourceViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)sourceViewController;
        [nav pushViewController:ViewController animated:YES];
    }
}
- (IBAction)go:(UIButton *)sender {
    /*
//    ZPMRouter *router = ((ZPMAppDelegate *)[UIApplication sharedApplication].delegate).router;
    ZPMRouter *router = [ZPMRouter globalRouter];
    router.shouldFallbackGlobalRouter = true;
    [router handleURL:[NSURL URLWithString:@"/resume/detail"] primitiveParameters:nil targetCallBack:^(NSError *err, id responseObject) {
        
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        
    }];
    */
    
    [SVProgressHUD showWithStatus:@"登录中"];
    [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:3];
    
}

- (void)loginSuccess {
    self.zpm_request.targetCallBack(nil, @{@"userid": @"283773"});
    [self.navigationController popViewControllerAnimated:true];
//    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.Phone.text = self.zpm_request[@"phone"];
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
