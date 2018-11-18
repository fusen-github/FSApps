//
//  FSController01.m
//  FSSenior
//
//  Created by 付森 on 2018/11/15.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController01.h"
#import "FSTencentManager.h"
#import "FSQQShare.h"


@interface FSController01 ()

@end

@implementation FSController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [self testLoginAuth];
    
    //    [self testQQShare_text];
    
    [self testShareVideo];
}

- (void)testLoginAuth
{
    [[FSTencentManager shareManager] loginOauth];
}

- (void)testQQShare_text
{
    [[FSTencentManager shareManager] shareTextToFriend:@"fs_测试分享文本到好友"];
}

- (void)testQQShare_image
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"354.jpg" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSString *title = @"测试分享图片——标题";
    
    NSString *desc = @"测试分享图片——描述";
    
    NSError *error = nil;
    
    [[FSTencentManager shareManager] shareImageDataToFriend:data title:title desc:desc error:&error];
}

- (void)testShareUrl
{
    [[FSTencentManager shareManager] shareUrl];
}

- (void)testShareVideo
{
    [[FSTencentManager shareManager] shareVideo];
}



@end
