//
//  FSChannelCell.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSChannelCell.h"

@interface FSChannelCell ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation FSChannelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UILabel *label = [[UILabel alloc] init];
    
    self.label = label;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor darkTextColor];
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.adjustsFontSizeToFitWidth = YES;
    
    [self.contentView addSubview:label];
}

- (void)setBgColor:(UIColor *)bgColor
{
    UIColor *tmpColor = bgColor;
    
    if (tmpColor == nil)
    {
        tmpColor = [UIColor groupTableViewBackgroundColor];
    }
    
    _bgColor = tmpColor;
    
    self.contentView.backgroundColor = tmpColor;
    
    [self setNeedsDisplay];
}

- (void)setShowBoard:(BOOL)showBoard
{
    _showBoard = showBoard;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.label.text = text;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = CGRectInset(self.contentView.bounds, 0.5, 0.5);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.showBoard)
    {
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.contentView.bounds];
//
//        self.label.layer.shadowPath = path.CGPath;
//
//        self.label.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//
//        self.label.layer.shadowOffset = CGSizeZero;
//
//        self.label.layer.shadowOpacity = 1;
//
//        self.label.layer.shadowRadius = 1;
        

        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        self.contentView.layer.borderWidth = 0.5;
    }
}

@end
