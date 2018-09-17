//
//  VideoPlayerProxy.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/14.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "VideoPlayerProxy.h"

@implementation VideoPlayerProxy

- (VideoPlayView*)playView{
    if (!_playView) {
        _playView = [[VideoPlayView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*(9/16.0))];
    }
    return _playView;
}

@end
