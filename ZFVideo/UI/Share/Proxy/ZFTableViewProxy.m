//
//  ZFTableViewProxy.m
//  ZFVideo
//
//  Created by zhongding on 2018/9/14.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "ZFTableViewProxy.h"

@implementation ZFTableViewProxy

- (instancetype)initWithIdentifier:(NSString*)identifier config:(ZFCellActionBlock)cellConfig action:(ZFCellActionBlock)cellAction{
    if (self = [super init]) {
        
        _identifier = identifier;
        _cellConfigBlock = cellConfig;
        _cellActionBlock = cellAction;
    }
    return self;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    
    if (_cellConfigBlock) {
        _cellConfigBlock(cell,self.dataArray[indexPath.row],indexPath);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_cellActionBlock) {
        _cellActionBlock([tableView cellForRowAtIndexPath:indexPath],self.dataArray[indexPath.row],indexPath);

    }
}


@end
