//
//  ViewController.m
//  GCD_training
//
//  Created by chensixin on 2025/10/31.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *oneStr; 

@end

// 主要的两种使用，延后执行和放到指定的线程执行

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneStr = @"my name is oneStr";
    
    [self oneBlockForTextCatchOuterProperty];

}


//       获取当前的时间
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
- (void)afterUse_GCD{
    NSLog(@"程序启动, 时间为 %f", [[NSDate date] timeIntervalSince1970]);
    // ----- 延后个 5 秒钟执行
    // GCD
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"现在是 %f", [[NSDate date] timeIntervalSince1970]);
    });
    /*
         程序启动, 时间为 1761894765.212335
         现在是 1761894770.374543
     */
}

- (void)threadUse_GCD{
    // 将要执行的任务放到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        // do something
    });
}


/*
    块类型定义：
        return_type (^block_name)(parameters)
    块定义：
        ^(参数){
            some code
        }
 */
- (void)someBlock{
    
//    void (^oneBlock)() = ^{
//        NSLog(@"this block called oneBlock");
//    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        oneBlock;
    });
    
    
    
    int (^addBlock)(int a, int b) = ^(int a, int b){
        return a + b;
    };
    int addAns = addBlock(3, 4); // 直接当函数用，一样的
}


- (void)oneBlockForTextCatchOuterProperty{
    NSString *otherStr = @"world";
    
    NSString *(^StrPrint)(NSString *Str) = ^(NSString *str){
        NSLog(@"oneStr : %@", self.oneStr);
        NSString * s = [str stringByAppendingString:otherStr];
        return s;
    };
    
    NSLog(@"the block ans str is %@", StrPrint(@"hello"));
}


@end
