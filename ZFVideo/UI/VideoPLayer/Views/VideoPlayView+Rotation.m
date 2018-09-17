//
//  TZPlayerView+Rotation.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/20.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.6 创建分类处理尺寸和横竖屏的----------------------
#import "VideoPlayView+Rotation.h"

@implementation VideoPlayView (Rotation)

// 初始的方法
- (void)setupRotation {
    // 视频常用屏幕尺寸是9:16的尺寸比例
    self.portraitSize = CGSizeMake(kScreenWidth, kScreenWidth*9/16);
    self.landscapeSize = CGSizeMake(kScreenHeight, kScreenWidth);
    // 手动调用屏幕旋转的方法.
    [self setOrientation:[self getDeviceCurrentOrientation] animated:NO];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotif:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

// 手动点击横竖屏,强制设备旋转
- (void)forceDeviceSetOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        [UIViewController attemptRotationToDeviceOrientation];
    }
}

// 手动切换横竖屏的方法.
- (void)setOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
   
    CGRect frame = CGRectZero;
    // 如果是竖屏就使用portraitSize
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        frame = CGRectMake(0, 0, self.portraitSize.width, self.portraitSize.height);
    } else {
        // 横屏就使用landscapeSize
        frame = CGRectMake(0, 0, self.landscapeSize.width, self.landscapeSize.height);
    }
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        // 1.主要设置frame的处理
        self.frame = frame;
        self.playerLayer.frame = self.bounds;
        self.controlView.frame = self.bounds;
        
    }];
    // 当前设备的方向
    self.lastOrientation = orientation;
    // 切换在横屏后,要进行更新
    self.controlView.fullscreen = !UIInterfaceOrientationIsPortrait(orientation);
    // 调用强制设备旋转
    [self forceDeviceSetOrientation:orientation];
}

// 获取当前的设备
- (UIInterfaceOrientation)getDeviceCurrentOrientation {
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationPortrait;
        case UIDeviceOrientationLandscapeLeft:
            return UIInterfaceOrientationLandscapeRight;
        case UIDeviceOrientationLandscapeRight:
            return UIInterfaceOrientationLandscapeLeft;
        default:
            return self.lastOrientation;
    }
}

// 屏幕变化的通知
- (void)orientationDidChangeNotif:(NSNotification *)notification {
    // 获取当前设备
    UIInterfaceOrientation orientation = [self getDeviceCurrentOrientation];
    if (orientation == self.lastOrientation) {
        return;
    }
    // 如果不一样,就进行切换
    [self setOrientation:orientation animated:YES];
}

@end
//----------------------------end------------------------------

