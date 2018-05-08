//
//  NSString+ZPMQuery.h
//  Pods
//
//  Created by Neo on 2016/12/16.
//
//

#import <Foundation/Foundation.h>

@interface NSString (ZPMQuery)
+ (NSString *)ZPMQueryStringWithParameters:(NSDictionary *)parameters ;
- (NSDictionary *)ZPMParametersFromQueryString ;
- (NSString *)ZPMStringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding ;
- (NSString *)ZPMStringByReplacingPercentEscapesUsingEncoding:(NSStringEncoding)encoding;
@end
