//
//  ViewController.m
//  UIScrollView_loopImage
//
//  Created by chensixin on 2025/10/10.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *images;

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.width = self.view.bounds.size.width;
    self.height = 200;
    // frame 是 scrollView 的当前可视的部分
    self.scrollView.frame = CGRectMake(0, 200, self.width, self.height);
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor systemGrayColor];
    [self.view addSubview:self.scrollView];
    
    [self loadData];
}

- (void)loadData{
    self.images = @[@"image_01", @"image_02", @"image_03"];
    
    // 采用的是 1 + 图片数组 + 1 的方式
    NSMutableArray *tempArrays = [NSMutableArray array];
    [tempArrays addObject:self.images.lastObject];
    [tempArrays addObjectsFromArray:self.images];
    [tempArrays addObject:self.images.firstObject];
    
    
    NSInteger index = 0;
    for(NSString *str in tempArrays){ // 遍历的是 图片数组的名字
        UIImage *image = [UIImage imageNamed:str];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        /// 设置当前这个 imageView 的位置布局
        imageView.frame = CGRectMake(index * self.width, 0, self.width, self.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;// 最乖巧的一种方式
        
        [self.scrollView addSubview:imageView];
        index++;
    }
    
    // contentSize  内容的size
    self.scrollView.contentSize = CGSizeMake(index * self.width, self.height);
    [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
}


/// UIScrollView 本身是支持滑动的，它会根据滑动的行为去判断，可直接获取当前的 scrollView 的偏移位置 也可直接设置

/// 实现滑动效果的最重要的代码
#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /// 可视单页的大小
    CGFloat onePageWidth = scrollView.frame.size.width;
    /// 当前的偏移位置
    CGFloat offsetX = scrollView.contentOffset.x;
    /// 获取当前的偏移量
    NSInteger index = offsetX / onePageWidth;
    
    
    if(index == 0){
        [scrollView setContentOffset:CGPointMake(self.images.count * onePageWidth, 0) animated:NO];
    }else if(index == self.images.count + 1){
        [scrollView setContentOffset:CGPointMake(onePageWidth, 0) animated:NO];
    }
}


@end
