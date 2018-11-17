//
//  FSDrawerContent02.m
//  FSChannelDemo
//
//  Created by 付森 on 2018/11/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSDrawerContent02.h"
#import "FSColletionView.h"
#import "FSChannelCell.h"

static NSString * const kChannelCellId = @"kChannelCellId";

static NSString * const kChannelHeaderId = @"kChannelHeaderId";

static NSString * const kHeaderTitlekey = @"kHeaderTitlekey";

static NSString * const kHeaderDetailTitleKey = @"kHeaderDetailTitleKey";

static NSString * const kDatasKey = @"kDatasKey";

@interface FSDrawerContent02 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSDrawerContent02

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
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 3)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
    
    [self loadData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionHeadersPinToVisibleBounds = YES;
    
    layout.itemSize = CGSizeMake(75, 35);
    
    layout.headerReferenceSize = CGSizeMake(self.width, 40);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumInteritemSpacing = 15;
    
    layout.minimumLineSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    
    
    CGRect frame = CGRectMake(0, 0, self.width, self.height);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    self.collectionView = collectionView;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    
    [collectionView registerClass:[FSChannelCell class] forCellWithReuseIdentifier:kChannelCellId];
    
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderId];
    
    [self addSubview:collectionView];
}

- (void)loadData
{
    NSArray *items1 = @[@"关注",@"推荐",@"新时代",@"视频",@"热点",@"北京",
                        @"图片",@"娱乐",@"问答",@"懂车帝",@"财经",@"科技",
                        @"军事",@"体育",@"段子",@"国际",@"趣图",@"健康",
                        @"特卖",@"房产",@"关注",@"推荐",@"新时代",@"视频",
                        @"热点",@"北京",@"图片",@"娱乐",@"问答",@"懂车帝",
                        @"财经",@"科技",@"军事",@"体育",@"段子",@"国际",
                        @"趣图",@"健康",@"特卖",@"房产",@"段子",@"国际",
                        @"关注",@"推荐",@"新时代",@"视频",@"热点",@"北京",
                        @"图片",@"娱乐",@"问答",@"懂车帝",@"财经",@"科技",
                        @"军事",@"体育",@"段子",@"国际",@"趣图",@"健康",
                        @"特卖",@"房产",@"关注",@"推荐",@"新时代",@"视频",
                        @"热点",@"北京",@"图片",@"娱乐",@"问答",@"懂车帝",
                        @"财经",@"科技",@"军事",@"体育",@"段子",@"国际",
                        @"趣图",@"健康",@"特卖",@"房产", @"段子",@"国际",];
    
    
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
    
//    [tmpArray addObject:dict2];
    
    self.dataArray = tmpArray;
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
    
//    if (indexPath.section == 1)
//    {
//        title = [NSString stringWithFormat:@"＋ %@",title];
//    }
    
    cell.text = title;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    FSChannelHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderId forIndexPath:indexPath];
//
//    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.section];
//
//    NSString *title = [dict objectForKey:kHeaderTitlekey];
//
//    NSString *detail = [dict objectForKey:kHeaderDetailTitleKey];
//
//    header.title = title;
//
//    header.detailTitle = detail;
//
//    return header;
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderId forIndexPath:indexPath];
    
    view.backgroundColor = [UIColor orangeColor];
    
    return view;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

@end
