//
//  FSTitleView.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSTitleView.h"
#import "UIView+Frame.h"


@interface FSTitleView ()

@property (nonatomic, weak) UIButton *cancel;

@property (nonatomic, copy) void(^clickBlock)(void);

@end

@implementation FSTitleView

- (void)setupClickCloseBtn:(void (^)(void))block
{
    self.clickBlock = block;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showUnderLine = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.cancel = cancel;
    
    [cancel setTitle:@"cancel" forState:UIControlStateNormal];
    
    cancel.backgroundColor = [UIColor redColor];
    
    cancel.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [cancel addTarget:self
               action:@selector(didClickClose:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:cancel];
}

- (void)didClickClose:(UIButton *)button
{
    if (self.clickBlock)
    {
        self.clickBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 25;
    
    CGFloat y = (self.height - height) * 0.5;
    
    self.cancel.frame = CGRectMake(20, y, 50, height);
}

- (void)setShowUnderLine:(BOOL)showUnderLine
{
    _showUnderLine = showUnderLine;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.showUnderLine)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(0, self.height - 0.5)];
        
        [path addLineToPoint:CGPointMake(self.width, self.height - 0.5)];
        
        [[UIColor darkGrayColor] setStroke];
        
        path.lineWidth = 0.5;
        
        [path stroke];
    }
}

@end
