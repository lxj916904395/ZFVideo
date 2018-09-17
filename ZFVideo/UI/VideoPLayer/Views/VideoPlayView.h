//
//  VideoPlayView.h
//  ZFVideo
//
//  Created by zhongding on 2018/9/13.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import "ZFPlayerControlView.h"

typedef NS_ENUM(NSInteger, TZPlayerControlViewGestureType) {
    TZPlayerControlViewGestureTypeNone = 0,
    TZPlayerControlViewGestureTypeBrightness, // 亮度
    TZPlayerControlViewGestureTypeVolume,     // 音量
    TZPlayerControlViewGestureTypeProgress,   // 进度
    TZPlayerControlViewGestureTypeError, // 错误
};

@protocol VideoPlayViewDelegate;
@interface VideoPlayView : UIView

// playerLayer外面需要调用, 所以暴露出来
@property (strong, nonatomic) AVPlayerLayer *playerLayer;  /**< 显示层 */
@property (strong, nonatomic) AVPlayer *player;    /**< 播放器 */
@property(weak ,nonatomic) id<VideoPlayViewDelegate> delegate;

@property (assign, nonatomic) CGSize portraitSize; // 图像尺寸
@property (assign, nonatomic) CGSize landscapeSize; // 横屏大小
// 当前设备的方向属性
@property (assign, nonatomic) UIInterfaceOrientation lastOrientation;
@property(strong ,nonatomic) ZFPlayerControlView *controlView;

@property (assign, nonatomic) CGPoint originalLocation; // 手势位置,从哪开始的
@property (assign, nonatomic) TZPlayerControlViewGestureType gestureType; // 手势类型

- (void)loadVideoUrl:(NSString *)url ;
@end

@protocol VideoPlayViewDelegate<NSObject>

- (void)videoPlayViewDidBack:(VideoPlayView*)playView;

@end
