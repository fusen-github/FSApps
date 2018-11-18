//
//  FSTencentManager.m
//  FSSenior
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSTencentManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "FSQQShare.h"

static NSError * generateErrorWithDesc(NSString *desc)
{
    NSString *info = desc ? : @"未知错误";
    
    NSString *domain = @"QQShareErrorDomain";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:info forKey:NSLocalizedDescriptionKey];
    
    NSError *error = [NSError errorWithDomain:domain code:-1 userInfo:dict];
    
    return error;
}

@interface FSTencentManager ()

@property (nonatomic, strong) TencentOAuth *oauth;

@end

@implementation FSTencentManager

+ (instancetype)shareManager
{
    static FSTencentManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[FSTencentManager alloc] init];
        
        manager.oauth = [[TencentOAuth alloc] initWithAppId:kTencentAppId andDelegate:(id<TencentSessionDelegate>)manager];
        
        NSLog(@"腾讯api sdkVersion = %@",[TencentOAuth sdkVersion]);
    });
    
    return manager;
}


/**
 @return 需要授权的信息
 */
- (NSArray *)getPermissions
{
    NSArray *arr = @[kOPEN_PERMISSION_ADD_SHARE, kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_OTHER_INFO,kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
    
    return arr;
}

- (void)loginOauth
{
    static time_t loginTime;
    
    time_t currentTime;
    
    time(&currentTime);
    
    if ((currentTime - loginTime) > 2)
    {
        self.oauth.authMode = kAuthModeClientSideToken;
        
        [self.oauth authorize:[self getPermissions] inSafari:NO];
        
        loginTime = currentTime;
    }
}

@end

@implementation FSTencentManager (Share)

- (void)shareTextToFriend:(NSString *)text
{
    QQApiTextObject *obj = [QQApiTextObject objectWithText:text];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d",code);
}

- (void)shareImageDataToFriend:(NSData *)imgData
                         title:(NSString *)title
                          desc:(NSString *)desc
                         error:(NSError *__autoreleasing *)error
{
    QQApiImageObject *imageApi = [QQApiImageObject objectWithData:imgData previewImageData:imgData title:title description:desc];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:imageApi];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d",code);
}

/**
 测试代码
 */
- (void)shareUrl
{
    NSURL *url = [NSURL URLWithString:@"https://news.163.com/18/1118/15/E0TH6O87000189FH.html"];
    
    NSString *title = @"测试新闻标题FS";
    
    NSString *desc = @"描述信息....";
    
    NSURL *imageUrl = [NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1542536641&di=cb703f8e78eda0e8fb6dc21640b500ab&src=http://aliyunzixunbucket.oss-cn-beijing.aliyuncs.com/jpg/0948545db38f12c59053aa325cb43ae4.jpg?x-oss-process=image/resize,p_100/auto-orient,1/quality,q_90/format,jpg/watermark,image_eXVuY2VzaGk=,t_100"];
    
    QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:url title:title description:desc previewImageURL:imageUrl];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d", code);
}

- (void)shareNewsUrl:(NSURL *)newsUrl previewImageUrl:(NSURL *)imageUrl title:(NSString *)title desc:(NSString *)desc
{
    QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:newsUrl title:title description:desc previewImageURL:imageUrl];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d", code);
}

- (void)shareVideo
{
    NSURL *videlUrl = [NSURL URLWithString:@"http://v.ifeng.com/201811/video_28347664.shtml"];
    
    NSString *title = @"fs_视频";
    
    NSString *desc = @"测试xxx_fs";
    
    NSURL *previewImgUrl = [NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1542536641&di=cb703f8e78eda0e8fb6dc21640b500ab&src=http://aliyunzixunbucket.oss-cn-beijing.aliyuncs.com/jpg/0948545db38f12c59053aa325cb43ae4.jpg?x-oss-process=image/resize,p_100/auto-orient,1/quality,q_90/format,jpg/watermark,image_eXVuY2VzaGk=,t_100"];
    
    QQApiVideoObject *obj = [QQApiVideoObject objectWithURL:videlUrl title:title description:desc previewImageURL:previewImgUrl];
    
    NSURL *flash = [NSURL URLWithString:@"http://ips.ifeng.com/video19.ifeng.com/video09/2018/11/18/p4801447-102-009-174937.mp4?vid=7e6f3361-fef6-4bde-a6ad-2831425af927&uid=1542539275760_t8j74j9314&from=v_Free&pver=vHTML5Player_v2.0.0&sver=&se=经典KO&cat=81-82&ptype=81&platform=pc&sourceType=h5&dt=NaN&gid=lwyV8WcmhCNF&sign=06ebbc8cb467a8016932da8c353b07c7&tm=1542539453254"];
    
    /* 一定要设置flash_url，这个是播放视频的地址 */
    [obj setFlashURL:flash];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface sendReq:request];
    
    NSLog(@"code = %d", code);
}

/********************************* 分享到Q空间 ***********************************************/

- (void)shareToQZoneForMsg:(NSString *)message
{
    NSArray *paths = @[@"11.jpg", @"22.jpg", @"33.jpg"];
    
    NSMutableArray *imageDatas = [NSMutableArray array];
    
    for (NSString *name in paths)
    {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        
        if (data)
        {
            [imageDatas addObject:data];
        }
    }
    
    imageDatas = nil;
    
    message = @"https://www.jianshu.com/p/763f6321c89e";
    
    QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:imageDatas title:message extMap:nil];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface SendReqToQZone:request];
    
    NSLog(@"%d",code);
}


- (void)shareToQZoneForUrl
{
    NSString *urlStr = @"https://www.jianshu.com/p/763f6321c89e";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString *title = @"标题";
    
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"11.jpg" ofType:nil];
    
    NSURL *previewImageUrl = [NSURL fileURLWithPath:fullPath];
    
    QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:url title:title description:@"描述info" previewImageURL:previewImageUrl];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:obj];
    
    QQApiSendResultCode code = [QQApiInterface SendReqToQZone:request];
    
    NSLog(@"code = %d", code);
    
}

@end

@implementation FSTencentManager (QQApiInterfaceDelegate)

/*
 <QQApiInterfaceDelegate>
 */

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
    NSLog(@"%s",__func__);
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
    // SendMessageToQQResp
    if ([resp isKindOfClass:[SendMessageToQQResp class]])
    {
        SendMessageToQQResp *tmpObj = (id)resp;
        
        if (tmpObj.type == ESENDMESSAGETOQQRESPTYPE && [tmpObj.result isEqualToString:@"0"])
        {
            NSLog(@"分享成功");
        }
    }
    
    NSLog(@"%s",__func__);
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    NSLog(@"%s",__func__);
}

@end

@implementation FSTencentManager (TencentSessionDelegate)
/**
 * \brief TencentSessionDelegate iOS Open SDK 1.3 API回调协议
 *
 * 第三方应用需要实现每条需要调用的API的回调协议
 */

/**
 * 退出登录的回调
 */
- (void)tencentDidLogout
{
    
}

/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
//- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
//- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
//- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason
{
    
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@",response.jsonResponse);
}


/**
 * 社交API统一回调接口
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
 */
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message
{
    
}

/**
 * post请求的上传进度
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param bytesWritten 本次回调上传的数据字节数
 * \param totalBytesWritten 总共已经上传的字节数
 * \param totalBytesExpectedToWrite 总共需要上传的字节数
 * \param userData 用户自定义数据
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData
{
    
}


/**
 * 通知第三方界面需要被关闭
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param viewController 需要关闭的viewController
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    
}

@end

@implementation FSTencentManager (TencentLoginDelegate)
/**
 * \brief TencentLoginDelegate iOS Open SDK 1.3 API回调协议
 *
 * 第三方应用实现登录的回调协议
 */

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    if (_oauth.accessToken.length)
    {
        _accessToken = _oauth.accessToken;
        
        _openId = _oauth.openId;
        
        _expirationDate = _oauth.expirationDate;
        
        NSLog(@"成功获取到accessToken = %@",_accessToken);
        
        NSLog(@"openId = %@",_openId);
        
        NSLog(@"expirationDate = %@",_expirationDate);
        
//        [_oauth getCachedToken];
        
//        [_oauth getCachedOpenID]
        
        if ([self.oauth getUserInfo])
        {
            NSLog(@"获取用户信息——成功");
            
            /*
             https://graph.qq.com/user/get_user_info?
             access_token=*************&
             oauth_consumer_key=12345&
             openid=****************
             */
            
            NSString *urlStr = [NSString stringWithFormat:@"https://graph.qq.com/user/get_user_info?access_token=%@&oauth_consumer_key=%@&openid=%@",_oauth.accessToken,_oauth.appId,_oauth.openId];
            
            NSURL *url = [NSURL URLWithString:urlStr];
            
            NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
                
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSLog(@"%@",str);
                /*
                 返回json {"ret":100008,"msg":"client request's app is not existed"}
                 appId不存在，可能是因为app还没有被审核通过吧
                 */
            }];
            
            [dataTask resume];
        }
        else
        {
            NSLog(@"获取用户信息——失败");
        }
    }
    else
    {
        NSLog(@"没有获取到accessToken");
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"%s",__func__);
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    NSLog(@"%s",__func__);
}


/**
 * 登录时权限信息的获得
 */
//- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams

/**
 * unionID获得
 */
- (void)didGetUnionID
{
    NSLog(@"%s",__func__);
}

@end

@implementation FSTencentManager (TencentWebViewDelegate)
/**
 * \brief TencentWebViewDelegate: H5登录webview旋转方向回调协议
 *
 * 第三方应用可以根据自己APP的旋转方向限制，通过此协议设置
 */


//- (BOOL) tencentWebViewShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
//- (NSUInteger) tencentWebViewSupportedInterfaceOrientationsWithWebkit;
//- (BOOL) tencentWebViewShouldAutorotateWithWebkit;

@end


