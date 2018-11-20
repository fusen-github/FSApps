//
//  FSNotificationManager.h
//  FSSenior
//
//  Created by 付森 on 2018/11/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FSNotificationManagerDelegate <NSObject>

@optional
- (void)requestHandleNotification:(NSDictionary *)userInfo;

@end

@interface FSNotificationManager : NSObject

@property (nonatomic, weak) id<FSNotificationManagerDelegate> delegate;

+ (instancetype)shareManager;

- (void)requestAuthorizationCompletion:(void (^)(BOOL granted, NSError *error))completion;


/**
 发送本地文本通知

 @param text 通知body
 */
- (void)sendLocalNotificationWithText:(NSString *)text;

@end
