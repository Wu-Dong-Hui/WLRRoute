## ZPMNetwork 是什么

ZPMNetwork 是智联招聘 iOS 研发团队基于 [AFNetworking][AFNetworking] 封装的 iOS 网络库，其实现了一套 High Level 的 ZPMNetwork 现在同时被使用在公司的所有产品的 iOS 端，包括：[智联招聘][zhaopin]、[智联企业版][zhaopinBapp]。

## ZPMNetwork 提供了哪些功能

相比 AFNetworking，ZPMNetwork 提供了以下更高级的功能：

 * 支持按时间缓存网络请求内容
 * 支持按版本号缓存网络请求内容
 * 支持统一设置服务器和 CDN 的地址
 * 支持检查返回 JSON 内容的合法性
 * 支持文件的断点续传
 * 支持 `block` 和 `delegate` 两种模式的回调方式
 * 支持批量的网络请求发送，并统一设置它们的回调（实现在 `ZPMBatchRequest` 类中）
 * 支持方便地设置有相互依赖的网络请求的发送，例如：发送请求 A，根据请求 A 的结果，选择性的发送请求 B 和 C，再根据 B 和 C 的结果，选择性的发送请求 D。（实现在 `ZPMChainRequest` 类中）
 * 支持网络请求 URL 的 filter，可以统一为网络请求加上一些参数，或者修改一些路径。
 * 定义了一套插件机制，可以很方便地为 ZPMNetwork 增加功能。例如，可以在某些网络请求发起时，在界面上显示“正在加载”的 HUD。


## 相比之前老的库， 我们提升了什么
*  增加对DNS的支持
*  支持AFN3.0版本
*  增加多线程保护， 防止出现异常crash，和脏数据
*  支持批量的网络请求
*  增加快们式网络请求，方便请求调用
*  增加插件模式， 方面扩充新功能
*  不改AFN3.0源码，提供加密功能， 方便AFN升级



## 哪些项目适合使用 ZPMNetwork

ZPMNetwork 适合稍微复杂一些的项目，不适合个人的小项目。

如果你的项目中需要缓存网络请求、管理多个网络请求之间的依赖、希望检查服务器返回的 JSON 是否合法，那么 ZPMNetwork 能给你带来很大的帮助。如果你缓存的网络请求内容需要依赖特定版本号过期，那么 ZPMNetwork 就能发挥出它最大的优势。

## ZPMNetwork 的基本思想

ZPMNetwork 的基本的思想是把每一个网络请求封装成对象。所以使用 ZPMNetwork，你的每一个请求都需要继承 `ZPMRequest` 类，通过覆盖父类的一些方法来构造指定的网络请求。

把每一个网络请求封装成对象其实是使用了设计模式中的 Command 模式，它有以下好处：

 * 将网络请求与具体的第三方库依赖隔离，方便以后更换底层的网络库。
 * 方便在基类中处理公共逻辑，例如版本号信息就统一在基类中处理。
 * 方便在基类中处理缓存逻辑，以及其它一些公共逻辑。
 * 方便做对象的持久化。

当然，如果说它有什么不好，那就是如果你的工程非常简单，这么写会显得没有直接用 AFNetworking 将请求逻辑写在 Controller 中方便，所以 ZPMNetwork 并不适合特别简单的项目。

## 安装

你可以在 Podfile 中加入下面一行代码来使用 ZPMNetwork

    pod 'ZPMNetwork'

## 安装要求

| ZPMNetwork 版本 | AFNetworking 版本 |  最低 iOS Target | 注意 |
|:----------------:|:----------------:|:----------------:|:-----|
| 2.x | 3.x | iOS 7 | 要求 Xcode 7 以上  |
| 1.x | 2.x | iOS 6 | n/a |


ZPMNetwork 依赖于 AFNetworking，可以在 [AFNetworking README](https://github.com/AFNetworking/AFNetworking) 中找到更多关于依赖版本有关的信息。

## 相关的使用教程和 Demo

 * [基础使用教程](./Docs/BasicGuide_cn.md)
 * [高级使用教程](./Docs/ProGuide_cn.md)

## 作者

ZPMNetwork 的主要作者是：

* [Roy][royGithub]
* [pchen][pchenGithub]

## 感谢

ZPMNetwork 基于 [AFNetworking][AFNetworking] 和 [AFDownloadRequestOperation][AFDownloadRequestOperation] 进行开发，感谢他们对开源社区做出的贡献。

## 协议

ZPMNetwork 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。


<!-- external links -->
[AFNetworking]:https://github.com/AFNetworking/AFNetworking
[AFDownloadRequestOperation]:https://github.com/steipete/AFDownloadRequestOperation

[zhaopin]:http://www.zhaopin.com
[zhaopinBapp]:http://ihr.zhaopin.com/
[royGithub]:https://github.com/Wu-Dong-Hui
[pchenGithub]:https://github.com/skyline75489


## 架构图
![avatar](./Docs/ZPMNetwork.png)
