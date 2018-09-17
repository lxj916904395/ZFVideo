//
//  TZPlayerUtils.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/21.
//  Copyright © 2018年 TZ. All rights reserved.
//

//--------------------------2.8版本-增加音量,亮度类---------------------
#import "TZPlayerUtils.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAudioSession.h>

static NSString *kSystemVolumeChangeKey = @"AVSystemController_SystemVolumeDidChangeNotification";

@interface TZPlayerUtils () {
    MPVolumeView    *_volumeView;   // 音量view
    UISlider        *_volumeSlider; // 音量滑块
}
@end

@implementation TZPlayerUtils
+ (instancetype)sharedUtils {
    static dispatch_once_t onceToken;
    static id _sharedUtils = nil;
    dispatch_once(&onceToken, ^{
        _sharedUtils = [[TZPlayerUtils alloc] init];
    });
    return _sharedUtils;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 配置系统音量
        [self  configureSystemVolume];
    }
    return self;
}

- (void)configureSystemVolume {
    // 设置音量需要用MPVolumeView
    _volumeView = [[MPVolumeView alloc]init];
    _volumeView.showsRouteButton = NO;
    _volumeView.showsVolumeSlider = NO;
    for (UIView *view in [_volumeView subviews]){
        if ([[view.class description] isEqualToString:@"MPVolumeSlider"]){
            _volumeSlider = (UISlider*)view;
            break;
        }
    }
    
    _volume = [[AVAudioSession sharedInstance] outputVolume];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                 name:kSystemVolumeChangeKey
                                               object:nil];
}

// 音量属性set方法
- (void)setVolume:(float)volume{
    _volumeSlider.value = volume;
    _volume = _volumeSlider.value;
}

-(void)volumeChanged:(NSNotification *)notification {
    float volumeValue = [[[notification userInfo] objectForKey:kSystemVolumeChangeKey] floatValue];
    _volume = volumeValue;
}
// 音量设置
+ (float)getSystemVolume {
    return [TZPlayerUtils sharedUtils].volume;
}
// 音量设置
+ (void)setSystemVolume:(float)volume {
    [TZPlayerUtils sharedUtils].volume = volume;
}

// 亮度设置,直接设置系统的 brightness就行了
+ (void)setSystemBrightness:(CGFloat)brightness {
    float new = UIScreen.mainScreen.brightness + brightness;
    if (new < 0.0001f) {
        new = 0.f;
    }else{
        new = new > 1.f ? 1.f : new;
    }
    UIScreen.mainScreen.brightness = new;
}
@end
//----------------------------end------------------------------

