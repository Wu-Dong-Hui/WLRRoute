//
//  ZPMRegularExpression.h
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import <Foundation/Foundation.h>
@class ZPMMatchResult;
/**
    This object is a regularExpression,it can match a url and return the result with ZPMMatchResult object.
 */
@interface ZPMRegularExpression : NSRegularExpression

/**
 This method can return a ZPMMatchResult object to check a url string is matched.

 @param string a url string
 @return matching result
 */
-(ZPMMatchResult *)matchResultForString:(NSString *)string;
+(ZPMRegularExpression *)expressionWithPattern:(NSString *)pattern;
@end
