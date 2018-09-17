//
//  NSString+Custom.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/20.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.6版本-新增类,时间可视化转换.--------------------
#import "NSString+Custom.h"

@implementation NSString (Custom)
+ (instancetype)timeformatFromSeconds:(NSTimeInterval)seconds {
    int minute = (int)seconds/60;
    int second = (int)seconds%60;
    if (minute < 100) {
        NSString *time = [NSString stringWithFormat:@"%.2d:%.2d", minute, second];
        return time;
    } else {
        NSString *time = [NSString stringWithFormat:@"%d:%.2d", minute, second];
        return time;
    }
}
@end
//----------------------------end------------------------------

