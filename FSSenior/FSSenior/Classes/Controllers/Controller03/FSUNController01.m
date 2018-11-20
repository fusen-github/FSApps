//
//  FSUNController01.m
//  FSSenior
//
//  Created by 付森 on 2018/11/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSUNController01.h"

@interface FSUNController01 ()

@property (nonatomic, strong) id userinfo;

@end

@implementation FSUNController01

- (instancetype)initWithUserInfo:(id)userinfo
{
    if (self = [super init])
    {
        self.userinfo = userinfo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    
    [self.view addSubview:textView];
    
    NSString *string = [self.userinfo description];
    
    textView.text = string;
    
    NSLog(@"打印userinfo %@",self.userinfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
