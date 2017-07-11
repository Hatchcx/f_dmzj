//
//  ViewController.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/6.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ViewController.h"
#import "Dfine.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@interface ViewController ()

@property(nonatomic, strong)UIScrollView* scrollViewBg;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollViewBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width1, height1)];
    
    for(int i=1; i<4; i++)
    {
        //背景图片
        UIImageView* appintroBg = [[UIImageView alloc]initWithFrame:CGRectMake(0+(i-1)*width1, 0, width1, height1)];
        appintroBg.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_bg%d",i]];
        //云图片
        UIImageView* appintroCloudBig = [[UIImageView alloc]initWithFrame:CGRectMake(0+(i-1)*width1, height1-height1/5.2, width1, height1/5.2)];
        appintroCloudBig.image = [UIImage imageNamed:@"appintro_cloudBig"];
        //页面图片
        UIImageView* appintroPage = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-43)+(i-1)*width1, (height1-height1/5.2/2+7), 86, 14)];
        appintroPage.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_page%d",i]];
        
        [_scrollViewBg addSubview:appintroBg];
        
        [_scrollViewBg addSubview:appintroCloudBig];
        
        [_scrollViewBg addSubview:appintroPage];
        
        //内容图片和标题图片
        if (i == 1) {
            UIImageView* appintroContent = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-124)+(i-1)*width1, 64+57, 497/2, 622/2)];
            appintroContent.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_content%d",i]];
            [_scrollViewBg addSubview:appintroContent];
            
            UIImageView* appintroTitle = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-71.7)+(i-1)*width1, 64, 287/2, 109/2)];
            appintroTitle.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_title%d",i]];
            [_scrollViewBg addSubview:appintroTitle];
        }else if(i == 2)
        {
            UIImageView* appintroContent = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-156)+(i-1)*width1, 64+57, 624/2, 593/2)];
            appintroContent.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_content%d",i]];
            [_scrollViewBg addSubview:appintroContent];
            
            UIImageView* appintroTitle = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-118.7)+(i-1)*width1, 64, 475/2, 109/2)];
            appintroTitle.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_title%d",i]];
            [_scrollViewBg addSubview:appintroTitle];
        }else if(i == 3)
        {
            UIImageView* appintroContent = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-125)+(i-1)*width1, 64+57, 503/2, 590/2)];
            appintroContent.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_content%d",i]];
            [_scrollViewBg addSubview:appintroContent];
            
            UIImageView* appintroTitle = [[UIImageView alloc]initWithFrame:CGRectMake((width1/2-88.7)+(i-1)*width1, 64, 355/2, 111/2)];
            appintroTitle.image = [UIImage imageNamed:[NSString stringWithFormat:@"appintro_title%d",i]];
            [_scrollViewBg addSubview:appintroTitle];
            
            UIButton* enter = [UIButton buttonWithType:UIButtonTypeCustom];
            enter.frame = CGRectMake((width1/2-64.25)+(i-1)*width1, height1-height1/5.2-34, 257/2, 74/2);
            [enter setBackgroundImage:[UIImage imageNamed:@"appintro_start"] forState:UIControlStateNormal];
            [enter setBackgroundImage:[UIImage imageNamed:@"appintro_startH"] forState:UIControlStateHighlighted];
            [enter addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollViewBg addSubview:enter];
        }
    }
    ////设置滚动范围，滚动范围和内容视图大小一样
    _scrollViewBg.contentSize=CGSizeMake(width1*3, 0);
    //取消反弹效果
    _scrollViewBg.bounces=NO;
    //隐藏水平方向的滑块
    _scrollViewBg.showsHorizontalScrollIndicator=NO;
    //翻页效果
    _scrollViewBg.pagingEnabled=YES;
    
    [self.view addSubview:_scrollViewBg];
}

- (void)btnAction:(UIButton*)sender
{
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* delegate=(AppDelegate*)app.delegate;
    delegate.window.rootViewController=nil;
    RootViewController* home=[[RootViewController alloc]init];
    delegate.window.rootViewController =home;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
