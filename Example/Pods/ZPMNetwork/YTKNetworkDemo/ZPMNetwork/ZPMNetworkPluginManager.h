//
//  ZPMNetworkPluginManager.h
//  iOSShare
//
//  Created by pchen on 2018/3/12.
//  Copyright © 2018年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZPMNetworkPluginProtocol

@optional

- (BOOL)isRun;

///  Inform the accessory that the request is about to start.
///
///  @param request The corresponding request.
- (void)requestWillStart:(id)request;

///  Inform the accessory that the request is about to stop. This method is called
///  before executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestWillStop:(id)request;

///  Inform the accessory that the request has already stoped. This method is called
///  after executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestDidStop:(id)request;



@end


@interface ZPMNetworkPluginManager : NSObject<ZPMNetworkPluginProtocol>

- (void)addPlus:(id<ZPMNetworkPluginProtocol>)plus;

- (void)removePlus:(id<ZPMNetworkPluginProtocol>)plus;


@end
