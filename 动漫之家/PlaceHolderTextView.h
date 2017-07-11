//
//  PlaceHolderTextView.h
//  动漫之家
//
//  Created by 黄启明 on 2017/6/23.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView

@property (copy, nonatomic, nullable) IBInspectable NSString *xx_placeholder;

@property (strong, nonatomic, nullable) IBInspectable UIColor *xx_placeholderColor;

@property (strong, nonatomic, nullable) UIFont *xx_placeholderFont;

@end
