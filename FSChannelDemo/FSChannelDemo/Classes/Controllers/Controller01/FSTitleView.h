//
//  FSTitleView.h
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTitleView : UIView

@property (nonatomic) BOOL showUnderLine;

- (void)setupClickCloseBtn:(void(^)(void))block;

@end
