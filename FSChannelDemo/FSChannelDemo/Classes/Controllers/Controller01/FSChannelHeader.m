//
//  FSChannelHeader.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/4/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSChannelHeader.h"
#import "UIView+Frame.h"


@interface FSChannelHeader ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *detailLabel;


@end

@implementation FSChannelHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    self.titleLabel = titleLabel;
    
    titleLabel.textColor = [UIColor darkTextColor];
    
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    
    self.detailLabel = detailLabel;
    
    detailLabel.textColor = [UIColor lightGrayColor];
    
    detailLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:detailLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setDetailTitle:(NSString *)detailTitle
{
    _detailTitle = detailTitle;
    
    self.detailLabel.text = detailTitle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    CGFloat titleLableY = self.height - self.titleLabel.height;
    
    self.titleLabel.frame = CGRectMake(15, titleLableY, self.titleLabel.width, self.titleLabel.height);
    
    CGFloat detailX = self.titleLabel.maxX + 15;
    
    [self.detailLabel sizeToFit];
    
    CGFloat detailY = self.height - self.detailLabel.height;
    
    self.detailLabel.frame = CGRectMake(detailX, detailY, self.detailLabel.width, self.detailLabel.height);
    
    
}

@end
