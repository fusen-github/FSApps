//
//  FSTencentManager.h
//  FSSenior
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FSTencentManagerDelegate <NSObject>

@optional


@end

@interface FSTencentManager : NSObject

@property (nonatomic, weak) id<FSTencentManagerDelegate> delegate;

+ (instancetype)shareManager;

@property (nonatomic, strong, readonly) NSString *accessToken;

@property (nonatomic, strong, readonly) NSString *openId;

@property(nonatomic, copy, readonly) NSDate *expirationDate;

- (void)loginOauth;

@end

@interface FSTencentManager (Share)
/*
 QQ分享分为“分享给好友”和“分享到QQ空间”两种
 其中“分享给好友”支持以下类型
 1、纯文本消息
 2、纯图片消息
 3、链接类消息
 
 “分享到空间”支持以下类型
 1、纯文本消息
 2、纯图片消息
 3、视频类消息
 4、链接类消息
 */


- (void)shareTextToFriend:(NSString *)text;

- (void)shareImageDataToFriend:(NSData *)imgData
                         title:(NSString *)title
                          desc:(NSString *)desc
                         error:(NSError **)error;



@end
