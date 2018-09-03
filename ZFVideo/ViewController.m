//
//  ViewController.m
//  ZFVideo
//
//  Created by lxj on 2018/9/3.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "ViewController.h"

#import "BusinessLayer.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BusinessLayer business];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
