//
//  ViewController.m
//  infiniteScroll_C
//
//  Created by chensixin on 2025/11/5.
//
// 使用 UICollectionView 实现无限轮播

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionViewCell *collectionCell;
@property (nonatomic, strong) NSArray<UIColor *> *colorArray;
@property (nonatomic, assign) NSInteger colorIndex;

@end


static const CGFloat COLLECTIONVIEW_H = 300;
static const NSInteger ITEMCOUNT = 3; // 颜色分别为 红 绿 黄
static NSString * const CELLIREGISTER = @"CELLIREGISTER";


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupCollectionView];
    
}


- (void)setupCollectionView{
    
    CGRect srceenBounds = [UIScreen mainScreen].bounds;
    CGFloat y = (srceenBounds.size.height - COLLECTIONVIEW_H) * 0.5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, COLLECTIONVIEW_H) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLIREGISTER];
    
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollDirectionHorizontal animated:YES];
}


- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect srceenBounds = [UIScreen mainScreen].bounds;
        _flowLayout.itemSize = CGSizeMake(srceenBounds.size.width, COLLECTIONVIEW_H);
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

- (void)setupData{
    self.colorArray = @[[UIColor redColor],
                        [UIColor greenColor],
                        [UIColor yellowColor]];
    self.colorIndex = 0;
}





#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ITEMCOUNT + 2; /// 设置了 3 + 2张图
}


/// 绿 红 黄 绿 红
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CELLIREGISTER forIndexPath:indexPath];
    
    if(indexPath.item == 0){
        self.colorIndex = ITEMCOUNT - 1; /// 设置最后一种颜色
    }else if(indexPath.item == ITEMCOUNT + 1){
        self.colorIndex = 0; /// 设置为第一种颜色
    }else{
        self.colorIndex = indexPath.item - 1;
    }
    
    cell.backgroundColor = self.colorArray[self.colorIndex];
    return cell;
}


#pragma mark - 滑动
/// collection
/// 滚动视图完全停止的时候调用
/// 实现滑动到虚假的第一张的时候，设置到真正的最后一张；滑动到虚假的最后一张的时候，设置到真正的第一张
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / width; /// 标准的应该是 1 2  ITEMCOUNT
    
    if(index == 0){
        NSIndexPath *path = [NSIndexPath indexPathForItem:ITEMCOUNT inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if(index == ITEMCOUNT + 1){
        NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}


@end
