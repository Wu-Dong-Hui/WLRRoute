//
//  UIViewController+ZPMRoute.h
//  Pods
//
//  Created by Neo on 2016/12/16.
//
//

#import <UIKit/UIKit.h>
@class ZPMRouteRequest;
@interface UIViewController (ZPMRoute)
@property(nonatomic,strong)ZPMRouteRequest * zpm_request;
@end
