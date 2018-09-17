//
//  TZPlayerView.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/14.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.3版本-新增播放器的TZPlayerView--------------------
#import "VideoPlayView.h"

#import "VideoPlayView+Rotation.h"
#import "VideoPlayView+Gesture.h"

@interface VideoPlayView ()<TZPlayerControlViewDelegate>
@property (strong, nonatomic) id playerObserver;   /**< 观察者监听事件的变化 */
@property (strong, nonatomic) AVPlayerItem *playerItem;

@end

@implementation VideoPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化播放器, 但是不播
        self.player = [AVPlayer playerWithPlayerItem:nil];
        // 添加layer
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//        self.playerLayer.frame = self.bounds;
        [self.layer addSublayer:self.playerLayer];
        
        self.controlView = [ZFPlayerControlView loadFromNib];
        self.controlView.delegate = self;
        [self addSubview:self.controlView];
        
        [self setupRotation]; // 初始化屏幕旋转以及frame设置
  
        [self setupGesture]; // 分类手势的方法
    }
    return self;
}

//--------------------2.8版本-屏幕旋转分类加了通知,在播放器view中需移除--------------------
// 移除通知移除信息
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        self.playerItem = nil;
    }
    if (self.playerObserver) {
        [self.player removeTimeObserver:self.playerObserver];
        self.playerObserver = nil;
    }
}
//----------------------------end------------------------------


//----------------------2.5版本-加载视频地址--------------------
- (void)loadVideoUrl:(NSString *)url {
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
    }
    
    // 初始化
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    // kvo来监控属性playerItem的状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 先停止下操作.
    [self.player replaceCurrentItemWithPlayerItem:nil];
    // 加入到player里面, 用playerItem替换掉当前的Item
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
    
    [self.controlView showLoadingView:nil animation:NO];
//    [self.controlView setControlHidden:NO];
}
//----------------------------end------------------------------

//----------------------2.5版本-用kvo来监控属性status的状态--------------------
#pragma mark kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // kvo来监控status的状态
    if (object == self.playerItem && [keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
        // status的三个状态
        switch (status) {
                // 未知状态
            case AVPlayerItemStatusUnknown:{
                NSLog(@"AVPlayerItemStatusUnknown");
            }break;
                // 准备播放
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"AVPlayerItemStatusReadyToPlay");
                [self.player play];
                [self.controlView setPlaying:YES];
                [self.controlView hideLoadingView:nil animation:YES];
                [self observePlayback]; // 播放进度
              
                break;
                // 播放失败状态
            case AVPlayerItemStatusFailed:{
                NSLog(@"AVPlayerItemStatusFailed :%@", self.playerItem.error);

            }break;
            default:
                break;
        }
    }
}

// 获取进度,更新到进度条上面
- (void)observePlayback {
    __weak __typeof(self) wSelf = self;
    [self.player removeTimeObserver:self.playerObserver];
    self.playerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        if (CMTIME_IS_NUMERIC(wSelf.playerItem.currentTime) && CMTIME_IS_NUMERIC(wSelf.playerItem.duration)) {
            CGFloat current = wSelf.playerItem.currentTime.value/wSelf.playerItem.currentTime.timescale;
            CGFloat duration = wSelf.playerItem.duration.value/wSelf.playerItem.duration.timescale;
 
            wSelf.controlView.progressSlider.value = current;
            wSelf.controlView.progressSlider.maximumValue = duration;
            wSelf.controlView.currentTimeLabel.text = [NSString timeformatFromSeconds:current];
            wSelf.controlView.totalTimeLabel.text = [NSString timeformatFromSeconds:duration];
 
        }
    }];
}

#pragma mark ***************** TZPlayerControlViewDelegate;
- (void)controlView:(ZFPlayerControlView *)controlView event:(TZPlayerControlViewEvent)event{
    switch (event) {
        case TZPlayerControlViewEventBack:
            // 这里就可以很方便的获取当前的vc
            if(_delegate && [_delegate respondsToSelector:@selector(videoPlayViewDidBack:)]){
                [_delegate videoPlayViewDidBack:self];
            }
            break;
            
            //----------------------2.7版本-添加事件状态--------------------
        case TZPlayerControlViewEventPlay:   // 播放
            [self.player play];
            // 同步给controlView
            [self.controlView setPlaying:YES];
            break;
        case TZPlayerControlViewEventPause:  // 暂停事件
            [self.player pause];
            [self.controlView setPlaying:NO];
            break;
        case TZPlayerControlViewEventSeek: // 滚动条的事件
            [self.player seekToTime:CMTimeMake(self.controlView.progressSlider.value, 1.)];
            break;
            
        case TZPlayerControlViewEventSmallscreen: // 竖屏
            [self setOrientation:UIInterfaceOrientationPortrait animated:YES];

            break;
        case TZPlayerControlViewEventFullscreen: // 全屏
            [self setOrientation:UIInterfaceOrientationLandscapeRight animated:YES];

            break;
            //----------------------------end------------------------------
        default:
            break;
    }
}

@end

