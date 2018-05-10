//
//  ZPMRouter.m
//  Pods
//
//  Created by Neo on 2016/12/15.
//
//

#import "ZPMRouter.h"
#import <objc/runtime.h>
#import "ZPMRouteHandler.h"
#import "ZPMRouteMatcher.h"
#import "ZPMRouteRequest.h"
#import "NSError+ZPMRouteError.h"


NSString *const ZPMRouterGlobalRouteScheme = @"ZPMRouterGlobalRouteScheme";

static NSMutableDictionary *ZPMGlobal_routeControllersMap = nil;

@interface ZPMRouter()
@property(nonatomic,strong)NSMutableDictionary * routeMatchers;
@property(nonatomic,strong)NSMutableDictionary * routeHandles;
@property(nonatomic,strong)NSMutableDictionary * routeblocks;
@property(nonatomic,strong)NSHashTable * middlewares;
@property (nonatomic, strong) NSHashTable *interceptors;

@property (nonatomic, copy) NSString *scheme;

@end


@implementation ZPMRouter {
    dispatch_semaphore_t _registerSema;
}


+ (instancetype)globalRouter {
    static ZPMRouter *_globalRouter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalRouter = [ZPMRouter routerForScheme:ZPMRouterGlobalRouteScheme];
    });
    return _globalRouter;
}

+ (instancetype)routerForScheme:(NSString *)scheme {
    
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t sema;
    
    dispatch_once(&onceToken, ^{
        ZPMGlobal_routeControllersMap = [NSMutableDictionary dictionary];
        sema = dispatch_semaphore_create(1);
    });
    
    
    dispatch_semaphore_wait(sema, dispatch_time(DISPATCH_TIME_NOW, 5*1000*1000*1000));
    ZPMRouter *router = ZPMGlobal_routeControllersMap[scheme];
    if (router == nil) {
        router = [[self alloc] init];
        router.scheme = scheme;
        ZPMGlobal_routeControllersMap[scheme] = router;
    }
    dispatch_semaphore_signal(sema);
    
    return router;
}
+ (BOOL)canHandleURL:(NSURL *)url {
    return [[self _routerForURL:url] canHandleWithURL:url];
}

+ (BOOL)handleURL:(NSURL *)url {
    return [[self _routerForURL:url] handleURL:url primitiveParameters:nil targetCallBack:nil withCompletionBlock:nil];
}

+ (BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void (^)(NSError *, id))targetCallBack withCompletionBlock:(void (^)(BOOL, NSError *))completionBlock {
    return [[self _routerForURL:URL] handleURL:URL primitiveParameters:primitiveParameters targetCallBack:targetCallBack withCompletionBlock:completionBlock];
}


-(NSHashTable *)middlewares{
    if (!_middlewares) {
        _middlewares = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _middlewares;
}
- (NSHashTable *)interceptors {
    if (_interceptors) {
        return _interceptors;
    }
    return _interceptors = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
}
-(void)addMiddleware:(id<ZPMRouteMiddleware>)middleware{
    if (middleware) {
        [self.middlewares addObject:middleware];
    }
}
- (void)addInterceptor:(id <ZPMRouteInterceptor>)interceptor {
    if (interceptor) {
        [self.interceptors addObject:interceptor];
    }
}
-(void)removeMiddleware:(id<ZPMRouteMiddleware>)middleware{
    if ([self.middlewares containsObject:middleware]) {
        [self.middlewares removeObject:middleware];
    }
}
- (void)removeInterceptor:(id <ZPMRouteInterceptor>)interceptor {
    if (interceptor && [self.interceptors containsObject:interceptor]) {
        [self.interceptors removeObject:interceptor];
    }
}
-(instancetype)init{
    if (self = [super init]) {
        _routeblocks = [NSMutableDictionary dictionary];
        _routeHandles = [NSMutableDictionary dictionary];
        _routeMatchers = [NSMutableDictionary dictionary];
        _registerSema = dispatch_semaphore_create(1);
    }
    return self;
}
-(void)registerBlock:(ZPMRouteRequest *(^)(ZPMRouteRequest *))routeHandlerBlock forRoute:(NSString *)route{
    if (routeHandlerBlock && [route length]) {
        dispatch_semaphore_wait(_registerSema, dispatch_time(DISPATCH_TIME_NOW, 5*1000*1000*1000));
        [self.routeMatchers setObject:[ZPMRouteMatcher matcherWithRouteExpression:route] forKey:route];
        [self.routeHandles removeObjectForKey:route];
        self.routeblocks[route] = routeHandlerBlock;
        dispatch_semaphore_signal(_registerSema);
    }
}
-(void)registerHandler:(ZPMRouteHandler *)handler forRoute:(NSString *)route{
    if (handler && [route length]) {
        dispatch_semaphore_wait(_registerSema, dispatch_time(DISPATCH_TIME_NOW, 5*1000*1000*1000));
        [self.routeMatchers setObject:[ZPMRouteMatcher matcherWithRouteExpression:route] forKey:route];
        [self.routeblocks removeObjectForKey:route];
        self.routeHandles[route] = handler;
        dispatch_semaphore_signal(_registerSema);
    }
}
-(id)objectForKeyedSubscript:(NSString *)key{
    NSString * route = (NSString *)key;
    id obj = nil;
    if ([route isKindOfClass:[NSString class]] && [route length]) {
        obj = self.routeHandles[route];
        if (obj == nil) {
            obj = self.routeblocks[route];
        }
    }
    return obj;
}
-(void)setObject:(id)obj forKeyedSubscript:(NSString *)key{
    NSString * route = (NSString *)key;
    if (!([route isKindOfClass:[NSString class]] && [route length])) {
        return;
    }
    dispatch_semaphore_wait(_registerSema, dispatch_time(DISPATCH_TIME_NOW, 5*1000*1000*1000));
    if (!obj) {
        [self.routeblocks removeObjectForKey:route];
        [self.routeHandles removeObjectForKey:route];
        [self.routeMatchers removeObjectForKey:route];
    }
    else if ([obj isKindOfClass:NSClassFromString(@"NSBlock")]){
        [self registerBlock:obj forRoute:route];
    }
    else if ([obj isKindOfClass:[ZPMRouteHandler class]]){
        [self registerHandler:obj forRoute:route];
    }
    dispatch_semaphore_signal(_registerSema);
}
- (BOOL)canHandleWithURL:(NSURL *)url {
    if (url == nil) {
        return false;
    }
    for (NSString * route in self.routeMatchers.allKeys) {
        ZPMRouteMatcher * matcher = [self.routeMatchers objectForKey:route];
        ZPMRouteRequest * request = [matcher createRequestWithURL:url primitiveParameters:nil targetCallBack:nil];
        if (request) {
            return YES;
        }
    }
    return NO;
}
-(BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void(^)(NSError *error, id responseObject))targetCallBack withCompletionBlock:(void(^)(BOOL handled, NSError *error))completionBlock{
    if (!URL) {
        return NO;
    }
    NSError * error;
    ZPMRouteRequest * request;
    __block BOOL isHandled = NO;
    NSURL *falsifiedURL = URL;
    for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
        if (interceptor && [interceptor respondsToSelector:@selector(router:falsifyURL:)]) {
            falsifiedURL = [interceptor router:self falsifyURL:falsifiedURL];
        }
    }
    
    
    for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
        if (interceptor && [interceptor respondsToSelector:@selector(router:willHandleURL:)]) {
            [interceptor router:self willHandleURL:falsifiedURL];
        }
    }
    
    
    for (NSString * route in self.routeMatchers.allKeys) {
        ZPMRouteMatcher * matcher = [self.routeMatchers objectForKey:route];
        request = [matcher createRequestWithURL:falsifiedURL primitiveParameters:primitiveParameters targetCallBack:targetCallBack];
        /*
        if (request) {
            NSDictionary * responseObject;
            for (id<ZPMRouteMiddleware>middleware in self.middlewares){
                if (middleware != NULL &&[middleware respondsToSelector:@selector(middlewareHandleRequestWith:error:)]) {
                    responseObject = [middleware middlewareHandleRequestWith:&request error:&error];
                    if ((responseObject != nil )||(error != nil)) {
                        isHandled = YES;
                        if (request.targetCallBack) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                request.targetCallBack(error,responseObject);
                            });
                        }
                        break;
                    }
                }
            }
            if (isHandled == NO) {
                isHandled = [self handleRouteExpression:route withRequest:request error:&error];
            }
            break;
        }
        */
        if (request) {
            for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
                if (interceptor && [interceptor respondsToSelector:@selector(router:willHandleURL:request:)]) {
                    [interceptor router:self willHandleURL:falsifiedURL request:request];
                }
            }
            isHandled = [self handleRouteExpression:route withRequest:request error:&error];
            break;
        }
    }
    if (!request) {
        error = [NSError ZPMNotFoundError];
    }
    if (isHandled == false && self.shouldFallbackGlobalRouter && ![self.scheme isEqualToString:ZPMRouterGlobalRouteScheme]) {
        for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
            if (interceptor && [interceptor respondsToSelector:@selector(router:willFallbackGlobalRouterForURL:)]) {
                [interceptor router:self willFallbackGlobalRouterForURL:falsifiedURL];
            }
        }
        isHandled = [[ZPMRouter globalRouter] handleURL:falsifiedURL primitiveParameters:primitiveParameters targetCallBack:targetCallBack withCompletionBlock:completionBlock];
    }
    if (isHandled == false && self.unhandledURLHandler != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.unhandledURLHandler(self, falsifiedURL, primitiveParameters);
        });
    }
    if (isHandled) {
        for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
            if (interceptor && [interceptor respondsToSelector:@selector(router:didSuccessHandleURL:)]) {
                [interceptor router:self didSuccessHandleURL:falsifiedURL];
            }
        }
    } else {
        for (id <ZPMRouteInterceptor> interceptor in self.interceptors) {
            if (interceptor && [interceptor respondsToSelector:@selector(router:didFailHandleURL:)]) {
                [interceptor router:self didFailHandleURL:falsifiedURL];
            }
        }
    }
    [self completeRouteWithSuccess:isHandled error:error completionHandler:completionBlock];
    return isHandled;
}
-(BOOL)handleRouteExpression:(NSString *)routeExpression withRequest:(ZPMRouteRequest *)request error:(NSError *__autoreleasing *)error {
    id handler = self[routeExpression];
    if ([handler isKindOfClass:NSClassFromString(@"NSBlock")]) {
        ZPMRouteRequest *(^blcok)(ZPMRouteRequest *) = handler;
        ZPMRouteRequest * backRequest = blcok(request);
        if (backRequest.isConsumed==NO) {
            if (backRequest) {
                backRequest.isConsumed = YES;
                if (backRequest.targetCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backRequest.targetCallBack(nil,nil);
                    });
                }
            }
            else{
                request.isConsumed = YES;
                if (request.targetCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backRequest.targetCallBack([NSError ZPMHandleBlockNoTeturnRequest],nil);
                    });
                }
            }
        }
        return YES;
    }
    else if ([handler isKindOfClass:[ZPMRouteHandler class]]){
        ZPMRouteHandler * rHandler = (ZPMRouteHandler *)handler;
        if (![rHandler shouldHandleWithRequest:request]) {
            return NO;
        }
        return [rHandler handleRequest:request error:error];
    }
    return YES;
}
- (void)completeRouteWithSuccess:(BOOL)handled error:(NSError *)error completionHandler:(void(^)(BOOL handled, NSError *error))completionHandler {
    if (completionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(handled, error);
        });
    }
}
#pragma mark - Private
+ (instancetype)_routerForURL:(NSURL *)url {
    if (url == nil) {
        return nil;
    }
    return ZPMGlobal_routeControllersMap[url.scheme] ?: [self globalRouter];
}
@end
