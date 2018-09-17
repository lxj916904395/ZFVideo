//
//  UIColor+Customer.h
//  ZFVideo
//
//  Created by zhongding on 2018/9/10.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Customer)

+ (instancetype)colorWithHexString:(NSString *)hexStr;

+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
