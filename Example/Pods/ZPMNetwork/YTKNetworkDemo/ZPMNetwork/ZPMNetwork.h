//
//  ZPMNetwork.h
//
//  Copyright (c) 2012-2016 ZPMNetwork http://gitlab.dev.zhaopin.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

#ifndef _ZPMNetwork_
    #define _ZPMNetwork_

#if __has_include(<ZPMNetwork.h>)

    FOUNDATION_EXPORT double ZPMNetworkVersionNumber;
    FOUNDATION_EXPORT const unsigned char ZPMNetworkVersionString[];

    #import <ZPMRequest.h>
    #import <ZPMBaseRequest.h>
    #import <ZPMNetworkAgent.h>
    #import <ZPMBatchRequest.h>
    #import <ZPMBatchRequestAgent.h>
    #import <ZPMChainRequest.h>
    #import <ZPMChainRequestAgent.h>
    #import <ZPMNetworkConfig.h>
    #import <ZPMGeneralRequest.h>
#import <ZPMviewController1.h>

#else
#import "ZPMviewController1.h"
    #import "ZPMRequest.h"
    #import "ZPMBaseRequest.h"
    #import "ZPMNetworkAgent.h"
    #import "ZPMBatchRequest.h"
    #import "ZPMBatchRequestAgent.h"
    #import "ZPMChainRequest.h"
    #import "ZPMChainRequestAgent.h"
    #import "ZPMNetworkConfig.h"
    #import "ZPMGeneralRequest.h"

#endif /* __has_include */

#endif /* _ZPMNETWORK_ */
