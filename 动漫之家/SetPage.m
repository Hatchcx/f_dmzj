//
//  SetPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/25.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "SetPage.h"
#import "Dfine.h"
#import "MobileNetworkPage.h"
#import "ComicBookReadingPage.h"
#import "NovelReadingPage.h"
#import "FeedbackPage.h"
#import "AboutUsPage.h"


static NSString* cell2ID= @"cell2";
static NSString* cell3ID= @"cell3";
static NSString* cell4ID= @"cell4";
static NSString* cell5ID= @"cell5";
static NSString* cell6ID= @"cell6";

@interface SetPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)NSMutableArray* dataSource;

@property(nonatomic, strong)MobileNetworkPage* mNPage;
@property(nonatomic, strong)ComicBookReadingPage* cBRPage;
@property(nonatomic, strong)NovelReadingPage* nRPage;
@property(nonatomic, strong)FeedbackPage* fBPage;
@property(nonatomic, strong)AboutUsPage* aUPage;

@property(nonatomic, strong)UIView* view1;
@property(nonatomic, strong)UIView* view2;
@property(nonatomic, strong)UITableView* tableViewUpdate;//更新提醒
@property(nonatomic, strong)NSArray* dataSourceUpdate;

@end

@implementation SetPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self createNavigation];
    [self initTableView];
    [self initUpdateView];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mNPage = [[MobileNetworkPage alloc]init];
    _cBRPage = [[ComicBookReadingPage alloc]init];
    _nRPage = [[NovelReadingPage alloc]init];
    _fBPage = [[FeedbackPage alloc]init];
    _aUPage = [[AboutUsPage alloc]init];
    
    [self createDataSource];
    _dataSourceUpdate  = @[@"从不", @"一天一次", @"两天一次", @"取消"];
}

//  永远显示更新设置
- (void)initUpdateView
{
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(width1, 20, width1, height1-20)];
    _view1.backgroundColor = [UIColor blackColor];
    _view1.alpha = 0.5;
    [self.view addSubview:_view1];
    
    UITapGestureRecognizer* tapView1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView1Action)];
    tapView1.numberOfTapsRequired = 1;
    tapView1.numberOfTouchesRequired = 1;
    [_view1 addGestureRecognizer:tapView1];
    
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313)];
    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];

    _tableViewUpdate = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width1-width1/10.8*2, height1/2.91793313) style:UITableViewStylePlain];
    _tableViewUpdate.delegate = self;
    _tableViewUpdate.dataSource = self;
    _tableViewUpdate.bounces = NO;
    _tableViewUpdate.separatorInset = UIEdgeInsetsZero;
    [_view2 addSubview:_tableViewUpdate];
}

- (void)tapView1Action
{
    [UIView animateWithDuration:0.00001 animations:^{
        [UIView animateWithDuration:0.1 animations:^{
            _view1.frame = CGRectMake(width1, 20, width1, height1-20);
            _view2.frame = CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
        }];
    }];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_tableView];
}

- (void)createDataSource
{
    _dataSource = [NSMutableArray array];
    NSArray* arr1 = @[@"移动网络设置", @"漫画阅读设置", @"小说阅读设置"];
    NSArray* arr2 = @[@"更新设置"];
    NSArray* arr3 = @[@"下载保存位置", @"清除缓存", @"意见反馈", @"关于我们"];
    [_dataSource addObject:arr1];
    [_dataSource addObject:arr2];
    [_dataSource addObject:arr3];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (tableView == _tableView) {
        return _dataSource.count;
    }
    return _dataSourceUpdate.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView == _tableView) {
        return [_dataSource[section] count ];
    }
    return _dataSourceUpdate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == _tableView) {
        if (indexPath.section == 0) {
            static NSString* cellIndentifier= @"cell1";
            UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell1 == nil) {
                cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell1.textLabel.text = _dataSource[indexPath.section][indexPath.row];
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell1;
        }else if(indexPath.section == 1)
        {
            static NSString* cellIndentifier= @"cell2";
            UITableViewCell* cell2 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell2 == nil) {
                cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            cell2.tag = 5299;
            cell2.textLabel.text = _dataSource[indexPath.section][indexPath.row];
            cell2.detailTextLabel.text = @"一天一次";
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell2;
        }
        if (indexPath.row == 0) {
            static NSString* cellIndentifier= @"cell3";
            UITableViewCell* cell5 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell5 == nil) {
                cell5 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
            }
            cell5.textLabel.text = _dataSource[indexPath.section][indexPath.row];
            cell5.detailTextLabel.text = @"存储位置";
            return cell5;
        }else if (indexPath.row == 1) {
            static NSString* cellIndentifier= @"cell4";
            UITableViewCell* cell6 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell6 == nil) {
                cell6 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            cell6.textLabel.text = _dataSource[indexPath.section][indexPath.row];
            cell6.detailTextLabel.text = @"计算中...";
            return cell6;
        }
        static NSString* cellIndentifier= @"cell5";
        UITableViewCell* cell3 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell3.textLabel.text = _dataSource[indexPath.section][indexPath.row];
        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell3;
    }
    
    static NSString* cellIndentifier= @"cell6";
    UITableViewCell* cell4 = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell4 == nil) {
        cell4 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell4.tag = indexPath.row+ 5300;
    cell4.textLabel.text = _dataSourceUpdate[indexPath.row];
    cell4.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell4;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        return height1/14.2222222;
    }
    return height1/16.4102561;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return 0.1;
    }
    return height1/11.7791411;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return height1/15.7377049;
    }
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_tableViewUpdate deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _tableView)
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_mNPage animated:YES];
            }else if(indexPath.row == 1)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_cBRPage animated:YES];
            }else if(indexPath.row == 2)
            {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_nRPage animated:YES];
            }
        }else if(indexPath.section == 1)
        {
            [UIView animateWithDuration:0.00001 animations:^{
                _view1.frame = CGRectMake(0, 20, width1, height1-20);
                _view2.frame = CGRectMake(width1/10.8, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
            }];
        }else
        {
            if (indexPath.row == 2) {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_fBPage animated:YES];
            }
            if (indexPath.row == 3) {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:_aUPage animated:YES];
            }
        }
    }
    
    if (tableView == _tableViewUpdate) {
        if (indexPath.row == 0) {
            UITableViewCell* cell = [self.view viewWithTag:5299];
            UITableViewCell* cell1 = [self.view viewWithTag:5300];
            cell.detailTextLabel.text = cell1.textLabel.text;
            [UIView animateWithDuration:0.00001 animations:^{
                [UIView animateWithDuration:0.1 animations:^{
                    _view1.frame = CGRectMake(width1, 20, width1, height1-20);
                    _view2.frame = CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
                }];
            }];
        }else if (indexPath.row == 1)
        {
                UITableViewCell* cell = [self.view viewWithTag:5299];
                UITableViewCell* cell1 = [self.view viewWithTag:5301];
                cell.detailTextLabel.text = cell1.textLabel.text;
                [UIView animateWithDuration:0.00001 animations:^{
                    [UIView animateWithDuration:0.1 animations:^{
                        _view1.frame = CGRectMake(width1, 20, width1, height1-20);
                        _view2.frame = CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
                    }];
                }];
        }else if (indexPath.row == 2)
        {
            UITableViewCell* cell = [self.view viewWithTag:5299];
            UITableViewCell* cell1 = [self.view viewWithTag:5302];
            cell.detailTextLabel.text = cell1.textLabel.text;
            [UIView animateWithDuration:0.00001 animations:^{
                [UIView animateWithDuration:0.1 animations:^{
                    _view1.frame = CGRectMake(width1, 20, width1, height1-20);
                    _view2.frame = CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
                }];
            }];
        }else if (indexPath.row == 3)
        {
            [UIView animateWithDuration:0.00001 animations:^{
                [UIView animateWithDuration:0.1 animations:^{
                    _view1.frame = CGRectMake(width1, 20, width1, height1-20);
                    _view2.frame = CGRectMake(width1/10.8+width1, height1/3.65714286+20, width1-width1/10.8*2, height1/2.91793313);
                }];
            }];
        }
    }
}


- (UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/15.7377049)];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/25.7142857, 0, width1, height1/15.7377049)];
        [view addSubview:label];
        if (section == 0) {
            label.text = @"通知设置";
        }else if(section == 1)
        {
            label.text = @"下载设置";
        }
        return view;
    }
    return nil;
}

//更新提醒头部标题
- (NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableViewUpdate) {
        if (section == 0) {
            return @"更新提醒";
        }
    }
    return nil;
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"设置";
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
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
