//
//  TypeTwoWeb.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/28.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "TypeTwoWeb.h"
#import "Dfine.h"
#import "WQLPaoMaView.h"

@interface TypeTwoWeb ()

@property(nonatomic, strong)UILabel* labelTitle;
@property(nonatomic, strong)UIWebView* webView;
@property(nonatomic, strong)WQLPaoMaView* paoMaView;

@end

@implementation TypeTwoWeb

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
//    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(width1/9, 10, width1-width1/9*2, 24)];
//    _labelTitle.text = _labelTitleStr;
//    _labelTitle.textAlignment = NSTextAlignmentCenter;
//    [viewTitle addSubview:_labelTitle];
    _paoMaView = [[WQLPaoMaView alloc]initWithFrame:CGRectMake(width1/6, 10, width1-width1/6*2, 24) withTitle:_labelTitleStr];
    [viewTitle addSubview:_paoMaView];
    
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [viewTitle addSubview:navigationBarBottomLineImage];
    
    UIButton* navigationBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationBack.frame = CGRectMake(2, 10, 24, 20);
    [navigationBack setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [navigationBack addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:navigationBack];
    
    
    UIButton* shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(width1-8-35, 7, 35, 35);
    [shareBtn setImage:[UIImage imageNamed:@"ADShareIconH"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:shareBtn];
    
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

- (void)downloadAction:(UIButton* )sender
{
    NSLog(@"分享按钮被点击!");
}

@end
