//
//  MobileNetworkPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/26.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "MobileNetworkPage.h"
#import "Dfine.h"

@interface MobileNetworkPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)NSArray* dataSource;

@end

@implementation MobileNetworkPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self createNavigation];
    [self initTableView];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSource = @[@"移动网络观看漫画", @"移动网络下载漫画", @"移动网络观看小说", @"移动网络下载小说"];
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"移动网络设置";
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

- (void)initTableView
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
    static NSString* cellID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    //  创建自定义挂件
    UISwitch* switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, width1/6.96774194, height1/19.2)];
    switch1.tag = indexPath.row+5000;
    [switch1 setOnTintColor:[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1]];
    [cell setAccessoryView:switch1];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UISwitch* switch1 = (UISwitch* )[self.view viewWithTag:5000];
        switch1.on = !switch1.on;
    }else if (indexPath.row == 1) {
        UISwitch* switch1 = (UISwitch* )[self.view viewWithTag:5001];
        switch1.on = !switch1.on;
    }else if (indexPath.row == 2) {
        UISwitch* switch1 = (UISwitch* )[self.view viewWithTag:5002];
        switch1.on = !switch1.on;
    }else if (indexPath.row == 3) {
        UISwitch* switch1 = (UISwitch* )[self.view viewWithTag:5003];
        switch1.on = !switch1.on;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height1/14.2222222;
}
@end
