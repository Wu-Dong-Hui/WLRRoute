//
//  ZPMRouter.h
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import <Foundation/Foundation.h>
#import "ZPMRouteMiddlewareProtocol.h"
#import "ZPMRouteInterceptorProtocol.h"

@class ZPMRouteRequest;
@class ZPMRouteHandler;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const ZPMRouterGlobalRouteScheme;

/**
 Main route object,it can register a route pattern for a handler or block,manage middlewares,provide Subscription.
 路由对象实体，提供注册route表达式和对应handler、block功能，提供中间件注册，提供下标访问的快捷方法
 */
@interface ZPMRouter : NSObject


/// 私有化实例化方法，请使用routerForScheme:
- (instancetype)init NS_UNAVAILABLE;

/// 私有化实例化方法，请使用routerForScheme:
+ (instancetype)new NS_UNAVAILABLE;

/**
 当前路由不匹配时，是否使用全局路由匹配 默认为NO
 */
@property (nonatomic, assign) BOOL shouldFallbackGlobalRouter;


/**
 未匹配url回调的block
 */
@property (nonatomic, copy, nullable) void (^unhandledURLHandler)(ZPMRouter *routes, NSURL *__nullable URL, NSDictionary<NSString *, id> *__nullable parameters);
/**
 全局router
 */
+ (instancetype)globalRouter;

/**
 使用 scheme 初始化一个路由

 @param scheme 指定的scheme
 @return 实例化的scheme
 */
+ (instancetype)routerForScheme:(NSString *)scheme;


/**
 是否可以匹配url

 @param url 需要匹配的url
 @return 是否匹配
 */
+ (BOOL)canHandleURL:(NSURL *)url;


/**
 匹配一个路由，遍历所有scheme

 @param url 需要匹配的url
 @return 是否匹配
 */
+ (BOOL)handleURL:(NSURL *)url;

/**
 处理url请求
 
 @param URL 调用的url
 @param primitiveParameters 携带的原生对象
 @param targetCallBack 传给目标对象的回调block
 @param completionBlock 完成路由中转的block
 @return 是否能够handle
 */
+ (BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void(^)(NSError *error, id responseObject))targetCallBack withCompletionBlock:(void(^)(BOOL handled, NSError *error))completionBlock;
/**
 注册一个route表达式并与一个block处理相关联
 
 @param routeHandlerBlock block用以处理匹配route表达式的url的请求
 @param route url的路由表达式，支持正则表达式的分组，例如app://login/:phone({0,9+})是一个表达式，:phone代表该路径值对应的key,可以在ZPMRouteRequest对象中的routeParameters中获取
 */
-(void)registerBlock:(ZPMRouteRequest *(^)(ZPMRouteRequest * request))routeHandlerBlock forRoute:(NSString *)route;
/**
 注册一个route表达式并与一个block处理相关联
 
 @param handler handler对象用以处理匹配route表达式的url的请求
 @param route url的路由表达式，支持正则表达式的分组，例如app://login/:phone({0,9+})是一个表达式，:phone代表该路径值对应的key,可以在ZPMRouteRequest对象中的routeParameters中获取
 */
-(void)registerHandler:(ZPMRouteHandler *)handler forRoute:(NSString *)route;

/**
 检测url是否能够被处理，不包含中间件的检查

 @param url 请求的url
 @return 是否可以handle
 */
-(BOOL)canHandleWithURL:(NSURL *)url;

/**
 下标方式添加

 @param obj 对象
 @param key 键值
 */
-(void)setObject:(id)obj forKeyedSubscript:(NSString *)key;

/**
 下标方式获取

 @param key 键值
 @return key对应的对象
 */
-(id)objectForKeyedSubscript:(NSString *)key;

/**
 处理url请求

 @param URL 调用的url
 @param primitiveParameters 携带的原生对象
 @param targetCallBack 传给目标对象的回调block
 @param completionBlock 完成路由中转的block
 @return 是否能够handle
 */
-(BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void(^)(NSError *error, id responseObject))targetCallBack withCompletionBlock:(void(^)(BOOL handled, NSError *error))completionBlock;

/**
 添加一个中间件

 @param middleware 中间件
 */
-(void)addMiddleware:(id<ZPMRouteMiddleware>)middleware;

/**
 移除一个中间件

 @param middleware 中间件
 */
-(void)removeMiddleware:(id<ZPMRouteMiddleware>)middleware;


/**
 添加一个拦截器

 @param interceptor 拦截器
 */
- (void)addInterceptor:(id <ZPMRouteInterceptor>)interceptor;

/**
 移除一个拦截器

 @param interceptor 拦截器
 */
- (void)removeInterceptor:(id <ZPMRouteInterceptor>)interceptor;
@end
NS_ASSUME_NONNULL_END
