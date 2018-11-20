//
//  FSNotificationManager.m
//  FSSenior
//
//  Created by 付森 on 2018/11/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import "FSController03.h"


@interface FSNotificationManager ()<UNUserNotificationCenterDelegate>

@end

@implementation FSNotificationManager

/*
 参考地址:
 https://www.jianshu.com/p/9700ccae9f8e?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 https://blog.csdn.net/qq_29846663/article/details/69390251
 
 1、通过[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler]方法请求用户授权发送本地通知和远程通知
 2、用户授权通过后一定要在“主线程”调用[UIApplication registerForRemoteNotifications]，向apns注册远程通知
 3、注册成功，回调UIApplicationDelegate中的didRegisterForRemoteNotificationsWithDeviceToken方法拿到deviceToken,
    注册失败，回调didFailToRegisterForRemoteNotificationsWithError
 4、deviceToken是由手机的UDID和app bundleID组合编码后的一个NSData数据。(如果用户手机系统版本不变，这个deviceToken一般不会变化)
 5、将deviceToken发送给自己的服务器，服务器存储此deviceToken。
 6、服务器用deviceToken向apns发送一个推送消息，因为apns是和ios 设备长连接的，所以apns又将这个推送消息发送给deviceToken里指定设备的指定app。app收到apns消息后作出相应的处理
 */

+ (instancetype)shareManager
{
    static FSNotificationManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSNotificationManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {        
        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    }
    return self;
}

- (void)requestAuthorizationCompletion:(void (^)(BOOL, NSError *))completion
{
    /// 获取“通知中心”单例
    UNUserNotificationCenter *unCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    /// 通知选项
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    
    /*
     请求用户授权通知，只会在APP第一次启动时请求一次。
     一旦用户决定了授权结果，以后就不会再向用户请求授权了。
     但是以后每次启动APP，该请求的block回调还是会走的
     */
    [unCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError *error) {
        
        /* 回调线程 */
        
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_main_async_safe(^{
           
            if (completion)
            {
                completion(granted, error);
            }
        });
    }];
}

- (void)sendLocalNotificationWithText:(NSString *)text
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];

    content.title = @"通知内容标题";
    
    content.subtitle = @"通知内容子标题";
    
    content.body = text;
    
    content.badge = @(22);
    
    content.sound = [UNNotificationSound soundNamed:@"qingchen.m4a"];
    
    NSString *identifier = @"fs_本地文本通知";
    
//    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger ]
    
    /* 如果repeats = YES,  TimeInterval一定要大于等于60s */
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError *error) {
        
        /* ps: 此处为子线程 */
        
        NSLog(@"本地用户通知文本消息, error = %@",error);
    }];
}

#pragma mark UNUserNotificationCenterDelegate
/*
 只有在应用程序处于前台时，该方法才会被调用到委托上。
 如果未实现该方法或未及时调用处理程序，则不通知该通知。
 应用程序可以选择将通知呈现为声音、徽章、警报和/或通知列表中的通知。
 这个决定应该基于通知中的信息是否对用户是可见的。
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    /* 主线程回调 */
    
    UNNotificationPresentationOptions options = UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    
    NSLog(@"来了");
    
    NSLog(@"%@",[notification.request description]);
    
    NSLog(@"\n___________________________________________________________\n");
    
    NSLog(@"%@", notification.request.content);
    
    NSLog(@"\n___________________________________________________________\n");
    
    NSLog(@"%@",notification.request.content.userInfo);
    
    NSLog(@"\n___________________________________________________________\n");
    
    completionHandler(options);
    
    NSLog(@"end_111");
}

/*
 当用户通过打开应用程序、拒绝通知或选择UNNotificationAction来响应通知时，将对委托调用该方法。
 The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
 */
-   (void)userNotificationCenter:(UNUserNotificationCenter *)center
  didReceiveNotificationResponse:(UNNotificationResponse *)response
           withCompletionHandler:(void(^)(void))completionHandler
{
    /* 该方法在主线程回调 */
    
    /*
     可在该方法内部处理业务逻辑
     */
    
    id root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (root)
    {
        FSController03 *controller = [[FSController03 alloc] init];
        
        self.delegate = (id<FSNotificationManagerDelegate>)controller;
        
        [root pushViewController:controller animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(requestHandleNotification:)])
        {
            id userInfo = response.notification.request.content.userInfo;
            
            [self.delegate requestHandleNotification:userInfo];
        }
    }
    
    completionHandler();
}

@end
