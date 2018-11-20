//
//  FSController03.m
//  FSSenior
//
//  Created by 付森 on 2018/11/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController03.h"
#import "FSNotificationManager.h"
#import "FSUNController01.h"


static NSString * const kSectionTitle = @"sectionTitle";

static NSString * const kSectionDatas = @"sectionDatas";



static NSString * const kTitleKey = @"title";

static NSString * const kActionKey = @"action";

#define SeletorName(cmd) NSStringFromSelector(@selector(cmd))

@interface FSController03 (Extension)

/**
 本地文本通知
 */
- (void)local_textNotifacation;



@end

@interface FSController03 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSController03

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.frame = self.view.bounds;
    
    [self.view addSubview:tableView];
    
    
    NSArray *localNotis =
  @[@{kTitleKey:@"本地文本通知",kActionKey:SeletorName(local_textNotifacation)},
    @{kTitleKey:@"",kActionKey:@""},
    @{kTitleKey:@"",kActionKey:@""},];
    
    NSArray *remoteNotis =
    @[@{kTitleKey:@"",kActionKey:@""},
      @{kTitleKey:@"",kActionKey:@""},
      @{kTitleKey:@"",kActionKey:@""},];
    
    self.dataArray = @[@{kSectionDatas:localNotis, kSectionTitle:@"本地通知"},
                       @{kSectionDatas:remoteNotis, kSectionTitle:@"远程通知"},];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.dataArray objectAtIndex:section];
    
    NSArray *datas = [dict objectForKey:kSectionDatas];
    
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"notification_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    NSDictionary *section = [self.dataArray objectAtIndex:indexPath.section];
    
    NSArray *datas = [section objectForKey:kSectionDatas];
    
    NSDictionary *row = [datas objectAtIndex:indexPath.row];
    
    NSString *title = [row objectForKey:kTitleKey];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *section = [self.dataArray objectAtIndex:indexPath.section];
    
    NSArray *datas = [section objectForKey:kSectionDatas];
    
    NSDictionary *row = [datas objectAtIndex:indexPath.row];
    
    NSString *selString = [row objectForKey:kActionKey];
    
    if ([self respondsToSelector:NSSelectorFromString(selString)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(selString)];
#pragma clang diagnostic pop
    }
}

- (void)requestHandleNotification:(NSDictionary *)userInfo
{
    FSUNController01 *controller = [[FSUNController01 alloc] initWithUserInfo:userInfo];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end

@implementation FSController03 (Local)

- (void)local_textNotifacation
{
    NSString *text = @"xxxx通知body";
    
    [[FSNotificationManager shareManager] sendLocalNotificationWithText:text];
}

@end
