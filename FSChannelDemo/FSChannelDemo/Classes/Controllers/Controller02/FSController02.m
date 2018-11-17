//
//  FSController02.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController02.h"
#import "FSDrawer02.h"


@interface FSController02 ()

@end

@implementation FSController02

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(doLeftItemAction)];

}

- (void)doLeftItemAction
{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;

    FSDrawer02 *channel = [[FSDrawer02 alloc] init];

    [root addChildViewController:channel];

    channel.view.frame = self.view.bounds;

    CGSize size = self.view.bounds.size;

    channel.view.transform = CGAffineTransformMakeTranslation(0, size.height);

    [root.view addSubview:channel.view];

    [UIView animateWithDuration:0.25 animations:^{

        channel.view.transform = CGAffineTransformIdentity;
    }];
    
//    {
//        // 测试效果不对，会多一层视图覆盖app的rootViewController
//        FSDrawer02 *channel = [[FSDrawer02 alloc] init];
//
//        [self presentViewController:channel animated:YES completion:^{
//
//        }];
//    }
    
}


@end
