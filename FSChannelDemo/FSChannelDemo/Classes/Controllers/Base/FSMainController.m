//
//  FSMainController.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/2.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSMainController.h"
#import "FSController01.h"

static NSString * const kTitleKey = @"kTitleKey";

static NSString * const kControllerKey = @"kControllerKey";

@interface FSMainController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.frame = self.view.bounds;
    
    [self.view addSubview:tableView];
    
    self.dataArray =
  @[@{kControllerKey:@"FSController01",kTitleKey:@"滑动控件测试1"},
    @{kControllerKey:@"FSController02",kTitleKey:@"滑动控件测试2"},];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"channel_main_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
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
    
    NSString *name = [dict objectForKey:kControllerKey];
    
    if (![name isKindOfClass:[NSString class]] || !name.length) {
        return;
    }
    
    Class classObj = NSClassFromString(name);
    
    if (!classObj) {
        return;
    }
    
    FSBaseViewController *controller = [[classObj alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)leftItemAction
{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    FSController01 *channel = [[FSController01 alloc] init];
    
    [root addChildViewController:channel];
    
    channel.view.frame = self.view.bounds;
    
    CGSize size = self.view.bounds.size;
    
    channel.view.transform = CGAffineTransformMakeTranslation(0, size.height);
    
    [root.view addSubview:channel.view];
    
    [UIView animateWithDuration:0.25 animations:^{
       
        channel.view.transform = CGAffineTransformIdentity;
    }];
    
//    channel.modalPresentationStyle = UIModalPresentationFormSheet;
    
//    channel.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//    [self presentViewController:channel animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
