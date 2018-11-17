//
//  FSDrawer02.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSDrawer02.h"
#import "FSDrawerContent02.h"

static CGFloat const kContentViewDefaultY = 20;

@interface FSDrawer02 ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, weak) FSDrawerContent02 *contentView;

@property (nonatomic, strong) UIPanGestureRecognizer *contentViewPanGesture;

@property (nonatomic, assign) CGPoint lastScrollViewTranslation;

@end

@implementation FSDrawer02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    CGSize size = self.view.bounds.size;
    
    CGRect frame = CGRectMake(0, kContentViewDefaultY, size.width, size.height - kContentViewDefaultY);
    
    FSDrawerContent02 *contentView = [[FSDrawerContent02 alloc] initWithFrame:frame];
    
    self.contentView = contentView;
    
    contentView.backgroundColor = [UIColor blueColor];
    
    
    //    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    //
    //    longPress.minimumPressDuration = 1.5;
    //
    //    [contentView addGestureRecognizer:longPress];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    self.contentViewPanGesture = panGesture;
    
    panGesture.delegate = self;
    
    panGesture.delaysTouchesBegan = NO;
    
    panGesture.delaysTouchesEnded = NO;
    
    [contentView addGestureRecognizer:panGesture];
    
    [self.view addSubview:contentView];
}

- (void)popSelf
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.height);
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
    }];
}


- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    NSLog(@"长按手势来了");
}

/**
 可用方法1
 */
- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translationPoint = [gesture translationInView:self.view];
    
    //    NSLog(@"%@",NSStringFromCGPoint(translationPoint));
    
    [gesture setTranslation:CGPointZero inView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        /// 向上拖动
        if (translationPoint.y < 0)
        {
            NSLog(@"上....");
            
            // 向上拖动时，contentView
            if (self.contentView.y > kContentViewDefaultY)
            {
                NSLog(@"contentView.transform.ty 大于0");
                
                [self.contentView.collectionView setContentOffset:CGPointZero animated:NO];
                
                CGFloat tmpY = self.contentView.y;
                
                self.contentView.y = tmpY + translationPoint.y;
                
                self.contentView.collectionView.userInteractionEnabled = NO;
            }
            else
            {
                NSLog(@"contentView.transform.ty <= 0, 小于等于0");
                
                self.contentView.y = kContentViewDefaultY;
                
                self.contentView.collectionView.userInteractionEnabled = YES;
            }
        }
        else
        {
            /* 向下拖动 */
            
            // 向下拖动，但是此时只移动collectionView
            if (self.contentView.y == kContentViewDefaultY &&
                self.contentView.collectionView.contentOffset.y >= 0)
            {
                NSLog(@"只移动collectionView");
                
                self.contentView.collectionView.userInteractionEnabled = YES;

                CGPoint point = CGPointMake(0, self.contentView.collectionView.contentOffset.y);

                [self.contentView.collectionView setContentOffset:point animated:NO];

                return;
            }
            
            NSLog(@".....下");
            
            CGFloat tmpY = self.contentView.y;
            
            self.contentView.y = tmpY + translationPoint.y;
            
            [self.contentView setNeedsLayout];
            
            CGPoint scrollViewPoint = [self.contentView.collectionView.panGestureRecognizer translationInView:self.contentView.collectionView];
            
            CGFloat tmpValue = 0;
            
            if (!CGPointEqualToPoint(self.lastScrollViewTranslation, CGPointZero) &&
                !CGPointEqualToPoint(scrollViewPoint, CGPointZero))
            {
               tmpValue  = scrollViewPoint.y - self.lastScrollViewTranslation.y;
            }
            
            self.lastScrollViewTranslation = scrollViewPoint;
            
            NSLog(@"scrollViewPoint___: %@",NSStringFromCGPoint(scrollViewPoint));

//            NSLog(@"%@",NSStringFromCGPoint(self.contentView.collectionView.panGestureRecognizer));

            [self.contentView.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
            
            self.contentView.collectionView.userInteractionEnabled = NO;
        }
        
        NSLog(@"手势进行中");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"手势结束了");
        
        self.contentView.collectionView.userInteractionEnabled = YES;
        
        CGFloat tmpH = self.contentView.height;
        
        CGFloat ty = (self.contentView.y - kContentViewDefaultY);
        
        if (ty <= tmpH * 0.4)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.contentView.y = kContentViewDefaultY;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.contentView.y = tmpH;
                
            } completion:^(BOOL finished) {
                
                [self.view removeFromSuperview];
                
                [self removeFromParentViewController];
            }];
        }
        
    }
}


#pragma mark UIGestureRecognizerDelegate

//是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
//是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"手势代理来了吗................");
    
    return YES;
    
}

- (void)dealloc
{
    NSString *message = [NSString stringWithFormat:@"%@ dealloc",NSStringFromClass([self class])];
    
    NSLog(@"%@",message);
}


@end
