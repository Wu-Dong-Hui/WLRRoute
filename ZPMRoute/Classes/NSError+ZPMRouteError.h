//
//  NSError+ZPMError.h
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZPMError) {
    
    /** The passed URL does not match a registered route. */
    ZPMErrorNotFound = 45150,
    
    /** The matched route handler does not specify a target view controller. */
    ZPMErrorHandlerTargetOrSourceViewControllerNotSpecified = 45151,
    ZPMErrorBlockHandleNoReturnRequest = 45152,
    ZPMErrorMiddlewareRaiseError = 45153,
    ZPMErrorHandleRequestError = 45154
};
@interface NSError (ZPMError)
+(NSError *)ZPMNotFoundError;
+(NSError *)ZPMTransitionError;
+(NSError *)ZPMHandleBlockNoTeturnRequest;
+(NSError *)ZPMMiddlewareRaiseErrorWithMsg:(NSString *)error;
+(NSError *)ZPMHandleRequestErrorWithMessage:(NSString *)errorMsg;
@end
