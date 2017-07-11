//
//  RegisterPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/5/14.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "RegisterPage.h"
#import "Masonry.h"

@interface RegisterPage ()

@property(nonatomic, strong)UIImageView* imageView;

@end

@implementation RegisterPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self setNvg];
    [self addContent];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addContent
{
    //头像的下面的一个视图
    UIView* view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    [view1.layer setMasksToBounds:YES];
    [view1.layer setCornerRadius:35];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.top.equalTo(_imageView.mas_bottom).offset(10);
    }];
    
    //头像的上面的一个视图
    UIButton* btnTouX = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTouX.backgroundColor = [UIColor colorWithRed:162.0/255.0 green:227.0/255.0 blue:255.0/255.0 alpha:1];
    [btnTouX.layer setMasksToBounds:YES];
    [btnTouX.layer setCornerRadius:30];
    [btnTouX setImage:[UIImage imageNamed:@"logoicon"] forState:UIControlStateNormal];
    [self.view addSubview:btnTouX];
    [btnTouX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(_imageView.mas_bottom).offset(15);
    }];
    
    //请输入用户名背景视图
    UIView* userNameView = [[UIView alloc]init];
    userNameView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    userNameView.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    userNameView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];//设置边框的颜色
    userNameView.layer.masksToBounds = YES;//设为NO去试试
    [self.view addSubview:userNameView];
    [userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnTouX.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.size.height.mas_equalTo(45);
    }];
    
    //用户名输入框
    UITextField* userNameTextField = [[UITextField alloc]init];
    userNameTextField.tag = 10110;
    userNameTextField.placeholder = @"请填写用户名";
    userNameTextField.borderStyle = UITextBorderStyleNone;
    [userNameView addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameView.mas_left).offset(15);
        make.right.equalTo(userNameView.mas_right).offset(-15);
        make.top.equalTo(userNameView.mas_top).offset(8);
        make.bottom.equalTo(userNameView.mas_bottom).offset(-8);
    }];
    
    //请输入邮箱背景视图
    UIView* emailView = [[UIView alloc]init];
    emailView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    emailView.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    emailView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];//设置边框的颜色
    emailView.layer.masksToBounds = YES;//设为NO去试试
    [self.view addSubview:emailView];
    [emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.size.height.mas_equalTo(45);
    }];
    
    //邮箱输入框
    UITextField* emailTextField = [[UITextField alloc]init];
    emailTextField.tag = 10111;
    emailTextField.placeholder = @"请输入邮箱@";
    emailTextField.borderStyle = UITextBorderStyleNone;
    [emailView addSubview:emailTextField];
    [emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(emailView.mas_left).offset(15);
        make.right.equalTo(emailView.mas_right).offset(-15);
        make.top.equalTo(emailView.mas_top).offset(8);
        make.bottom.equalTo(emailView.mas_bottom).offset(-8);
    }];
    
    //请输入密码背景视图
    UIView* passView = [[UIView alloc]init];
    passView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    passView.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    passView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];//设置边框的颜色
    passView.layer.masksToBounds = YES;//设为NO去试试
    [self.view addSubview:passView];
    [passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.size.height.mas_equalTo(45);
    }];
    
    //密码输入框
    UITextField* passTextField = [[UITextField alloc]init];
    passTextField.tag = 10112;
    passTextField.placeholder = @"请输入密码";
    passTextField.borderStyle = UITextBorderStyleNone;
    [passView addSubview:passTextField];
    [passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passView.mas_left).offset(15);
        make.right.equalTo(passView.mas_right).offset(-15);
        make.top.equalTo(passView.mas_top).offset(8);
        make.bottom.equalTo(passView.mas_bottom).offset(-8);
    }];
    
    //请输入确定密码背景视图
    UIView* againPassView = [[UIView alloc]init];
    againPassView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    againPassView.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
    againPassView.layer.borderColor = [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] CGColor];//设置边框的颜色
    againPassView.layer.masksToBounds = YES;//设为NO去试试
    [self.view addSubview:againPassView];
    [againPassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.size.height.mas_equalTo(45);
    }];
    
    //确定密码输入框
    UITextField* againPassTextField = [[UITextField alloc]init];
    againPassTextField.tag = 10113;
    againPassTextField.placeholder = @"确定密码";
    againPassTextField.borderStyle = UITextBorderStyleNone;
    [againPassView addSubview:againPassTextField];
    [againPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(againPassView.mas_left).offset(15);
        make.right.equalTo(againPassView.mas_right).offset(-15);
        make.top.equalTo(againPassView.mas_top).offset(8);
        make.bottom.equalTo(againPassView.mas_bottom).offset(-8);
    }];
    
    //绑定手势，这里用于收起键盘
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    //加入动漫之家按钮
    UIButton* joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    joinBtn.layer.masksToBounds = YES;
    joinBtn.layer.cornerRadius = 5;
    [joinBtn setTitle:@"加入动漫之家" forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinBtn];
    [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.offset(10);
        make.right.width.offset(-10);
        make.top.equalTo(againPassView.mas_bottom).offset(40);
        make.height.equalTo(@45);
    }];
}

//tap手势回调方法
- (void)tapAction:(UITapGestureRecognizer* )sender
{
    UITextField* textField1 = [self.view viewWithTag:10110];
    UITextField* textField2 = [self.view viewWithTag:10111];
    UITextField* textField3 = [self.view viewWithTag:10112];
    UITextField* textField4 = [self.view viewWithTag:10113];
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];
    [textField4 resignFirstResponder];
}

- (void)joinAction:(UIButton* )sender
{
    NSLog(@"加入动漫之家");
}

//创建自定义导航栏视图
- (void)setNvg
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
    titleLabel.text = @"邮箱注册";
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(60);
        make.right.equalTo(view.mas_right).offset(-60);
        make.top.equalTo(view.mas_top).offset(4);
        make.bottom.equalTo(view.mas_bottom).offset(-4);
    }];
    
    //导航栏下面的分隔图片
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NavigationBarBottomLine"]];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(view.mas_bottom).offset(0);
        make.height.equalTo(@4);
    }];
    
}

//导航栏上面的返回按钮回调方法
- (void)btnAction:(UIButton* )sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
