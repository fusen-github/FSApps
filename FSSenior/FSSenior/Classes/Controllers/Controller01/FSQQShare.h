//
//  FSQQShare.h
//  FSSenior
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface FSQQShare : NSObject

+ (void)shareTextToFriend:(NSString *)text;

//+ (void)shareImagesToFriend:()

@end
