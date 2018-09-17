//
//  TZPlayerViewController.m
//  TZVideoDemo
//
//  Created by Dream on 2018/8/14.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.3版本-新增播放器控制器--------------------
#import "VideoPlayerController.h"
#import "VideoPlayerProxy.h"

@interface VideoPlayerController ()<VideoPlayViewDelegate>

@property (strong, nonatomic) VideoPlayerProxy *playerViewProxy;

@end

@implementation VideoPlayerController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 暂时通过手势来进行页面返回.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    // 把playerView添加到contentView
    [self.contentView addSubview:self.playerViewProxy.playView];

  
    //----------------------2.5版本-新增播放地址--------------------
    self.playerViewProxy.playView.delegate = self;
    [self.playerViewProxy.playView loadVideoUrl:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"];
    //----------------------------end------------------------------
}

#pragma mark ***************** VideoPlayViewDelegate;
- (void)videoPlayViewDidBack:(VideoPlayView*)playView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    // 导航栏隐藏.返回按钮,自定义添加到播放器上面.
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}



#pragma mark - 懒加载
- (VideoPlayerProxy *)playerViewProxy {
    if (!_playerViewProxy) {
        _playerViewProxy = [VideoPlayerProxy new];
    }
    return _playerViewProxy;
}

@end
//----------------------------end------------------------------

