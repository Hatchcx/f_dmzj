//
//  MyPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/9.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "MyPage.h"
#import "Dfine.h"
#import "Masonry.h"
#import "SetPage.h"
#import "Log.h"
#import "BrowseLogViewController.h"
#import "DownloadViewController.h"

@interface MyPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIView* myPage;
@property(nonatomic, strong)UIButton* u5Normal2Btn;
@property(nonatomic, strong)UIButton* u5Normal1Btn;

@property(nonatomic, strong)UIView* view1;

@property(nonatomic, strong)UIView* view21;
@property(nonatomic, strong)UITableView* tableView21;
@property(nonatomic, strong)NSMutableArray* dataSource21;
@property(nonatomic, strong)NSMutableArray* imageMuArr21;

@property(nonatomic, strong)UIView* view22;
@property(nonatomic, strong)UITableView* tableView22;
@property(nonatomic, strong)NSMutableArray* dataSource22;
@property(nonatomic, strong)NSMutableArray* imageMuArr22;

@property(nonatomic, strong)SetPage* setPage;
@property(nonatomic, strong)Log* log;
@property(nonatomic, strong)BrowseLogViewController* blVC;
@property(nonatomic, strong)DownloadViewController* dlVC;

@end

@implementation MyPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    
    [self initData];
    [self createScrollView];
    [self createView1];
    [self createView21];
    [self createView22];
}

- (void)initData
{
    _setPage = [[SetPage alloc]init];
    _log = [[Log alloc]init];
    _blVC = [[BrowseLogViewController alloc]init];
    _dlVC = [[DownloadViewController alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _imageMuArr21 = [NSMutableArray new];
    NSArray* arr1 = @[@"subscribe", @"icon_look", @"icon_downLoad"];
    NSArray* arr2 = @[@"comment"];
    [_imageMuArr21 addObject:arr1];
    [_imageMuArr21 addObject:arr2];
    
    _dataSource21 = [NSMutableArray new];
    NSArray* arr3 = @[@"漫画订阅", @"浏览记录", @"漫画下载"];
    NSArray* arr4 = @[@"漫画评论"];
    [_dataSource21 addObject:arr3];
    [_dataSource21 addObject:arr4];
    
    _imageMuArr22 = [NSMutableArray new];
    NSArray* arr11 = @[@"subscribe", @"icon_look", @"icon_downLoad"];
    NSArray* arr21 = @[@"comment"];
    [_imageMuArr22 addObject:arr11];
    [_imageMuArr22 addObject:arr21];
    
    _dataSource22 = [NSMutableArray new];
    NSArray* arr31 = @[@"小说订阅", @"浏览记录", @"小说下载"];
    NSArray* arr41 = @[@"小说评论"];
    [_dataSource22 addObject:arr31];
    [_dataSource22 addObject:arr41];
}

#pragma mark - 创建滚动视图
- (void)createScrollView
{
    _myPage = [[UIView alloc]init];
    _myPage.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.view addSubview:_myPage];
    [_myPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width1, height1-44-20));
        make.edges.mas_offset(UIEdgeInsetsMake(20, 0, 44, 0));
    }];
    
}

#pragma mark - 创建滚动视图上部分
- (void)createView1
{
    _view1 = [[UIView alloc]init];
    _view1.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    //_view1.backgroundColor = [UIColor redColor];
    [_myPage addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width1, height1/2.31884058));
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, height1/2.19931271, 0));
    }];

    UIImageView* bjImageView = [[UIImageView alloc]init];
    bjImageView.image = [UIImage imageNamed:@"ucenterAvatar"];
    [_view1 addSubview:bjImageView];
    [bjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width1, height1/2.83));
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, height1/1.87866928+44, 0));
    }];

    UIImageView* headerBackground = [[UIImageView alloc]init];
    headerBackground.image = [UIImage imageNamed:@"headerBackground"];
    [bjImageView addSubview:headerBackground];
    [headerBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width1, height1/2.83));
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, height1/1.87866928+44, 0));
    }];
    
    UIButton* setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //setBtn.backgroundColor = [UIColor redColor];
    setBtn.frame = CGRectMake(width1 - width1/9.07, height1/50.5, width1/13, width1/13);
    [setBtn setImage:[UIImage imageNamed:@"img_icon_settings"] forState:UIControlStateNormal];
    [setBtn.layer setMasksToBounds:YES];
    [setBtn.layer setCornerRadius:15];
    [setBtn addTarget:self action:@selector(setAction1) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:setBtn];

    UIView* logBjView = [[UIView alloc]initWithFrame:CGRectMake(width1/2.56, height1/16.27, width1/4.7, width1/4.7)];
    logBjView.backgroundColor = [UIColor colorWithRed:187.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:0.7];
    [logBjView.layer setMasksToBounds:YES];
    [logBjView.layer setCornerRadius:40];
    [_view1 addSubview:logBjView];
    
    UIImageView* logImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width1/2.56+width1/48.5, height1/16.27+width1/48.5, width1/4.7-width1/48.5*2, width1/4.7-width1/48.5*2)];
    //logImageView.backgroundColor = [UIColor redColor];
    [logImageView.layer setMasksToBounds:YES];
    [logImageView.layer setCornerRadius:30];
    logImageView.image = [UIImage imageNamed: @"img_def_head"];
    UITapGestureRecognizer* logImageViewTgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logImageViewAction)];
    logImageViewTgr.numberOfTapsRequired = 1;
    logImageViewTgr.numberOfTouchesRequired = 1;
    logImageView.userInteractionEnabled = YES;
    [logImageView addGestureRecognizer:logImageViewTgr];
    [_view1 addSubview:logImageView];
    
    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/2.56, height1/4.8, width1/4.7, height1/34.9)];
    label1.text = @"请登录";
    label1.font = [UIFont boldSystemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [bjImageView addSubview:label1];
    
    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(width1/12.58, height1/3.96, width1-width1/12.58*2, height1/42.6666666)];
    label2.text = @"登录后可以使用漫画订阅、发表评论等，我们还会提醒";
    label2.font = [UIFont boldSystemFontOfSize:12];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [bjImageView addSubview:label2];
    
    UILabel* label3 = [[UILabel alloc]initWithFrame:CGRectMake(width1/3.06, height1/3.96+height1/42.6666666, width1-width1/3.06*2, height1/42.6666666)];
    label3.text = @"您订阅的作品更新哦";
    label3.font = [UIFont boldSystemFontOfSize:12];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    [bjImageView addSubview:label3];
    
    _u5Normal2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _u5Normal2Btn.frame = CGRectMake((width1-width1/40*2)/2+width1/40-width1/150, height1/96+height1/2.83, (width1-width1/40*2)/2, height1/2.32-height1/2.83-height1/96*2);
    _u5Normal2Btn.backgroundColor = [UIColor whiteColor];
    [_u5Normal2Btn setTitle:@"我的小说" forState:UIControlStateNormal];
    [_u5Normal2Btn setTitleColor:[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    _u5Normal2Btn.layer.masksToBounds = YES;//必须设置
    _u5Normal2Btn.layer.cornerRadius = 3;//设置圆角的弧度，等于label的高的一半的时候，是个圆
    _u5Normal2Btn.layer.borderColor =[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;//边框颜色
    _u5Normal2Btn.layer.borderWidth = 1;//边框的宽度
    [_u5Normal2Btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_u5Normal2Btn];
    
    _u5Normal1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _u5Normal1Btn.frame = CGRectMake(width1/40+width1/150, height1/96+height1/2.83, (width1-width1/40*2)/2, height1/2.32-height1/2.83-height1/96*2);
    _u5Normal1Btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    [_u5Normal1Btn setTitle:@"我的漫画" forState:UIControlStateNormal];
    [_u5Normal1Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _u5Normal1Btn.layer.masksToBounds = YES;//必须设置
    _u5Normal1Btn.layer.cornerRadius = 3;//设置圆角的弧度，等于label的高的一半的时候，是个圆
    _u5Normal1Btn.layer.borderColor =[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;//边框颜色
    _u5Normal1Btn.layer.borderWidth = 1;//边框的宽度
    [_u5Normal1Btn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:_u5Normal1Btn];
    
}

- (void)setAction1
{
    NSLog(@"设置按钮被点击！");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_setPage animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)logImageViewAction
{
    NSLog(@"登录按钮被点击！");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_log animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)rightBtn
{
    NSLog(@"左边被点击！");
    
    _u5Normal1Btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    [_u5Normal1Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _u5Normal2Btn.backgroundColor = [UIColor whiteColor];
    [_u5Normal2Btn setTitleColor:[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        _view21.frame = CGRectMake(0, height1/2.31884058, width1, height1/2.19931271);
        _view22.frame = CGRectMake(width1, height1/2.31884058, width1, height1/2.19931271);
    }];
}
- (void)leftBtn
{
    NSLog(@"右边被点击！");
    
    _u5Normal2Btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    [_u5Normal2Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _u5Normal1Btn.backgroundColor = [UIColor whiteColor];
    [_u5Normal1Btn setTitleColor:[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        _view21.frame = CGRectMake(-width1, height1/2.31884058, width1, height1/2.19931271);
        _view22.frame = CGRectMake(0, height1/2.31884058, width1, height1/2.19931271);
    }];
}

#pragma mark - 创建滚动视图下部分（1）
- (void)createView21
{
    _view21 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/2.31884058, width1, height1/2.19931271)];
    [_myPage addSubview:_view21];
    
    [self createTableView21];
}

-(void)createTableView21
{
    _tableView21 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width1, height1-height1/2.47-44-20) style:UITableViewStylePlain];
    _tableView21.delegate = self;
    _tableView21.dataSource = self;
    _tableView21.bounces = NO;
    _tableView21.separatorInset = UIEdgeInsetsZero;
    _tableView21.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_view21 addSubview:_tableView21];
}

#pragma mark - 创建滚动视图下部分（2）
- (void)createView22
{
    _view22 = [[UIView alloc]initWithFrame:CGRectMake(width1, height1/2.31884058, width1, height1/2.19931271)];
    [_myPage addSubview:_view22];
    
    [self createTableView22];
}

-(void)createTableView22
{
    _tableView22 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width1, height1-height1/2.47-44-20) style:UITableViewStylePlain];
    _tableView22.delegate = self;
    _tableView22.dataSource = self;
    _tableView22.bounces = NO;
    _tableView22.separatorInset = UIEdgeInsetsZero;
    _tableView22.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_view22 addSubview:_tableView22];
}
#pragma mark-必须实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableView21) {
        return _dataSource21.count;
    }
    return _dataSource22.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView21) {
        return [_dataSource21[section] count];
    }
    return [_dataSource22[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView21) {
        static NSString* str = @"str";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.imageView.image = [UIImage imageNamed:_imageMuArr21[indexPath.section][indexPath.row]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _dataSource21[indexPath.section][indexPath.row];
        return cell;
    }
    static NSString* str = @"str1";
    UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell1.imageView.image = [UIImage imageNamed:_imageMuArr22[indexPath.section][indexPath.row]];
    
    cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell1.textLabel.text = _dataSource22[indexPath.section][indexPath.row];
    return cell1;
}
//设置尾部标题的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return height1/64;
    }
    return height1/6.33663366;
}
//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height1/14.2222222;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中行
    if (tableView == _tableView21) {
        NSLog(@"%ld%ld", (long)indexPath.section, (long)indexPath.row);
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_log animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(indexPath.row == 1)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_blVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(indexPath.row == 2)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_dlVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        }else
        {
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_log animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
    else
    {
        NSLog(@"==%ld%ld", (long)indexPath.section, (long)indexPath.row);
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0) {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_log animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(indexPath.row == 1)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_blVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(indexPath.row == 2)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_dlVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        }
        else
        {
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_log animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}
//自定义尾部视图
-(UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(0, (height1-height1/2.47-44-20)-height1/9.14+height1/2.32, width1, height1/6.33663366)];
        view1.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
        btn.frame = CGRectMake(width1/36, width1/36, width1- width1/36*2, height1/14.0145985);
        btn.layer.masksToBounds = YES;//必须设置
        btn.layer.cornerRadius = 5;
        [btn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
        return view1;
    }
    return nil;
}

- (void)btnAction1
{
    NSLog(@"登录/注册按钮被点击！");
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_log animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
