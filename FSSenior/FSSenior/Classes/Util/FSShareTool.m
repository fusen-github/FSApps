//
//  FSShareTool.m
//  FSSenior
//
//  Created by 付森 on 2018/11/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSShareTool.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "FSTencentManager.h"
#import "FSWeChatManager.h"
#import "WXApi.h"



@implementation FSShareTool

+ (BOOL)applicationHandleOpenURL:(NSURL *)url
{
    BOOL wxFlag = [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)[FSWeChatManager shareManager]];
    
    BOOL qqHandleFlag = [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[FSTencentManager shareManager]];
    
    BOOL qqFlag = NO;
    
    if ([TencentOAuth CanHandleOpenURL:url])
    {
        qqFlag = [TencentOAuth HandleOpenURL:url];
    }
    
    return wxFlag || qqFlag;
}

@end
