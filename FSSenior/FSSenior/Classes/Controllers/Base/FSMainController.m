//
//  FSMainController.m
//  FSSenior
//
//  Created by 付森 on 2018/11/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSMainController.h"

static NSString * const kTitleKey = @"kTitleKey";

static NSString * const kControllerKey = @"kControllerKey";

@interface FSMainController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.dataArray = @[@{kTitleKey:@"Q(Zone)分享(登陆)",kControllerKey:@"FSController01"},
                       @{kTitleKey:@"WeChat分享",kControllerKey:@"FSController02"},
                       @{kTitleKey:@"系统通知",kControllerKey:@"FSController03"},];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"main_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *title = [dict objectForKey:kTitleKey];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];

    NSString *controllerName = [dict objectForKey:kControllerKey];
    
    if (!controllerName.length) return;
    
    Class classObj = NSClassFromString(controllerName);
    
    if (classObj == nil) return;
    
    id obj = [[classObj alloc] init];
    
    if (![obj isKindOfClass:[FSBaseController class]]) return;
    
    NSString *title = [dict objectForKey:kTitleKey];
    
    [obj setTitle:title];
    
    [self.navigationController pushViewController:obj animated:YES];
}


@end
