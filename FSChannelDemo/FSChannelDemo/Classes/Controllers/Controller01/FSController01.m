//
//  FSController01.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/2.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController01.h"
#import "FSDrawer01.h"


@interface FSController01 ()


@end

@implementation FSController01

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(doLeftItemAction)];
    
    
}

- (void)doLeftItemAction
{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    FSDrawer01 *channel = [[FSDrawer01 alloc] init];
    
    [root addChildViewController:channel];
    
    channel.view.frame = self.view.bounds;
    
    CGSize size = self.view.bounds.size;
    
    channel.view.transform = CGAffineTransformMakeTranslation(0, size.height);
    
    [root.view addSubview:channel.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        channel.view.transform = CGAffineTransformIdentity;
    }];
}


@end
