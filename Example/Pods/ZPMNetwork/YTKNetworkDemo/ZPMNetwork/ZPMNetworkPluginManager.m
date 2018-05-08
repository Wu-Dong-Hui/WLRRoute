//
//  ZPMNetworkPluginManager.m
//  iOSShare
//
//  Created by pchen on 2018/3/12.
//  Copyright © 2018年 wujin. All rights reserved.
//

#import "ZPMNetworkPluginManager.h"
@interface ZPMNetworkPluginManager()

@property (nonatomic,strong)NSMutableArray *arrayPlus;


@end

@implementation ZPMNetworkPluginManager

- (instancetype)init {
    
    if (self = [super init]) {
        self.arrayPlus = [NSMutableArray array];
    }
    return self;
}

- (void)addPlus:(id<ZPMNetworkPluginProtocol>)plus {
    
    [_arrayPlus addObject:plus];
 
}

- (void)removePlus:(id<ZPMNetworkPluginProtocol>)plus {
    
    [_arrayPlus removeObject:plus];
}


///  Inform the accessory that the request is about to start.
///
///  @param request The corresponding request.
- (void)requestWillStart:(id)request {
    
    for (id plus in self.arrayPlus) {
        if ([plus respondsToSelector:@selector(requestWillStart:)] && [plus respondsToSelector:@selector(isRun)]) {
            if ([plus isRun]) {
              [plus requestWillStart:request];
            }
        }
    }
}

///  Inform the accessory that the request is about to stop. This method is called
///  before executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestWillStop:(id)request {
    
    for (id plus in self.arrayPlus) {
        if ([plus respondsToSelector:@selector(requestWillStop:)] && [plus respondsToSelector:@selector(isRun)]) {
            if ([plus isRun]) {
                [plus requestWillStop:request];
            }
        }
    }

}

///  Inform the accessory that the request has already stoped. This method is called
///  after executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestDidStop:(id)request {
    
    for (id plus in self.arrayPlus) {
        if ([plus respondsToSelector:@selector(requestDidStop:)] && [plus respondsToSelector:@selector(isRun)]) {
            if ([plus isRun]) {
                [plus requestDidStop:request];
            }
        }
    }
}



@end
