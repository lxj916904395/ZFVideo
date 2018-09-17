//
//  ZFNavigationController.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/10.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "ZFNavigationController.h"

@interface ZFNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ZFNavigationController
#pragma mark ***************** 页面名称
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initUI];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.delegate = self;
}

#pragma mark ***************** lift cycle


#pragma mark ***************** ui
- (void)_initUI{
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor whiteColor]
                                               };
}


#pragma mark ***************** UINavigationControllerDelegate;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //跳转过程中，不想要侧滑手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //隐藏tabbar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
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
