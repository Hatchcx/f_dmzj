//
//  PageInfo.h
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageInfo : NSObject

@property(nonatomic, strong) NSString    *ID;
@property(nonatomic, strong) NSString    *name;
@property(nonatomic, strong) NSString    *image;
@property(nonatomic, strong) NSString    *selectImage;
@property(nonatomic, assign) BOOL        unLoad;

+ (instancetype)infoFromDict:(NSDictionary *)dict;
+ (NSArray *)pageControllers;

@end
