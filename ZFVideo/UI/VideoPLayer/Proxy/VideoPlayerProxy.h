//
//  VideoPlayerProxy.h
//  ZFVideo
//
//  Created by zhongding on 2018/9/14.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "ZFTableViewProxy.h"

#import "VideoPlayView.h"

@interface VideoPlayerProxy : ZFTableViewProxy
@property(strong ,nonatomic) VideoPlayView *playView;

@end
