//
//  ViewController.m
//  vcLifeMethod_review
//
//  Created by chensixin on 2025/10/30.
//

#import "ViewController.h"
#import "secViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIButton *interSecVCBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        _baseView = [[UIView alloc] init];
        _baseView.frame = self.view.frame;
        _baseView.backgroundColor = [UIColor orangeColor];
        [_baseView addSubview:({
            UILabel *oneLabel = [UILabel new];
            CGFloat width = 200;
            CGFloat height = 50;
            CGFloat x = (self.view.frame.size.width - width) * 0.5;
            CGFloat y = (self.view.frame.size.height - height) * 0.5;
            oneLabel.frame = CGRectMake(x, y, width, height);
            [oneLabel setText:@"能看到这个视图吗？👀"];
            oneLabel;
        })];
        _baseView;
    })];
    
    [self.baseView addSubview:({
        _interSecVCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _interSecVCBtn.frame = CGRectMake(48, 47, 50, 40);
        [_interSecVCBtn setTitle:@"inter" forState:UIControlStateNormal];
        [_interSecVCBtn addTarget:self action:@selector(interBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _interSecVCBtn;
    })];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear 视图将要出现");
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear 视图已经出现");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    NSLog(@"in [firstVC dealloc] vcs : %@", self.navigationController.viewControllers);
    NSLog(@"dealloc 此 vc 即将消失");
}

#pragma mark - Helper
- (void)interBtnClicked{
    secViewController *svc = [secViewController new];
    svc.modalPresentationStyle = UIModalPresentationFullScreen;
    // 给 vc2(svc) 创建一个 nav，这样 vc2 可以通过导航栏的方式弹出 vc3
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    
    // 1. vc1 模式跳转到 vc2
    [self presentViewController:nav animated:YES completion:nil];
    
    NSLog(@"in [firstVC interBtnClicked] vcs : %@", self.navigationController.viewControllers);
}

@end
