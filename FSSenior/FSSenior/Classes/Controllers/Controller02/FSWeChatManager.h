//
//  FSWeChatManager.h
//  FSSenior
//
//  Created by 付森 on 2018/11/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 enum WXScene {
 
 WXSceneSession  = 0,
 WXSceneTimeline = 1,
 WXSceneFavorite = 2,
 };
 */

typedef NS_ENUM(NSInteger, FSWXSecenType)
{
    /// 会话
    FSWXSecenTypeSession    = 0,
    /// 朋友圈
    FSWXSecenTypeTimeline   = 1,
    /// 收藏
    FSWXSecenTypeFavorite   = 2,
};

@interface FSWeChatManager : NSObject

+ (instancetype)shareManager;

@end

@interface FSWeChatManager (Share)

- (void)shareText:(NSString *)text toSecenType:(FSWXSecenType)type;

- (void)shareImage:(NSData *)imgData thunbImage:(NSData *)thumbData toSecenType:(FSWXSecenType)type;

@end
