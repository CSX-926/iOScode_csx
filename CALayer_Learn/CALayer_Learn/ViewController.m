//
//  ViewController.m
//  CALayer_Learn
//
//  Created by chensixin on 2025/9/25.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) CALayer *demoLayer;
@property(nonatomic, strong) CALayer *roomListCellLayer;

@property (nonatomic, strong) UIView *demoView;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupBezierPath];
//    [self setupGradientLayer];
//    [self setupShadow];
//    [self setupAnimation];
//    [self setupTextLayer];
    [self setupEmitterLayer];
}

/// 挖环形
- (void)setupBezierPath{
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.demoView];
    
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithOvalInRect:self.demoView.bounds];
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.demoView.bounds, 3, 3)];
    
    [outerPath appendPath:innerPath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer]; /// 使用 CAShapeLayer 的工厂方法，可以自动的设置默认属性，更推荐这种写法
    shapeLayer.path = outerPath.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd; /// 没有的话，环形就挖不出来，只有一个圆
    
    self.demoView.layer.mask = shapeLayer;
}

/// 渐变色
- (void)setupGradientLayer{
    [self.view addSubview:self.demoView];
    // 渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.demoView.bounds; 
    gradientLayer.cornerRadius = 20;
    gradientLayer.colors = @[
        ( __bridge id)[UIColor systemRedColor].CGColor,
        ( __bridge id)[UIColor systemGreenColor].CGColor
    ];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.demoView.layer insertSublayer:gradientLayer atIndex:0];
}

/// 阴影
- (void)setupShadow{
    
    [self.view addSubview:self.demoView];
    self.demoView.layer.shadowColor = [UIColor systemGrayColor].CGColor;
    self.demoView.layer.shadowOffset = CGSizeMake(20, 20);
    self.demoView.layer.shadowOpacity = 0.5;
      
}

/// 动画
- (void)setupAnimation{
    [self.view addSubview:self.demoView];
    // 旋转动画
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    ///  transform.rotation.z  垂直屏幕的方向，定住，旋转
    ///  transform.rotation.x  
    ///  transform.rotation.y  
    rotation.toValue = @(M_PI * 2); // 180度 * 2 一圈
    rotation.duration = 2; /// 一圈2秒
    rotation.repeatCount = HUGE_VALF; /// 无限循环
    [self.demoView.layer addAnimation:rotation forKey:@"rotaton_180_2"];
}

/// 动画的方式，绘制路径
- (void)setupShapeLayer_UIBezierPath{
    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    anim.fromValue = @0; // 0 弧度开始
//    anim.toValue = @1;
//    anim.byValue = @1;
//    anim.duration = 2.0;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [shape addAnimation:anim forKey:@"drawCircle_2"];
}

/// 重复叠加
- (void)setupReplocatorLayer{
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
//    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
    [replicator addSublayer:self.demoLayer];
    
    // 赋值10个，相对的偏移量是 (20, 20, 100)
    replicator.instanceCount = 10;
    replicator.instanceTransform = CATransform3DMakeTranslation(20, 20, 100);
    replicator.instanceDelay = 2;
}

/// 文字
- (void)setupTextLayer{
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"Hello CHEN SIXIN";
    textLayer.fontSize = 24;
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = CGRectMake(50, 500, 300, 50);
    [self.view.layer addSublayer:textLayer];

}

/// 雪花
- (void)setupEmitterLayer{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, 100);
    emitter.emitterShape = kCAEmitterLayerLine;
    emitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 1);
    emitter.emitterMode = kCAEmitterLayerPoint;
    [self.view.layer addSublayer:emitter];

    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;
    cell.birthRate = 5;
    cell.lifetime = 10;
    cell.velocity = 30; // 初始速度
    cell.velocityRange = 20; // 给速度一个随机的范围
    cell.yAcceleration = 30; // 下落加速度 y轴上的加速度
    cell.scale = 0.05; // 粒子图片的缩放大小

    emitter.emitterCells = @[cell];

}



#pragma mark - LazyLoad
- (UIView *)demoView{
    if(!_demoView){
        _demoView = [[UIView alloc] init];
        _demoView.frame = CGRectMake(50, 200, 100, 100);
        _demoView.backgroundColor = [UIColor orangeColor];
    }
    return _demoView;
}

@end
