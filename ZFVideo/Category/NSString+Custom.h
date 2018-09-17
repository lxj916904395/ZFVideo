//
//  NSString+Custom.h
//  TZVideoDemo
//
//  Created by Dream on 2018/8/20.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.6版本-新增类,时间可视化转换.--------------------
#import <Foundation/Foundation.h>

@interface NSString (Custom)
// 时间的分和秒进行可视化.
+ (instancetype)timeformatFromSeconds:(NSTimeInterval)seconds;

@end
//----------------------------end------------------------------

