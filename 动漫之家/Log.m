//
//  Log.m
//  动漫之家
//
//  Created by 黄启明 on 2017/6/19.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "Log.h"
#import "RegisterPage.h"

@interface Log ()

@property(nonatomic, strong)RegisterPage* registerPage;

@end

@implementation Log

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];//  初始化数据
    [self addTap];//    添加手势
}

- (void)initData
{
    _registerPage = [[RegisterPage alloc]init];
    
    _userNameView.layer.masksToBounds = YES;
    _userNameView.layer.cornerRadius = 5;
    _passView.layer.masksToBounds = YES;
    _passView.layer.cornerRadius = 5;
    _joinBtn.layer.masksToBounds = YES;
    _joinBtn.layer.cornerRadius = 5;
}

- (void)addTap
{
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Action:)];
    
    [self.view addGestureRecognizer:tap1];
}

- (void)tap1Action:(UITapGestureRecognizer*)sender
{
    UITextField* textField1 = [self.view viewWithTag:10100];
    UITextField* textField2 = [self.view viewWithTag:10101];
    
    //收起键盘
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
}

- (IBAction)backAction:(UIButton *)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(UIButton *)sender
{
    NSLog(@"注册按钮被点击！");
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:_registerPage animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)qqAction:(UIButton *)sender
{
    NSLog(@"QQ按钮被点击！");
}

- (IBAction)wbAction:(UIButton *)sender
{
    NSLog(@"微博按钮被点击");
}

- (IBAction)wxAction:(UIButton *)sender
{
    NSLog(@"微信按钮被点击！");
}

- (IBAction)joinAction:(UIButton *)sender
{
    NSLog(@"进入动漫之家");
}

@end
