//
//  ComicBookReadingPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/26.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ComicBookReadingPage.h"
#import "Dfine.h"

@interface ComicBookReadingPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)NSArray* dataSource;

@property(nonatomic, assign)BOOL isRelationRead;
@property(nonatomic, assign)BOOL isLeftToRightAndTopToBottom;
@property(nonatomic, assign)BOOL isViewpointAndBullet;
@property(nonatomic, assign)BOOL isAutomaticAndClose;

@end

@implementation ComicBookReadingPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self createNavigation];
    [self createTableView];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isRelationRead = NO;   //  当变量为NO时阅读时屏幕方向 为竖屏阅读反之为横屏阅读
    _isLeftToRightAndTopToBottom = NO;   // 当变量为NO时竖屏翻页方向 是从左往右，反之从上往下
    _isViewpointAndBullet = NO;//   当为NO时 为观点模式 反之弹幕模式
    _isAutomaticAndClose = NO;//    当为NO时 自动切分 反之 关闭切分
    
    _dataSource = @[@"阅读时屏幕方向", @"竖屏翻页的方向", @"隐藏虚拟按键", @"显示状态信息", @"音量键翻页", @"吐槽显示方式", @"双页切分", @"翻页动画"];
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"漫画阅读设置";
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

- (void)createTableView
{
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0)
    {
        static NSString* cellID = @"cell1";
        UITableViewCell* cell2 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell2.tag =5099;
        cell2.textLabel.text = _dataSource[indexPath.row];
        cell2.detailTextLabel.text = @"竖屏阅读";
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell2;
    }else if (indexPath.row == 1)
    {
        static NSString* cellID = @"cell2";
        UITableViewCell* cell3 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell3.tag =5098;
        cell3.textLabel.text = _dataSource[indexPath.row];
        cell3.detailTextLabel.text = @"从左往右";
        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell3;
    }else if (indexPath.row == 5)
    {
        static NSString* cellID = @"cell3";
        UITableViewCell* cell4 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell4 == nil) {
            cell4 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell4.tag =5097;
        cell4.textLabel.text = _dataSource[indexPath.row];
        cell4.detailTextLabel.text = @"观点模式";
        cell4.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell4;
    }else if (indexPath.row == 6)
    {
        static NSString* cellID = @"cell4";
        UITableViewCell* cell5 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell5 == nil) {
            cell5 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell5.tag =5096;
        cell5.textLabel.text = _dataSource[indexPath.row];
        cell5.detailTextLabel.text = @"自动切分";
        cell5.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell5;
    }
    
    static NSString* cellID = @"cell5";
    UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell1 == nil)
    {
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell1.textLabel.text = _dataSource[indexPath.row];
    //  创建自定义挂件
    UISwitch* switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, width1/6.96774194, height1/19.2)];
    switch1.tag = indexPath.row+5100;
    [switch1 setOnTintColor:[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1]];
    [cell1 setAccessoryView:switch1];
    return cell1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        _isRelationRead = !_isRelationRead;
        [self isPattern:_isRelationRead andWithTag:5099 andWithPatternOne:@"竖屏阅读" andWithPatternTwo:@"横屏阅读"];
    }else if (indexPath.row == 1)
    {
        _isLeftToRightAndTopToBottom = !_isLeftToRightAndTopToBottom;
        [self isPattern:_isLeftToRightAndTopToBottom andWithTag:5098 andWithPatternOne:@"从左往右" andWithPatternTwo:@"从上往下"];
    }else if (indexPath.row == 5)
    {
        _isViewpointAndBullet = !_isViewpointAndBullet;
        [self isPattern:_isViewpointAndBullet andWithTag:5097 andWithPatternOne:@"观点模式" andWithPatternTwo:@"弹幕模式"];
    }else if (indexPath.row == 6)
    {
        _isAutomaticAndClose = !_isAutomaticAndClose;
        [self isPattern:_isAutomaticAndClose andWithTag:5096 andWithPatternOne:@"自动切分" andWithPatternTwo:@"关闭切分"];
    }else if (indexPath.row == 2)
    {
        [self isSwitch:5102];
    }else if (indexPath.row == 3)
    {
        [self isSwitch:5103];
    }else if (indexPath.row == 4)
    {
        [self isSwitch:5104];
    }else if (indexPath.row == 7)
    {
        [self isSwitch:5107];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height1/14.2222222;
}

- (void)isPattern:(BOOL )is andWithTag:(NSInteger )tag andWithPatternOne:(NSString* )patternOne andWithPatternTwo:(NSString* )patternTwo
{
    UITableViewCell* cell = [self.view viewWithTag:tag];
    if (is == NO)
    {
        cell.detailTextLabel.text = patternOne;
    }else
    {
        cell.detailTextLabel.text = patternTwo;
    }
}

- (void)isSwitch:(NSInteger )tag
{
    UISwitch* switch1 = (UISwitch* )[self.view viewWithTag:tag];
    switch1.on = !switch1.on;
}
@end
