//
//  DownloadViewController.m
//  动漫之家
//
//  Created by 黄启明 on 2017/6/23.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "DownloadViewController.h"
#import "Dfine.h"
#import "Masonry.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initNvg];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initContent
{
    
}

- (void)initNvg
{
    //设置电池栏的背景颜色
    UIView* batteryView = [[UIView alloc]init];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    [batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.offset(0);
        make.right.width.offset(0);
        make.top.width.offset(0);
        make.size.height.mas_equalTo(20);
    }];
    
    //导航栏的背景视图
    UIView* view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.width.offset(20);
        //make.top.equalTo(self.view.mas_top).with.offset(20);
    }];
    
    //导航栏上面的返回按钮
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(18, 34));
        make.left.equalTo(view.mas_left).offset(10);
        make.top.equalTo(view.mas_top).offset(5);
        //        make.width.equalTo(@18);
        //        make.height.equalTo(@34);
    }];
    
    //导航栏上面中间的标题
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的下载";
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.offset(60);
        make.right.width.offset(-60);
        make.top.width.offset(4);
        make.bottom.width.offset(-4);
        //make.edges.mas_equalTo(UIEdgeInsetsMake(4, 60, 4, 60));
    }];
    
    //导航栏上面的管理按钮
    UIButton* administrationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [administrationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    administrationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [administrationBtn setTitle:@"管理" forState:UIControlStateNormal];
    [administrationBtn addTarget:self action:@selector(administrationAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:administrationBtn];
    [administrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.right.width.offset(-10);
        make.top.width.offset(15);
        make.bottom.width.offset(-15);
    }];
    
    //导航栏下面的分隔图片
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NavigationBarBottomLine"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(view.mas_bottom).offset(0);
        make.height.equalTo(@4);
    }];
    
}

- (void)administrationAction:(UIButton* )sender
{
    NSLog(@"管理按钮被点击！");
}

- (void)btnAction:(UIButton* )sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
