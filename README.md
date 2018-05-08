# ZPMRoute

[![CI Status](http://img.shields.io/travis/Neo/ZPMRoute.svg?style=flat)](https://travis-ci.org/Neo/ZPMRoute)
[![Version](https://img.shields.io/cocoapods/v/ZPMRoute.svg?style=flat)](http://cocoapods.org/pods/ZPMRoute)
[![License](https://img.shields.io/cocoapods/l/ZPMRoute.svg?style=flat)](http://cocoapods.org/pods/ZPMRoute)
[![Platform](https://img.shields.io/cocoapods/p/ZPMRoute.svg?style=flat)](http://cocoapods.org/pods/ZPMRoute)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZPMRoute is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZPMRoute"
```
## Architecture
![RouteClassMap](http://upload-images.jianshu.io/upload_images/24274-e05a8d382f2841e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 中文介绍
ZPMRoute是一个简单的iOS路由组件
详情请移步文章介绍：
[移动端路由层设计](http://www.jianshu.com/p/be7da3ed4100)
[一步步构建iOS路由](http://www.jianshu.com/p/3a902f274a3d)
本代码会随着大家的讨论逐步更新，喜欢的来个星✨~谢谢
##Usage

```
self.router = [[ZPMRouter alloc]init];
[self.router registerHandler:[[ZPMSignHandler alloc]init] forRoute:@"/signin/:phone([0-9]+)"];
[self.router handleURL:[NSURL URLWithString:@"ZPMDemo://com.ZPMroute.demo/signin/13812345432"] primitiveParameters:nil targetCallBack:^(NSError *error, id responseObject) {
        NSLog(@"SiginCallBack");
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"SiginHandleCompletion");
    }];

[self.router registerHandler:[[ZPMUserHandler alloc]init] forRoute:@"/user"];
[self.router handleURL:[NSURL URLWithString:@"ZPMDemo://com.ZPMroute.demo/user"] primitiveParameters:@{@"user":@"Neo~🙃🙃"} targetCallBack:^(NSError *error, id responseObject) {
        NSLog(@"UserCallBack");
    } withCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"UserHandleCompletion");
    }];

```

## Author

Neo, 394570610@qq.com

## License

ZPMRoute is available under the MIT license. See the LICENSE file for more info.
