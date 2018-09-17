//
//  TZPlayerUtils.h
//  TZVideoDemo
//
//  Created by Dream on 2018/8/21.
//  Copyright © 2018年 TZ. All rights reserved.
//

//--------------------------2.8版本-增加音量,亮度类---------------------
#import <Foundation/Foundation.h>

@interface TZPlayerUtils : NSObject
@property (assign,nonatomic) float volume;  /**< 音量 */

+ (instancetype)sharedUtils;            /**< 单例 */
+ (float)getSystemVolume;               /**< 音量设置 */
+ (void)setSystemVolume:(float)volume;  /**< 音量设置 */

+ (void)setSystemBrightness:(CGFloat)brightness;  /**< 亮度设置 */
@end
//----------------------------end------------------------------

