//
//  ZPMSignHandler.m
//  ZPMRoute
//
//  Created by Neo on 2016/12/18.
//  Copyright © 2016年 Neo. All rights reserved.
//

#import "ZPMSignHandler.h"

@implementation ZPMSignHandler
-(UIViewController *)targetViewControllerWithRequest:(ZPMRouteRequest *)request{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [story instantiateViewControllerWithIdentifier:@"ZPMSignViewController"];
    return vc;
}
@end
