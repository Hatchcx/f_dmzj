//
//  RecommendWeb.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

//type == 7

#import "RecommendWeb.h"
#import "Dfine.h"

@interface RecommendWeb ()

@property(nonatomic, strong)UIWebView* webView;

@end

@implementation RecommendWeb

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"新闻正文";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [viewTitle addSubview:labelTitle];
    
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [viewTitle addSubview:navigationBarBottomLineImage];
    
    UIButton* navigationBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationBack.frame = CGRectMake(2, 10, 24, 20);
    [navigationBack setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [navigationBack addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:navigationBack];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67-44)];
    _webView.scrollView.bounces = NO;//取消下拉拖动效果
    NSURL* url=[NSURL URLWithString:_strUrl];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, height1-44, width1, 44)];
    [self.view addSubview:view];
    
    UIImageView* commentBigDividerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width1, 1)];
    commentBigDividerImage.image = [UIImage imageNamed:@"commentBigDivider"];
    [view addSubview:commentBigDividerImage];
    
    UIImageView* commentDividerImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/3-0.5, 12, 1, 20)];
    commentDividerImage1.image = [UIImage imageNamed:@"commentDivider"];
    [view addSubview:commentDividerImage1];
    
    UIImageView* commentDividerImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/3*2+0.5, 12, 1, 20)];
    commentDividerImage2.image = [UIImage imageNamed:@"commentDivider"];
    [view addSubview:commentDividerImage2];
    
    UIButton* iconPriseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconPriseBtn.frame= CGRectMake(width1/3/2-20, 8, 40, 25);
    [iconPriseBtn setImage:[UIImage imageNamed:@"icon_prise"] forState:UIControlStateNormal];
    [iconPriseBtn setTitle:@"赞" forState:UIControlStateNormal];
    [iconPriseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    iconPriseBtn.titleLabel.font    = [UIFont systemFontOfSize: 13];
    [iconPriseBtn addTarget:self action:@selector(iconPriseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:iconPriseBtn];
    
    UIButton* shareIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareIconBtn.frame= CGRectMake(width1/2-25, 8, 50, 25);
    [shareIconBtn setImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
    [shareIconBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareIconBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareIconBtn.titleLabel.font    = [UIFont systemFontOfSize: 13];
    [shareIconBtn addTarget:self action:@selector(shareIconBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shareIconBtn];
    
    UIButton* releaseCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseCommentBtn.frame= CGRectMake(width1-(width1/3/2-25)-50, 8, 50, 25);
    [releaseCommentBtn setImage:[UIImage imageNamed:@"releaseComment"] forState:UIControlStateNormal];
    [releaseCommentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [releaseCommentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    releaseCommentBtn.titleLabel.font    = [UIFont systemFontOfSize: 13];
    [releaseCommentBtn addTarget:self action:@selector(releaseCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:releaseCommentBtn];
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)iconPriseBtn:(UIButton* )sender
{
    NSLog(@"点赞按钮别点击！");
}

- (void)shareIconBtn:(UIButton* )sender
{
    NSLog(@"分享按钮别点击！");
}

- (void)releaseCommentBtn:(UIButton* )sender
{
    NSLog(@"评论按钮别点击！");
}

@end
