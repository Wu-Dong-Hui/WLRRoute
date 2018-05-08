//
//  ZPMRouteHandler.m
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import "ZPMRouteHandler.h"
#import "ZPMMatchResult.h"
#import "UIViewController+ZPMRoute.h"
#import "NSError+ZPMRouteError.h"
@implementation ZPMRouteHandler
-(BOOL)shouldHandleWithRequest:(ZPMRouteRequest *)request{
    return YES;
}
-(UIViewController *)targetViewControllerWithRequest:(ZPMRouteRequest *)request{

    return [[NSClassFromString(@"HBTestViewController") alloc]init];
}
-(UIViewController *)sourceViewControllerForTransitionWithRequest:(ZPMRouteRequest *)request{
    return [UIApplication sharedApplication].windows[0].rootViewController;
}
-(BOOL)handleRequest:(ZPMRouteRequest *)request error:(NSError *__autoreleasing *)error{
    UIViewController * sourceViewController = [self sourceViewControllerForTransitionWithRequest:request];
    UIViewController * targetViewController = [self targetViewControllerWithRequest:request];
    if ((![sourceViewController isKindOfClass:[UIViewController class]])||(![targetViewController isKindOfClass:[UIViewController class]])) {
        *error = [NSError ZPMTransitionError];
        return NO;
    }
    if (targetViewController != nil) {
        targetViewController.zpm_request = request;
    }
    BOOL isPreferModal = [self preferModalPresentationWithRequest:request];
    return [self transitionWithWithRequest:request sourceViewController:sourceViewController targetViewController:targetViewController isPreferModal:isPreferModal error:error];
}
-(BOOL)transitionWithWithRequest:(ZPMRouteRequest *)request sourceViewController:(UIViewController *)sourceViewController targetViewController:(UIViewController *)targetViewController isPreferModal:(BOOL)isPreferModal error:(NSError *__autoreleasing *)error{
    if (isPreferModal||![sourceViewController isKindOfClass:[UINavigationController class]]) {
        [sourceViewController presentViewController:targetViewController animated:YES completion:nil];
    }
    else if ([sourceViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)sourceViewController;
        [nav pushViewController:targetViewController animated:YES];
    }
    return YES;
}

- (BOOL)preferModalPresentationWithRequest:(ZPMRouteRequest *)request;{
    return NO;
}
@end
