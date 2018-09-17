//
//  TZPlayerView+Rotation.h
//  TZVideoDemo
//
//  Created by Dream on 2018/8/20.
//  Copyright © 2018年 TZ. All rights reserved.
//

//----------------------2.6 创建分类处理尺寸和横竖屏的----------------------
#import "VideoPlayView.h"

@interface VideoPlayView (Rotation)
// 初始的方法
- (void)setupRotation;
// 手动切换横竖屏的方法
- (void)setOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;
@end
//----------------------------end------------------------------

