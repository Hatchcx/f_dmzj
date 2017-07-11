//
//  FeedbackPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/26.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "FeedbackPage.h"
#import "Dfine.h"
#import "Masonry.h"
#import "PlaceHolderTextView.h"

@interface FeedbackPage ()

@end

@implementation FeedbackPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigation];
    [self initContentView];
    [self addTap];
}

- (void)addTap
{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer* )sender
{
    UITextView* textView = [self.view viewWithTag:10200];
    UITextField* textField = [self.view viewWithTag:10201];
    [textView resignFirstResponder];
    [textField resignFirstResponder];
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"意见反馈";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [viewTitle addSubview:labelTitle];
    
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [viewTitle addSubview:navigationBarBottomLineImage];
    
    UIButton* sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(width1-10-40, 10, 40, 24);
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [viewTitle addSubview:sendBtn];
    
    UIButton* navigationBack = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationBack.frame = CGRectMake(2, 10, 24, 20);
    [navigationBack setImage:[UIImage imageNamed:@"NavigationBack"] forState:UIControlStateNormal];
    [navigationBack addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:navigationBack];
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initContentView
{
    //背景视图
    UIView* viewBJ = [[UIView alloc]init];
    viewBJ.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.view addSubview:viewBJ];
    [viewBJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(67, 0, 0, 0));
    }];
    
    //意见textView背景视图
    UIView* textViewBj = [[UIView alloc]init];
    textViewBj.layer.masksToBounds = YES;
    textViewBj.layer.cornerRadius = 3;
    textViewBj.layer.borderWidth = 1;
    textViewBj.backgroundColor = [UIColor whiteColor];
    [viewBJ addSubview:textViewBj];
    [textViewBj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.offset(15);
        make.right.width.offset(-15);
        make.top.width.offset(10);
        make.height.mas_equalTo(100);
    }];
    
    //留下意见
    PlaceHolderTextView* opinionTextView = [[PlaceHolderTextView alloc]init];
    opinionTextView.xx_placeholder = @"请在此留下您的宝贵意见，谢谢!";
    opinionTextView.tag = 10200;
    [textViewBj addSubview:opinionTextView];
    [opinionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    //qq号背景
    UIView* qqViewBj = [[UIView alloc]init];
    qqViewBj.layer.masksToBounds = YES;
    qqViewBj.layer.cornerRadius = 3;
    qqViewBj.layer.borderWidth = 1;
    qqViewBj.backgroundColor = [UIColor whiteColor];
    [viewBJ addSubview:qqViewBj];
    [qqViewBj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.offset(15);
        make.right.width.offset(-15);
        make.top.equalTo(textViewBj.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    //qqtextfield
    UITextField* qqtextField = [[UITextField alloc]init];
    qqtextField.tag = 10201;
    qqtextField.placeholder = @"请输入QQ号码,以便我们联系您";
    [qqViewBj addSubview:qqtextField];
    [qqtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
}

@end
