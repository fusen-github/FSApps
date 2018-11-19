//
//  FSController01.m
//  FSSenior
//
//  Created by 付森 on 2018/11/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController01.h"
#import "FSTencentManager.h"

static NSString * const kSectionTitle = @"sectionTitle";

static NSString * const kSectionDatas = @"sectionDatas";



static NSString * const kTitleKey = @"title";

static NSString * const kActionKey = @"action";

#define SeletorName(cmd) NSStringFromSelector(@selector(cmd))

@interface FSController01 (Extention)

- (void)q_Login;

- (void)session_shareMsg;

- (void)session_shareImage;

- (void)session_shareUrl;

@end

@interface FSController01 ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    NSArray *logins = @[@{kActionKey:SeletorName(q_Login),kTitleKey:@"QQ登陆"},];
    
    NSArray *sessions =
  @[@{kActionKey:SeletorName(session_shareMsg),kTitleKey:@"分享text文本到Q会话"},
    @{kActionKey:SeletorName(session_shareImage),kTitleKey:@"分享image到Q会话"},
    @{kActionKey:SeletorName(session_shareUrl),kTitleKey:@"分享URL到Q会话"},
    ];
    
    NSArray *qZones =
  @[@{kActionKey:SeletorName(session_shareMsg),kTitleKey:@"分享text文本到Q会话"},];
    
    self.dataArray = @[@{kSectionDatas:logins,kSectionTitle:@"QQ登陆"},
                       @{kSectionDatas:sessions,kSectionTitle:@"分享到QQ会话"},
                       @{kSectionDatas:qZones,kSectionTitle:@"分享到QQ空间"},];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    
    NSArray *array = [dict objectForKey:kSectionDatas];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"tencent_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    
    NSArray *array = [dict objectForKey:kSectionDatas];
    
    NSDictionary *rowDict = [array objectAtIndex:indexPath.row];
    
    NSString *title = [rowDict objectForKey:kTitleKey];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];

    NSString *title = [dict objectForKey:kSectionTitle];
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    
    NSArray *array = [dict objectForKey:kSectionDatas];
    
    NSDictionary *rowDict = [array objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString([rowDict objectForKey:kActionKey]);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector];
#pragma clang diagnostic pop
}

@end

@implementation FSController01 (Login)

/**
 QQ登陆
 */
- (void)q_Login
{
    [[FSTencentManager shareManager] loginOauth];
}

@end

@implementation FSController01 (Session)

/**
 分享文本到session
 */
- (void)session_shareMsg
{
    [[FSTencentManager shareManager] shareToSessionWithText:@"哈哈。。。"];
}

- (void)session_shareImage
{
    NSArray *names = @[@"a",@"b"];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSString *n in names)
    {
        NSString *name = [NSString stringWithFormat:@"%@@2x",n];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data)
        {
            [tmpArray addObject:data];
        }
    }
    
    NSString *title = @"测试分享图片";
    
    NSString *desc = @"测试描述";
    
    [[FSTencentManager shareManager] shareToSessionImageData:tmpArray.firstObject previewImageData:tmpArray[1] title:title desc:desc];
}

- (void)session_shareUrl
{
    NSURL *url = [NSURL URLWithString:@"https://news.163.com/18/1118/15/E0TH6O87000189FH.html"];
    
    NSString *title = @"测试新闻标题FS";
    
    NSString *desc = @"描述信息....";
    
    NSURL *imageUrl = [NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1542536641&di=cb703f8e78eda0e8fb6dc21640b500ab&src=http://aliyunzixunbucket.oss-cn-beijing.aliyuncs.com/jpg/0948545db38f12c59053aa325cb43ae4.jpg?x-oss-process=image/resize,p_100/auto-orient,1/quality,q_90/format,jpg/watermark,image_eXVuY2VzaGk=,t_100"];

    [[FSTencentManager shareManager] shareToSessionUrl:url title:title desc:desc previewImageURL:imageUrl];
}



@end

@implementation FSController01 (Qzone)



@end
