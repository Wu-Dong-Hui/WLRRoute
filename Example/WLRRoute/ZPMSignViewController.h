//
//  ZPMSignViewController.h
//  ZPMRoute
//
//  Created by Neo on 2016/12/18.
//  Copyright © 2016年 Neo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBXCALLBACKHandler.h"
@protocol HBSignModuleProtocol<HBModuleProtocol>
+(UIViewController *)signViewControllerWithPhone:(NSString *)phone;
@end
@interface ZPMSignViewController : UIViewController<HBSignModuleProtocol>

@end
