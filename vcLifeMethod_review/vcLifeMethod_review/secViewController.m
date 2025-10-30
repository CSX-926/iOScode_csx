//
//  secViewController.m
//  vcLifeMethod_review
//
//  Created by chensixin on 2025/10/30.
//

#import "secViewController.h"
#import "thdViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface secViewController()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *intoThd;

@end

@implementation secViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:({
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(20, 47, 100, 40);
        [_backBtn setBackgroundColor:[UIColor whiteColor]];
        _backBtn.layer.cornerRadius = 4;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.borderWidth = 2;
        _backBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [_backBtn setTitle:@"back" forState:UIControlStateNormal];
        [_backBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang SC" size:24]];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _backBtn;
    })];
    
    [self.view addSubview:({
        _intoThd = [UIButton buttonWithType:UIButtonTypeSystem];
        _intoThd.frame = CGRectMake(100, 400, 200, 100);
        [_intoThd setTitle:@"next" forState:UIControlStateNormal];
        [_intoThd addTarget:self action:@selector(intoThdBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _intoThd;
    })];
    
}

- (void)dealloc
{
    NSLog(@"secViewController delloc");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}


#pragma mark - helper
- (void)backBtnClicked{
    // 模式的方式消失 svc
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)intoThdBtnClicked{
    thdViewController *tvc = [thdViewController new];
    // 使用 导航栏来弹入 vc
    [self.navigationController pushViewController:tvc animated:YES];
    
}
@end

NS_ASSUME_NONNULL_END
