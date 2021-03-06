//
//  TypeThreeWeb.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/29.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "TypeThreeWeb.h"
#import "Dfine.h"

@interface TypeThreeWeb ()

@property(nonatomic, strong)UILabel* labelTitle;
@property(nonatomic, strong)UIWebView* webView;

@end

@implementation TypeThreeWeb

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(width1/9, 10, width1-width1/9*2, 24)];
    _labelTitle.text = _labelTitleStr;
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    [viewTitle addSubview:_labelTitle];
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [viewTitle addSubview:navigationBarBottomLineImage];
    
    UIButton* navigationBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationBack.frame = CGRectMake(2, 10, 24, 20);
    [navigationBack setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [navigationBack addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:navigationBack];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67)];
    _webView.scrollView.bounces = NO;//取消下拉拖动效果
    NSURL* url=[NSURL URLWithString:_strUrl];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
