//
//  HomeTableViewProxy.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/14.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "HomeTableViewProxy.h"

@implementation HomeTableViewProxy
- (instancetype)initWithIdentifier:(NSString *)identifier config:(ZFCellActionBlock)cellConfig action:(ZFCellActionBlock)cellAction{
    if (self = [super initWithIdentifier:identifier config:cellConfig action:cellAction]) {
        
        [self.dataArray addObject:@"first"];
        [self.tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
    return self;
}


@end
