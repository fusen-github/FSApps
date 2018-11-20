//
//  AppDelegate.m
//  FSSenior
//
//  Created by 付森 on 2018/11/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "AppDelegate.h"
#import "FSNavigationController.h"
#import "FSMainController.h"
#import "FSShareTool.h"
#import "FSNotificationManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    FSMainController *mainVC = [[FSMainController alloc] init];
    
    FSNavigationController *nav = [[FSNavigationController alloc] initWithRootViewController:mainVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [self registerNotificationWithApp:application];
    
    UIView *blueView = [[UIView alloc] init];
    
    blueView.backgroundColor = [UIColor blueColor];
    
    blueView.frame = CGRectMake(0, self.window.bounds.size.height - 200, self.window.bounds.size.width, 200);
    
    [self.window addSubview:blueView];
    
    return YES;
}

- (void)registerNotificationWithApp:(UIApplication *)application
{
    [[FSNotificationManager shareManager] requestAuthorizationCompletion:^(BOOL granted, NSError *error) {
        
        if (granted && error == nil)
        {
            NSLog(@"授权同意接收通知...");
            
            [application registerForRemoteNotifications];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken = %@",deviceToken);
    
    NSLog(@"%s",__func__);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"%s",__func__);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL flag = [FSShareTool applicationHandleOpenURL:url];
    
    return flag;
}


@end
