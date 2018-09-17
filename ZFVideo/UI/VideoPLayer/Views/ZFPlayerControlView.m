//
//  TZPlayerControlView.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/15.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.4版本-新增类,设置控件的类--------------------
#import "ZFPlayerControlView.h"

static NSInteger kTZPlayerControlViewButtonTagOffset = 1027; // 编译量,数值随意
@interface ZFPlayerControlView ()

@end

@implementation ZFPlayerControlView

+ (instancetype)loadFromNib {
    // 加载xib,遍历出里面的view
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id view in views) {
        if (view && [view isKindOfClass:[self class]]) {
            return view;
        }
    }
    return nil;
}

//  加载xib初始化的时候,会走awakeFromNib
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.width = kScreenWidth;
    self.height = kScreenWidth*(9/16.0);
    
    // 设置tag,在设置的偏移量中加上对应事件的宏. 比直接在btn中设置tag更方便直观
    _backButton.tag = kTZPlayerControlViewButtonTagOffset + TZPlayerControlViewEventBack;
    _playButton.tag = kTZPlayerControlViewButtonTagOffset + TZPlayerControlViewEventPlay;
    _nextButton.tag = kTZPlayerControlViewButtonTagOffset + TZPlayerControlViewEventNext;
    _progressSlider.tag = kTZPlayerControlViewButtonTagOffset + TZPlayerControlViewEventSeek;
    _fullscreenButton.tag = kTZPlayerControlViewButtonTagOffset + TZPlayerControlViewEventFullscreen;
    
    //----------------------2.7版本-添加进度条图---------------------
    _titleLabel.hidden = YES; // 它只在横屏上显示
    // 添加进度条图
    [_progressSlider setThumbImage:[UIImage imageNamed:@"qymovie_play_progressBar"] forState:UIControlStateNormal];
    //----------------------------end------------------------------

    //----------------------2.8版本-播放几秒后,按钮进度条等自动隐藏---------------------
    // 过0.3秒之后,隐藏. 默认是隐藏的
    [self setControlHidden:YES];
    //----------------------------end------------------------------
}

//----------------------2.6版本-改set方法---------------------
// 重写全屏属性set方法
- (void)setFullscreen:(BOOL)fullscreen {
    _fullscreen = fullscreen;
    _titleLabel.hidden = !fullscreen;
//    _definitionButton.hidden = !fullscreen;
}

// 重写播放的set方法
- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    [_playButton setImage:[UIImage imageNamed:playing ? @"qymovie_play_pause" : @"qymovie_play_play"] forState:UIControlStateNormal];
}

// 隐藏和显示
- (void)setControlHidden:(BOOL)controlHidden {
    // 取消注册的 performSelector方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlDelay) object:nil];
    // 这段里面有延时操作,几秒后,状态自己隐掉
    _controlHidden = controlHidden;
    CGFloat alpha = controlHidden ? 0 : 1;
    [UIView animateWithDuration:0.3 animations:^{
        //        _loadingView.alpha = !controlHidden;
        _navView.alpha = alpha;
        _controlView.alpha = alpha;
    } completion:^(BOOL finished) {
        //        _loadingView.hidden = controlHidden;
        _navView.hidden = controlHidden;
        _controlView.hidden = controlHidden;
    }];

    if (controlHidden == NO) {
        [self performSelector:@selector(hideControlDelay) withObject:nil afterDelay:5.];
    }
}

// 隐藏延迟
- (void)hideControlDelay {
    // 延时操作,几秒后自己动态隐藏
//    [self setControlHidden:YES];
}

// LoadingView的展示
- (void)showLoadingView:(NSString *)tips animation:(BOOL)anime {
    if (tips) {
        _videoNameLabel.text = tips;
    }
    if (anime) {
        _loadingView.alpha = 0;
        _loadingView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _loadingView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        _loadingView.alpha = 1;
        _loadingView.hidden = NO;
    }
}

// LoadingView的隐藏
- (void)hideLoadingView:(NSString *)tips animation:(BOOL)anime {
    if (tips) {
        _videoNameLabel.text = tips;
    }
    if (anime) {
        [UIView animateWithDuration:0.5 delay:1. options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _loadingView.alpha = 0;
        } completion:^(BOOL finished) {
            _loadingView.hidden = YES;
            _loadingView.alpha = 1;
        }];
    } else {
        _loadingView.hidden = YES;
        _loadingView.alpha = 1;
    }
}
//----------------------------end------------------------------

#pragma mark - action
// 点击事件中,可以很方便就拿到了对应的tag
- (IBAction)buttonAction:(UIControl *)sender {
    TZPlayerControlViewEvent event = sender.tag - kTZPlayerControlViewButtonTagOffset;
    
    //----------------------2.7版本-横竖屏状态的判断,调整在全屏状态切竖屏不起作用的小问题---------------------
    // 全屏状态下,如果是竖屏或是返回事件
    if (_fullscreen && (event == TZPlayerControlViewEventFullscreen || event == TZPlayerControlViewEventBack)) {
        // 竖屏
        event = TZPlayerControlViewEventSmallscreen;
        // 播放暂停键
    } else if (_playing && event == TZPlayerControlViewEventPlay) {
        event = TZPlayerControlViewEventPause;
    }
    //----------------------------end------------------------------

    if (_delegate && [_delegate respondsToSelector:@selector(controlView:event:)]) {
        // 控制器和事件传递出去.
        [_delegate controlView:self event:event];
    }
}
@end
//----------------------------end------------------------------
