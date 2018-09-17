//
//  MainViewController.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/10.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "MainViewController.h"

#import "ZFNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController
#pragma mark ***************** 页面名称
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initUI];
}

#pragma mark ***************** lift cycle


#pragma mark ***************** ui
- (void)_initUI{
    
    UIColor *backgroundColor = [UIColor colorWithHexString:@"0E121B"];
    UIColor *foregroundColor = [UIColor colorWithHexString:@"FCCA07"];
    
    self.tabBar.barTintColor = backgroundColor;
    self.tabBar.tintColor = foregroundColor;
    
    NSArray *controllers = @[@"HomeViewController",
                             @"DiscoveryViewController",
                             @"FllowViewController",
                             @"MyViewController"];
    NSArray* images = @[@"tabbar_home",
                       @"tabbar_discovery",
                       @"tabbar_follow",
                       @"tabbar_usercenter"];
    
    NSArray *titles = @[@"首页",@"发现",@"关注",@"我的"];

    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < controllers.count; i++) {
        Class cclass = NSClassFromString(controllers[i]);
        UIViewController *vc = [[cclass alloc] init];
        ZFNavigationController *navi = [[ZFNavigationController alloc] initWithRootViewController:vc];
        
        vc.title = navi.tabBarItem.title = titles[i];
        navi.tabBarItem.image = [UIImage imageNamed:images[i]];
        navi.navigationBar.barTintColor = backgroundColor;
        navi.navigationBar.tintColor = foregroundColor;
        [array addObject:navi];
    }
    
    self.viewControllers = array;
    
    [JKRouter router].windowRootVCStyle = RouterWindowRootVCStyleCustom;
}

#pragma mark ***************** lazy load 



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
