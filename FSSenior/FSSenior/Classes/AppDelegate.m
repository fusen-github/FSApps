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
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    BOOL flag = [FSShareTool applicationHandleOpenURL:url];
    
    return flag;
}


@end
