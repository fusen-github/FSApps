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



/**
 分享纯文本到会话(qq好友、群、讨论组)

 @param text 要分享的文本信息
 */
- (void)shareToSessionWithText:(NSString *)text;



/**
 分享图片到会话

 @param data 要分享的图片data
 @param pData 预览图片对象
 @param title 标题
 @param desc 描述
 */
- (void)shareToSessionImageData:(NSData *)data
               previewImageData:(NSData *)pData
                          title:(NSString *)title
                           desc:(NSString *)desc;



/**
 分享一个链接到会话

 @param url 链接地址
 @param title 标题
 @param desc 描述
 @param previewImageURL 预览的图片URL
 
 */
- (void)shareToSessionUrl:(NSURL *)url
                    title:(NSString *)title
                     desc:(NSString *)desc
          previewImageURL:(NSURL *)previewImageURL;



/**
 分享新闻接口

 @param newsUrl 新闻URL
 @param imageUrl 预览图片URL(预览图片可是是本地URL，也可以是网络URL)
 @param title 标题
 @param desc 描述
 */
- (void)shareNewsUrl:(NSURL *)newsUrl
     previewImageUrl:(NSURL *)imageUrl
               title:(NSString *)title
                desc:(NSString *)desc;


/**
 分享视频给QQ好友
 */
- (void)shareVideo;

- (void)shareToQZoneForMsg:(NSString *)message;

- (void)shareToQZoneForUrl;


@end
