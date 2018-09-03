//
//  BusinessLayer.m
//  BusinessLayer
//
//  Created by lxj on 2018/9/3.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "BusinessLayer.h"

#import "UtilLayer/UtilLayer.h"
#import "NetworkLayer/NetworkLayer.h"
#import "DataLayer/DataLayer.h"

#import "UIImageView+WebCache.h"

@implementation BusinessLayer

+ (void)business{
    NSLog(@"业务");
    
    [UtilLayer md5:@"lxj"];
    [DataLayer data];
    [NetworkLayer net];
    
    UIImageView *imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"lxj"]];
}

@end
