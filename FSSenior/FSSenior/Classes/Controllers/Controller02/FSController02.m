//
//  FSController02.m
//  FSSenior
//
//  Created by 付森 on 2018/11/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController02.h"

static NSString * const kSectionTitle = @"sectionTitle";

static NSString * const kSectionDatas = @"sectionDatas";



static NSString * const kTitleKey = @"title";

static NSString * const kActionKey = @"action";

#define SeletorName(cmd) NSStringFromSelector(@selector(cmd))

@interface FSController02 (WeChat)

- (void)wx_Login;

@end

@interface FSController02 ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation FSController02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    NSArray *logins = @[@{kActionKey:SeletorName(wx_Login),kTitleKey:@"微信登陆"},];
    
    NSArray *shares =
    @[@{kActionKey:SeletorName(session_shareMsg),kTitleKey:@"分享text文本到WeChat会话"},
      @{kActionKey:SeletorName(session_shareImage),kTitleKey:@"分享image到WeCha会话"},
      @{kActionKey:SeletorName(session_shareUrl),kTitleKey:@"分享URL到WeCha会话"},
      ];
     
    self.dataArray = @[@{kSectionDatas:logins,kSectionTitle:@"QQ登陆"},
                       @{kSectionDatas:shares,kSectionTitle:@"分享到QQ会话"}];
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
