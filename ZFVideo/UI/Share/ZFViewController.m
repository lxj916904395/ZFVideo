//
//  TZBaseViewController.m
//  TZVideoDemo
//
//  Created by Dream on 2018/7/4.
//  Copyright © 2018年 TZ. All rights reserved.
//

#import "ZFViewController.h"

@interface ZFViewController ()

@end

@implementation ZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //----------------------1.6 iOS11的安全区域配置----------------------
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        // @available(iOS 11.0, *)  @available系统提供的写法, 指定系统版本.
        if (@available(iOS 11.0, *)) {
            // iOS11 安全区域的布局
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            // 首尾的约束
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuide);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }
    }];
    //----------------------------end------------------------------
}

//----------------------1.6懒加载----------------------
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}
//----------------------------end------------------------------

@end
