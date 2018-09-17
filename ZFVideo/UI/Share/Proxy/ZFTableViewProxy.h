//
//  ZFTableViewProxy.h
//  ZFVideo
//
//  Created by zhongding on 2018/9/14.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZFCellConfigBlock)(UITableViewCell *cell, id cellData, NSIndexPath *indexPath);
typedef void(^ZFCellActionBlock)(UITableViewCell *cell, id cellData, NSIndexPath *indexPath);

@interface ZFTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>


@property(strong ,nonatomic) UITableView *tableView;

@property(copy ,nonatomic) ZFCellConfigBlock cellConfigBlock;
@property(copy ,nonatomic) ZFCellActionBlock cellActionBlock;

@property(strong ,nonatomic) NSString *identifier;

@property(strong ,nonatomic) NSMutableArray *dataArray;

- (instancetype)initWithIdentifier:(NSString*)identifier config:(ZFCellActionBlock)cellConfig action:(ZFCellActionBlock)cellAction;



@end
