//
//  thdViewController.m
//  vcLifeMethod_review
//
//  Created by chensixin on 2025/10/30.
//

#import "thdViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface thdViewController()

@property (nonatomic, strong) UIButton *backToRoot;
@property (nonatomic, strong) UIButton *backToSec; // 回到第二个页面

@end

@implementation thdViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:({
        _backToSec = [UIButton buttonWithType:UIButtonTypeSystem];
        _backToSec.frame = CGRectMake(100, 200, 200, 100);
        [_backToSec setTitle:@"back to 2" forState:UIControlStateNormal];
        [_backToSec addTarget:self action:@selector(backToSecClicked) forControlEvents:UIControlEventTouchUpInside];
        _backToSec;
    })];
    
    [self.view addSubview:({
        _backToRoot = [UIButton buttonWithType:UIButtonTypeSystem];
        _backToRoot.frame = CGRectMake(100, 400, 200, 100);
        [_backToRoot setTitle:@"back to root" forState:UIControlStateNormal];
        [_backToRoot addTarget:self action:@selector(backToRootClicked) forControlEvents:UIControlEventTouchUpInside];
        _backToRoot;
    })];
}


#pragma mark SEL
- (void)backToSecClicked{
    // 因为 2 到 3 是导航栏的 push ，所以这里只能是 pop
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToRootClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
    // 这个只能弹到 svc 第二个vc页面，因为这个导航栏加载到 svc 上的
}


@end

NS_ASSUME_NONNULL_END
