//
//  SpecialViewS.h
//  动漫之家
//
//  Created by 黄启明 on 2017/6/21.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <UIKit/UIKit.h>

//跳转页面代理
@protocol leadPageDelegate<NSObject>
- (void)carouselView:(NSInteger)num;
@end

@interface SpecialViewS : UIView

@property(nonatomic,strong)id<leadPageDelegate> delegate;//该协议对应的代理、

@end
