//
//  main.m
//  aboutKVC_KVO
//
//  Created by chensixin on 2025/9/10.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"
#import "puppyModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        PersonModel *human1 = [[PersonModel alloc]init];
        PersonModel *human_ = [PersonModel new];
        
        //  初始化方式 
        /// 1.点语法，直接赋值
        human1.name = @"chensixin";
        human1.age = 20;
        human1.height = 161.3;
        human1.name = @"jinsaheun";        
        /// 2. KVC 初始化
        PersonModel *human2 = [[PersonModel alloc]init];
        [human2 setValue:@"syc" forKey:@"name"];
        [human2 setValue:@"21" forKey:@"age"];
        [human2 setValue:@"182.1" forKey:@"height"];
        [human1 setValue:@"csx" forKey:@"name"];
        
        /// 3. KVC 使用 forKeyPath， 访问内部点语法
        human1.puppy = [[puppyModel alloc]init]; /// 初始化
        [human1 setValue:@"福财" forKeyPath:@"puppy.puppyName"];
        [human1 setValue:@"csx" forKeyPath:@"name"];
        [human1 setValue:@"中华田园犬" forKeyPath:@"puppy.puppyType"];
        
        
        /// 4. KVC 方式访问私有成员变量                                                   重要，修改的特性很有用
        [human1 print_privateVar]; // 0
        [human1 setValue:@"926" forKeyPath:@"privateVar"];
        [human1 print_privateVar]; // 926
        
        
        
        /// 5. KVC 方式，直接传入字典， 实现传模型   这里的字典也是使用的是字面量语法
        NSDictionary *dic = @{
            @"name":@"jinsaheun",
            @"age":@"20"
        };
        [human1 setValuesForKeysWithDictionary:dic];
        
        NSDictionary *dict1 = @{
            @"name":@"jinsaheun",
            @"age":@"21"
        };
        [human1 setValuesForKeysWithDictionary:dict1];
        
        
        /// 6. 还可以实现模型转字典，将属性名字作为 key，用数组装起来
        NSDictionary *dict = [human1 dictionaryWithValuesForKeys:@[@"name", @"age"]];
        NSDictionary *dict12 = [human1 dictionaryWithValuesForKeys:@[@"name", @"age"]];
        NSLog(@"dict is %@", dict);
        
        
        /// 7. 还可以将数组中的所有模型的某种属性全部 提取出来
        PersonModel *human3 = [[PersonModel alloc]init];
        [human3 setValue:@"chris jin" forKeyPath:@"name"];
        [human3 setValue:@"20" forKeyPath:@"age"];
        
        NSArray *personArray = @[human1, human2, human3];
        NSArray *presonNames = [personArray valueForKeyPath:@"name"];
        
        NSLog(@"%@", presonNames); // 成功输出
    }
    return 0;
}


/*
    1. 赋值
    2. 字典转模型
    3. 模型转字典
    4. 访问私有成员变量
    5. 内部的点语法（对象的内部还有个对象这种
    6. 可以将数组中所有模型的某种属性全部提取出来
 */
