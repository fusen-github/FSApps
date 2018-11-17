//
//  FSQQShare.m
//  FSSenior
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSQQShare.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>


@implementation FSQQShare

+ (void)shareTextToFriend:(NSString *)text
{
    QQApiTextObject *obj = [QQApiTextObject objectWithText:text];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d",code);
}

@end
