//
//  TZPlayerControlView.h
//  TZVideoDemo
//
//  Created by Dream on 2018/8/15.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.4版本-新增类,设置控件的类--------------------
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TZPlayerControlViewEvent) {
    TZPlayerControlViewEventBack,               // 返回
    TZPlayerControlViewEventFullscreen,         // 全屏
    TZPlayerControlViewEventSmallscreen,        // 竖屏
    TZPlayerControlViewEventPlay,               // 播放
    TZPlayerControlViewEventPause,              // 暂停
    TZPlayerControlViewEventNext,               // 下一集
    TZPlayerControlViewEventSeek,               // 拖动进度
    TZPlayerControlViewEventDefinition,         // 切换清晰度
    TZPlayerControlViewEventShare,              // 分享
    TZPlayerControlViewEventCast,               // 投屏
    TZPlayerControlViewEventSpeedup,            // 加速播放
    TZPlayerControlViewEventSpeedDown,          // 停止加速播放
};

// 定义协议来传递控制器和事件
@class ZFPlayerControlView;
@protocol TZPlayerControlViewDelegate <NSObject>
- (void)controlView:(ZFPlayerControlView *)controlView event:(TZPlayerControlViewEvent)event;
@end

@interface ZFPlayerControlView : UIView

@property (weak, nonatomic) id<TZPlayerControlViewDelegate> delegate;
//----------------------2.6版本-添加属性---------------------
@property (assign, nonatomic) BOOL fullscreen;  // 满屏
@property (assign, nonatomic) BOOL playing;     // 正在播放
@property (assign, nonatomic) BOOL controlHidden; // 控制隐藏
//----------------------------end------------------------------


@property (weak, nonatomic) IBOutlet UIView *loadingView;    /**< 播放视频前加载的view */
@property (weak, nonatomic) IBOutlet UIView *navView;        /**< 自定义导航栏 */
@property (weak, nonatomic) IBOutlet UIView *controlView;    /**< 视频控制栏 */

@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;   /**< 播放视频前显示的label */

@property (weak, nonatomic) IBOutlet UIButton *backButton;      /**< 返回按钮 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;       /**< 返回按钮名字 */

@property (weak, nonatomic) IBOutlet UIButton *playButton;      /**< 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *nextButton;      /**< 下一曲按钮 */
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel; /**< 显示播放时间*/
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;  /**< 进度条 */
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;   /**< 播放总时间 */
@property (weak, nonatomic) IBOutlet UIButton *definitionButton;/**< 视频精度提示按钮 */
@property (weak, nonatomic) IBOutlet UIButton *fullscreenButton;/**< 全屏*/

// 提供改外界初始化的类方法
+ (instancetype)loadFromNib;

//----------------------2.6版本-动态的显示,隐藏某些元素方法---------------------
// 动态的显示或者隐藏某些元素
- (void)showLoadingView:(NSString *)tips animation:(BOOL)anime;
- (void)hideLoadingView:(NSString *)tips animation:(BOOL)anime;
//----------------------------end------------------------------

@end
//----------------------------end------------------------------

