//
//  FSWeChatManager.m
//  FSSenior
//
//  Created by 付森 on 2018/11/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSWeChatManager.h"
#import "WXApi.h"


@interface FSWeChatManager (Private)<WXApiDelegate>

+ (void)appDidFinishLanuch;

@end

@implementation FSWeChatManager

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidFinishLanuch) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

+ (void)appDidFinishLanuch
{
    [WXApi registerApp:kWeChatAppId];
}

+ (instancetype)shareManager
{
    static FSWeChatManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSWeChatManager alloc] init];
    });
    
    return manager;
}

@end

@implementation FSWeChatManager (Share)

- (void)shareText:(NSString *)text toType:(FSWXSecenType)type
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    
    req.text = text;
    
    req.bText = YES;
    
    req.scene = type;
    
    BOOL rst = [WXApi sendReq:req];
    
    NSLog(@"rst = %d", rst);
}

- (void)shareImage:(NSData *)imgData thunbImage:(NSData *)thumbData toSecenType:(FSWXSecenType)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    
    UIImage *thumb = [UIImage imageWithData:thumbData];
    
    [message setThumbImage:thumb];
    
    WXImageObject *ext = [WXImageObject object];
    
    ext.imageData = imgData;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    
    req.bText = NO;
    
    req.message = message;
    
    req.scene = type;
    
    [WXApi sendReq:req];
}

@end

@implementation FSWeChatManager (Delegate)


/*! @brief 收到一个来自微信的请求，处理完后调用sendResp
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void)onReq:(BaseReq *)req
{
    NSLog(@"%s",__func__);
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp 具体的回应内容，是自动释放的
 */
-(void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        SendMessageToWXResp *obj = (id)resp;
        
        if (obj.errCode == 0)
        {
            NSLog(@"fs_发送成功。。。。。。");
        }
    }
    
    NSLog(@"%s",__func__);
}

@end
