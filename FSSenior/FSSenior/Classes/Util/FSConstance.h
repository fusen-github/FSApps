//
//  FSConstance.h
//  FSSenior
//
//  Created by 付森 on 2018/11/16.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

/// QQ的app id
FOUNDATION_EXTERN NSString * const kTencentAppId;

/// QQ的app key
FOUNDATION_EXTERN NSString * const kTencentAppKey;

/// 微信的app id
FOUNDATION_EXTERN NSString * const kWeChatAppId;

/// 微信的app secret
FOUNDATION_EXTERN NSString * const kWeChatAppSecret;


/**
 异步到主线程上安全执行
 @param block 无参数、无返回值的block
 */
FOUNDATION_STATIC_INLINE void dispatch_main_async_safe(dispatch_block_t block)
{
    if ([NSThread isMainThread])
    {
        if (block)
        {
            block();
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 在主线程上同步安全执行
 @param block 无参数、无返回值的block
 */
FOUNDATION_STATIC_INLINE void dispatch_main_sync_safe(dispatch_block_t block)
{
    if ([NSThread isMainThread])
    {
        if (block)
        {
            block();
        }
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}


