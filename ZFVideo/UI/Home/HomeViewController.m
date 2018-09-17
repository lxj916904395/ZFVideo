//
//  HomeViewController.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/10.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeTableViewProxy.h"


@interface HomeViewController ()
@property(strong ,nonatomic) HomeTableViewProxy *proxy;

@end

@implementation HomeViewController
#pragma mark ***************** 页面名称
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initUI];
}

#pragma mark ***************** lift cycle
- (void)viewWillAppear:(BOOL)animated {
    // 导航栏隐藏.返回按钮,自定义添加到播放器上面.
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

#pragma mark ***************** ui
- (void)_initUI{
    [self.contentView addSubview:self.proxy.tableView];
    [self.proxy.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark ***************** lazy load

- (HomeTableViewProxy*)proxy{
    if (!_proxy) {
        _proxy = [[HomeTableViewProxy alloc] initWithIdentifier:NSStringFromClass(UITableViewCell.class) config:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            
        } action:^(UITableViewCell *cell, id cellData, NSIndexPath *indexPath) {
            [JKRouter open:@"VideoPlayerController"];
        }];
    }
    return _proxy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 

@end
