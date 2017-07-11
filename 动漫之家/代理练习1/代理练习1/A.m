//
//  A.m
//  代理练习1
//
//  Created by 黄启明 on 2017/5/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "A.h"

@implementation A

- (void)go
{
    [_delegate message];
}

@end
