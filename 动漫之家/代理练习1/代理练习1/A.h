//
//  A.h
//  代理练习1
//
//  Created by 黄启明 on 2017/5/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AAProtocol <NSObject>

@required
- (void)message;
@optional

@end

@interface A : NSObject

@property(retain)id<AAProtocol>delegate;

- (void)go;

@end
