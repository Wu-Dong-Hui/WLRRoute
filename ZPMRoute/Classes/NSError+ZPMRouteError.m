//
//  NSError+ZPMError.m
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import "NSError+ZPMRouteError.h"
NSString * const ZPMErrorDomain = @"com.ZPMroute.error";

@implementation NSError (ZPMError)
+(NSError *)ZPMNotFoundError{
    return [self ZPMErrorWithCode:ZPMErrorNotFound msg:@"The passed URL does not match a registered route."];
}
+(NSError *)ZPMTransitionError{

    return [self ZPMErrorWithCode:ZPMErrorHandlerTargetOrSourceViewControllerNotSpecified msg:@"TargetViewController or SourceViewController not correct"];
}
+(NSError *)ZPMHandleBlockNoTeturnRequest
{
    return [self ZPMErrorWithCode:ZPMErrorBlockHandleNoReturnRequest msg:@"Block handle no turn ZPMRouteRequest object"];
}

+(NSError *)ZPMMiddlewareRaiseErrorWithMsg:(NSString *)error{
    return [self ZPMErrorWithCode:ZPMErrorMiddlewareRaiseError msg:[NSString stringWithFormat:@"ZPMRouteMiddle raise a error:%@",error]];
}
+(NSError *)ZPMHandleRequestErrorWithMessage:(NSString *)errorMsg;
{
    return [self ZPMErrorWithCode:ZPMErrorHandleRequestError msg:[NSString stringWithFormat:@"ZPMHandler raise a error:%@",errorMsg]];
}
+(NSError *)ZPMErrorWithCode:(NSInteger)code msg:(NSString *)msg{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(msg, nil) };
    return [NSError errorWithDomain:ZPMErrorDomain code:code userInfo:userInfo];
}
@end
