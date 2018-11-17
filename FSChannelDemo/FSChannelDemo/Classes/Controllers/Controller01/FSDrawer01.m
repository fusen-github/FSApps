//
//  FSDrawer01.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSDrawer01.h"
#import "FSTitleView.h"
#import "FSChannelCell.h"
#import "FSChannelHeader.h"
#import "FSContentView.h"

static NSString * const kChannelCellId = @"kChannelCellId";

static NSString * const kChannelHeaderId = @"kChannelHeaderId";

static NSString * const kHeaderTitlekey = @"kHeaderTitlekey";

static NSString * const kHeaderDetailTitleKey = @"kHeaderDetailTitleKey";

static NSString * const kDatasKey = @"kDatasKey";

static CGFloat const kContentViewDefaultY = 20;

@interface FSDrawer01 ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) FSTitleView *titleView;

@property (nonatomic, strong) UIPanGestureRecognizer *contentViewPanGesture;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIView *contentView;

//@property (nonatomic, assign) BOOL isDown;

@end

@implementation FSDrawer01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    FSContentView *contentView = [[FSContentView alloc] init];
    
    self.contentView = contentView;
    
    CGSize size = self.view.bounds.size;
    
    contentView.frame = CGRectMake(0, kContentViewDefaultY, size.width, size.height - kContentViewDefaultY);
    
    contentView.backgroundColor = [UIColor blueColor];
    
    
    //    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    //
    //    longPress.minimumPressDuration = 1.5;
    //
    //    [contentView addGestureRecognizer:longPress];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    self.contentViewPanGesture = panGesture;
    
    panGesture.delegate = self;
    
    [contentView addGestureRecognizer:panGesture];
    
    [self.view addSubview:contentView];
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 3)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    
    contentView.layer.mask = layer;
    
    FSTitleView *titleView = [[FSTitleView alloc] init];
    
    self.titleView = titleView;
    
    __weak typeof(self) wSelf = self;
    
    [titleView setupClickCloseBtn:^{
        
        [wSelf popSelf];
    }];
    
    titleView.frame = CGRectMake(0, 0, contentView.height, 40);
    
    [contentView addSubview:titleView];
    
    
    [self loadData];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(75, 35);
    
    layout.headerReferenceSize = CGSizeMake(contentView.width, 40);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumInteritemSpacing = 15;
    
    layout.minimumLineSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    CGRect frame = CGRectMake(0, titleView.maxY, contentView.width, contentView.height - titleView.maxY);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    self.collectionView = collectionView;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    
    [collectionView registerClass:[FSChannelCell class] forCellWithReuseIdentifier:kChannelCellId];
    
    [collectionView registerClass:[FSChannelHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderId];
    
    [contentView addSubview:collectionView];
    
    contentView.collectionView = collectionView;
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


- (void)loadData
{
    NSArray *items1 = @[@"关注",@"推荐",@"新时代",@"视频",@"热点",@"北京",
                        @"图片",@"娱乐",@"问答",@"懂车帝",@"财经",@"科技",
                        @"军事",@"体育",@"段子",@"国际",@"趣图",@"健康",@"特卖",@"房产"];
    
    NSArray *items2 = @[@"小说",@"时尚",@"历史",@"育儿",@"直播",@"搞笑",@"数码",
                        @"美食",@"养生",@"电影",@"手机",@"旅游",@"宠物",@"情感",
                        @"家具",@"教育",@"三农",@"孕产",@"文化",@"游戏",@"股票",
                        @"科学",@"动漫",@"故事",@"收藏",@"精选",@"语录",@"星座",
                        @"美图",@"辟谣",@"中国新唱将",@"微头条",@"互联网法院",@"快乐男声",
                        @"传媒",@"正能量",@"彩票",@"中国好表演",@"放心购",@"公益"];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    NSDictionary *dict1 = @{kHeaderTitlekey:@"我的频道",
                            kHeaderDetailTitleKey:@"点击进入我的频道",
                            kDatasKey:items1};
    
    NSDictionary *dict2 = @{kHeaderTitlekey:@"频道推荐",
                            kHeaderDetailTitleKey:@"点击添加频道",
                            kDatasKey:items2};
    
    [tmpArray addObject:dict1];
    
    [tmpArray addObject:dict2];
    
    self.dataArray = tmpArray;
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
                
                [self.collectionView setContentOffset:CGPointZero animated:NO];
                
                CGFloat tmpY = self.contentView.y;
                
                self.contentView.y = tmpY + translationPoint.y;
                
                self.collectionView.userInteractionEnabled = NO;
            }
            else
            {
                NSLog(@"contentView.transform.ty <= 0, 小于等于0");
                
                self.contentView.y = kContentViewDefaultY;
                
                self.collectionView.userInteractionEnabled = YES;
            }
        }
        else
        {
            /* 向下拖动 */
            
            // 向下拖动，但是此时只移动collectionView
            if (self.contentView.y == kContentViewDefaultY &&
                self.collectionView.contentOffset.y >= 0)
            {
                NSLog(@"只移动collectionView");
                
                self.collectionView.userInteractionEnabled = YES;
                
                CGPoint point = CGPointMake(0, self.collectionView.contentOffset.y);
                
                [self.collectionView setContentOffset:point animated:NO];
                
                return;
            }
            
            NSLog(@".....下");
            
            CGFloat tmpY = self.contentView.y;
            
            self.contentView.y = tmpY + translationPoint.y;
            
            //            [self.contentView setNeedsLayout];
            
            [self.collectionView setContentOffset:CGPointZero animated:NO];
            
            self.collectionView.userInteractionEnabled = NO;
        }
        
        NSLog(@"手势进行中");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"手势结束了");
        
        self.collectionView.userInteractionEnabled = YES;
        
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

/**
 可用方法2
 */
- (void)panGesture_00:(UIPanGestureRecognizer *)gesture
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
            if (self.contentView.transform.ty > 0)
            {
                NSLog(@"contentView.transform.ty 大于0");
                
                [self.collectionView setContentOffset:CGPointZero animated:NO];
                
                CGFloat tmpY = self.contentView.transform.ty;
                
                self.contentView.transform = CGAffineTransformMakeTranslation(0, tmpY + translationPoint.y);
            }
            else
            {
                NSLog(@"contentView.transform.ty <= 0, 小于等于0");
                
                self.contentView.transform = CGAffineTransformIdentity;
            }
        }
        else
        {
            /* 向下拖动 */
            
            // 向下拖动，但是此时只移动collectionView
            if (CGAffineTransformIsIdentity(self.contentView.transform) &&
                self.collectionView.contentOffset.y >= 0)
            {
                NSLog(@"只移动collectionView");
                
                CGPoint point = CGPointMake(0, self.collectionView.contentOffset.y);
                
                [self.collectionView setContentOffset:point animated:NO];
                
                return;
            }
            
            NSLog(@".....下");
            
            CGFloat tmpY = self.contentView.transform.ty;
            
            self.contentView.transform = CGAffineTransformMakeTranslation(0, tmpY + translationPoint.y);
            
            [self.collectionView setContentOffset:CGPointZero animated:NO];
        }
        
        NSLog(@"手势进行中");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"手势结束了");
        
        CGFloat tmpH = self.contentView.height;
        
        CGFloat ty = fabs(self.contentView.transform.ty);
        
        if (ty <= tmpH * 0.4)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.contentView.transform = CGAffineTransformIdentity;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                self.contentView.transform = CGAffineTransformMakeTranslation(0, tmpH);
                
            } completion:^(BOOL finished) {
                
                [self.view removeFromSuperview];
                
                [self removeFromParentViewController];
            }];
        }
        
    }
}


/**
 不可用方法
 */
- (void)panGesture_old:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"panGesture_collectionView.contentOffset.y: %lf",self.collectionView.contentOffset.y);
    
    CGPoint translationPoint = [gesture translationInView:self.contentView];
    
    NSLog(@"%@",NSStringFromCGPoint(translationPoint));
    
    [gesture setTranslation:CGPointZero inView:self.contentView];
    
    if (self.collectionView.contentOffset.y > 0)
    {
        return;
    }
    
    //    NSLog(@"do some thing");
    
    return;
    
    CGPoint point = [gesture translationInView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"point.y = %lf",point.y);
        
        if (point.y >= 0)
        {
            if (self.collectionView.contentOffset.y <= 0)
            {
                self.contentView.y = (20 + point.y);
            }
            
        }
        else
        {
            self.contentView.y = kContentViewDefaultY;
            
            self.collectionView.panGestureRecognizer.enabled = YES;
            
            self.collectionView.contentOffset = CGPointMake(0, 0.5);
            
            self.contentViewPanGesture.enabled = NO;
            
            NSLog(@"lailelelel");
            
            //            if (self.collectionView.contentOffset.y == 0)
            //            {
            ////                self.collectionView.contentOffset = CGPointMake(0, 0.5);
            //            }
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (self.contentView.y >= self.contentView.height * 0.4)
        {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.height);
                
            } completion:^(BOOL finished) {
                
                [self.view removeFromSuperview];
                
                [self removeFromParentViewController];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.contentView.y = 20;
            }];
        }
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *sectionDict = self.dataArray[section];
    
    NSArray *sectionDatas = [sectionDict objectForKey:kDatasKey];
    
    return sectionDatas.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FSChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChannelCellId forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        cell.bgColor = [UIColor groupTableViewBackgroundColor];
        
        cell.showBoard = NO;
    }
    else
    {
        cell.bgColor = [UIColor whiteColor];
        
        cell.showBoard = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(FSChannelCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDict = self.dataArray[indexPath.section];
    
    NSArray *sectionDatas = [sectionDict objectForKey:kDatasKey];
    
    NSString *title = sectionDatas[indexPath.item];
    
    if (indexPath.section == 1)
    {
        title = [NSString stringWithFormat:@"＋ %@",title];
    }
    
    cell.text = title;
}


// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FSChannelHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderId forIndexPath:indexPath];
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
    
    NSString *title = [dict objectForKey:kHeaderTitlekey];
    
    NSString *detail = [dict objectForKey:kHeaderDetailTitleKey];
    
    header.title = title;
    
    header.detailTitle = detail;
    
    return header;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
////    NSLog(@"scrollView.offset.y = %lf",scrollView.contentOffset.y);
//
////    self.contentViewPanGesture.enabled = NO;
////
////    [self.contentView resignFirstResponder];
//
//    scrollView.panGestureRecognizer.enabled = NO;
//
//    [scrollView resignFirstResponder];
//
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint offset = scrollView.contentOffset;
//
//    if (!self.titleView.showUnderLine && offset.y > 0)
//    {
//        self.titleView.showUnderLine = YES;
//    }
//    else if (self.titleView.showUnderLine && offset.y <= 0)
//    {
//        self.titleView.showUnderLine = NO;
//    }
//
//    NSLog(@"scrollView.offset.y = %lf",offset.y);
//
//    if (offset.y <= 0)
//    {
//        [scrollView resignFirstResponder];
//
//        scrollView.panGestureRecognizer.enabled = NO;
//
//        [self.contentView becomeFirstResponder];
//
//        self.contentViewPanGesture.enabled = YES;
//
//        NSLog(@"第一");
//    }
////    else if (offset.y == 0)
////    {
////        self.contentViewPanGesture.enabled = YES;
////
////        scrollView.panGestureRecognizer.enabled = NO;
////    }
//    else
//    {
//        self.contentViewPanGesture.enabled = NO;
//
//        scrollView.panGestureRecognizer.enabled = YES;
//
//        [scrollView becomeFirstResponder];
//
//        [self.contentView resignFirstResponder];
//
//        NSLog(@"第三");
//    }
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging: %f",scrollView.contentOffset.y);
}


//开始进行手势识别时调用的方法，返回NO则结束识别，不再触发手势，用处：可以在控件指定的位置使用手势识别
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
////    NSLog(@"%s",__func__);
//
//    CGFloat collectionViewOffsetY = self.collectionView.contentOffset.y;
//
//    NSLog(@"1、collectionViewOffsetY = %f", collectionViewOffsetY);
//
//    if (collectionViewOffsetY > 0)
//    {
//        NSLog(@"1、collectionViewOffsetY = %f, 大于0，不在识别contentView的手势", collectionViewOffsetY);
//
//        return NO;
//    }
//    else if (collectionViewOffsetY == 0)
//    {
//        CGAffineTransform transform = self.contentView.transform;
//
////        CGAffineTransformIsIdentity(transform);
//
//        if (self.contentView)
//        {
//
//        }
//
//        NSLog(@"collectionViewOffsetY == 0, 根据情况特殊处理");
//    }
//    else
//    {
//        NSLog(@"开始识别contentView的手势——————");
//    }
//
//    return YES;
//}


//是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
//是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //    CGFloat collectionViewOffsetY = self.collectionView.contentOffset.y;
    //
    //    NSLog(@"2、collectionViewOffsetY = %f", collectionViewOffsetY);
    
    //    if ([gestureRecognizer.view isEqual:self.contentView] &&
    //        [otherGestureRecognizer.view isEqual:self.collectionView])
    //    {
    //        NSLog(@"all equal %f",self.collectionView.contentOffset.y);
    //    }
    //    else
    //    {
    //        NSLog(@"not all equal");
    //    }
    
    NSLog(@"手势代理来了吗................");
    
    return YES;
    
}



// 这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    CGFloat collectionViewOffsetY = self.collectionView.contentOffset.y;
//
//    NSLog(@"3、collectionViewOffsetY = %f", collectionViewOffsetY);
//
//    return NO;
//}

//这个方法返回YES，第一个和第二个互斥时，第二个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

//手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
//此方法在window对象在有触摸事件发生时，调用gesture recognizer的touchesBegan:withEvent:方法之前调用，如果返回NO,则gesture recognizer不会看到此触摸事件。(默认情况下为YES)
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    NSLog(@"%s",__func__);
//
//    return YES;
//}


- (void)dealloc
{
    NSString *message = [NSString stringWithFormat:@"%@ dealloc",NSStringFromClass([self class])];
    
    NSLog(@"%@",message);
}

@end
