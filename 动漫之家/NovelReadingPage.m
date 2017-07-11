//
//  NovelReadingPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/26.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "NovelReadingPage.h"
#import "Dfine.h"

@interface NovelReadingPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)NSArray* dataSource;

@property(nonatomic, assign)BOOL isLeftHandAndRighrHand;

@end

@implementation NovelReadingPage

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
    _isLeftHandAndRighrHand = NO;   //  当为NO时是右手模式，反之是左手模式
    _dataSource = @[@"左右手模式", @"隐藏虚拟按键", @"隐藏状态信息", @"音量键翻页", @"翻页动画"];
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"小说阅读设置";
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
        cell2.tag =5200;
        cell2.textLabel.text = _dataSource[indexPath.row];
        cell2.detailTextLabel.text = @"右手模式";
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell2;
    }
    
    static NSString* cellID = @"cell2";
    UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell1 == nil)
    {
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell1.textLabel.text = _dataSource[indexPath.row];
    //  创建自定义挂件
    UISwitch* switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, width1/6.96774194, height1/19.2)];
    switch1.tag = indexPath.row+5200;
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
        _isLeftHandAndRighrHand = !_isLeftHandAndRighrHand;
        [self isPattern:_isLeftHandAndRighrHand andWithTag:5200 andWithPatternOne:@"右手模式" andWithPatternTwo:@"左手模式"];
    }else if(indexPath.row == 1)
    {
        [self isSwitch:5201];
    }else if(indexPath.row == 2)
    {
        [self isSwitch:5202];
    }else if(indexPath.row == 3)
    {
        [self isSwitch:5203];
    }else if(indexPath.row == 4)
    {
        [self isSwitch:5204];
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
