//
//  PersonModel.h
//  aboutKVC_KVO
//
//  Created by chensixin on 2025/9/10.
//

#import <Foundation/Foundation.h>
#import "puppyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) float height;

@property(nonatomic, strong) puppyModel *puppy;

-(void) print_privateVar;

@end

NS_ASSUME_NONNULL_END
