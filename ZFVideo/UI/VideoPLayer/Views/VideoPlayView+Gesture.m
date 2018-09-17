//
//  TZPlayerView+Gesture.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/21.
//  Copyright © 2018年 TZ. All rights reserved.
//

//--------------------------2.8版本-增加手势类---------------------
#import "VideoPlayView+Gesture.h"
#import "TZPlayerUtils.h"

@implementation VideoPlayView (Gesture)

- (void)setupGesture {
    // 左右的拖动用了pan这手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(panGestureAction:)];
//    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
//    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
}

// pan手势的处理
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer {
    // 主要处理音量, 进度, 亮度
    // 1.根据状态.当它是Began的时候,把位置保持下来
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalLocation = [recognizer locationInView:self];
        
        // 2.根据状态判断, 变化后.
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 取当前地址
        CGPoint currentLocation = [recognizer locationInView:self];
        // 两位置之间的偏移
        CGFloat offset_x = currentLocation.x - self.originalLocation.x;
        CGFloat offset_y = currentLocation.y - self.originalLocation.y;
        // 比较self.originalLocation和CGPointZero位置是否相同
        if (CGPointEqualToPoint(self.originalLocation,CGPointZero)) {
            self.originalLocation = currentLocation;
            return;
        }
        
        // 根据偏移,以及大小,还有tap去判断, 到底是处控制进度,还是音量或者是亮度.
        CGRect frame = self.bounds;
        @try{
            // 判断偏移值和范围值,播放进度是左右滑动
            if (ABS(offset_x) > ABS(offset_y)
                && self.originalLocation.x < frame.size.width
                && self.originalLocation.y < frame.size.height
                && ABS(offset_x) > 0
                && self.gestureType != TZPlayerControlViewGestureTypeVolume
                && self.gestureType != TZPlayerControlViewGestureTypeBrightness) {      // 滑动控制播放进度
                self.originalLocation = currentLocation;
                self.gestureType = TZPlayerControlViewGestureTypeProgress;
                [self.controlView showLoadingView:@"进度 +" animation:NO];
            } else if (ABS(offset_x) <= ABS(offset_y)
                       && self.originalLocation.x < frame.size.width
                       && self.originalLocation.y < frame.size.height
                       && ABS(offset_y) > 0
                       && self.gestureType != TZPlayerControlViewGestureTypeProgress) {      // 滑动控制音量,亮度
                self.originalLocation = currentLocation;
                 // 上下滑动,是左半屏控制亮度
                switch (self.gestureType) {
                    case TZPlayerControlViewGestureTypeNone:{
                        // 左半屏
                        if (currentLocation.x <= kScreenWidth / 2) {
                            // 控制亮度
                            self.gestureType = TZPlayerControlViewGestureTypeBrightness;
                        } else {
                            // 右半屏控制音量
                            self.gestureType = TZPlayerControlViewGestureTypeVolume;
                        }
                    }break;
                        // 上下滑动,是左半屏控制音量
                    case TZPlayerControlViewGestureTypeVolume:{
                        float volumeOffset = (offset_y/self.frame.size.height)* 1.5;
                        [TZPlayerUtils setSystemVolume:[TZPlayerUtils getSystemVolume] - volumeOffset];
                        [self.controlView showLoadingView:offset_y > 0 ? @"音量 -" : @"音量 +" animation:NO];
                    }break;
                    case TZPlayerControlViewGestureTypeBrightness:{
                        CGPoint trasnlation = [recognizer translationInView:self];
                        [TZPlayerUtils setSystemBrightness:-trasnlation.y/200];
                        [self.controlView showLoadingView:offset_y > 0 ? @"亮度 -" : @"亮度 +" animation:NO];
                    }break;
                    default:
                        break;
                }
            }
        }
        @catch(NSException *exception) {
//            TZLog(@"exception:%@", exception);
        }
        @finally {

        }
        
        // 3.根据状态判断, 结束或者取消后.
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [self.controlView hideLoadingView:nil animation:YES];
        // 滑动之后进行恢复
        self.gestureType = TZPlayerControlViewGestureTypeNone;
    }
}

// 长按之后的处理
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 手势开始默认设置2.0
        self.player.rate = 2.0;
        // 提示
        [self.controlView showLoadingView:@"快速播放" animation:YES];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        // 手势结束恢复到1.0
        self.player.rate = 1.0;
        [self.controlView hideLoadingView:@"正常播放" animation:YES];
    }
}

#pragma mark - touches
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = ((UITouch*)(touches.anyObject)).tapCount;
    // 单击之后调singleTouchAction方法
    if (tapCount == 1) {
        [self performSelector:@selector(singleTouchAction:) withObject:touch afterDelay:0.3f];
        // 双击就会切换它的播放暂停
    } else if (tapCount == 2) {
        if (self.player.rate == 1) {
            [self.player pause];
        } else if (self.player.rate == 0) {
            [self.player play];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)singleTouchAction:(UITouch *)touch {
    BOOL hide = ![self.controlView controlHidden];
    // 控制层切换它显示的一个状态
    [self.controlView setControlHidden:hide];
}

@end
//----------------------------end------------------------------

