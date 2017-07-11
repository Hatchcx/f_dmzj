//
//  AboutUsPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/4/26.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "AboutUsPage.h"
#import "Dfine.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface AboutUsPage ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView* tabelView;
@property(nonatomic, strong)NSArray* dataSource;

@end

@implementation AboutUsPage

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
     _dataSource = @[@"访问官网", @"推荐给好友"];
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"关于我们";
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
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.separatorInset = UIEdgeInsetsZero;
    _tabelView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tabelView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"cell1";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tabelView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSLog(@"访问官网");
    }else if(indexPath.row == 1)
    {
        [self shareSKD];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height1/14.2222222;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return height1/7.90123457;
}

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/7.90123457)];
    imageView.backgroundColor = [UIColor redColor];
    //imageView.image = [UIImage imageNamed:@"LogoByDMZJ"];
    return imageView;
}

- (void)shareSKD
{
    /*
     //1、创建分享参数
     NSArray* imageArray = @[[UIImage imageNamed:@"120*120.png"]];
     //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
     if (imageArray) {
     
     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
     [shareParams SSDKSetupShareParamsByText:@"分享内容"
     images:imageArray
     url:[NSURL URLWithString:@"http://mob.com"]
     title:@"分享标题"
     type:SSDKContentTypeAuto];
     //有的平台要客户端分享需要加此方法，例如微博
     [shareParams SSDKEnableUseClientShare];
     //2、分享（可以弹出我们的分享菜单和编辑界面）
     [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
     items:nil
     shareParams:shareParams
     onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
     
     switch (state) {
     case SSDKResponseStateSuccess:
     {
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
     message:nil
     delegate:nil
     cancelButtonTitle:@"确定"
     otherButtonTitles:nil];
     [alertView show];
     break;
     }
     case SSDKResponseStateFail:
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
     message:[NSString stringWithFormat:@"%@",error]
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil, nil];
     [alert show];
     break;
     }
     default:
     break;
     }
     }
     ];}*/
    //分享
    //创建分享参数
    NSString *title = @"动漫之家";
    NSString *titleStr = @"动漫之家－非常好的一款动漫画软件，邀请你也来试试";
    NSString *textStr = @"我在使用动漫之家APP，非常好的一款手机软件，邀请你也来试试。";
    //UIImage *image = [UIImage imageNamed:@"120.120"];
    //UIImage *weiboIamge = [UIImage imageNamed:@"pp"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Public/mobile_view/download.html",@"http://api.xiucall.com/"]];
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    //新浪微博
    [shareParams SSDKSetupSinaWeiboShareParamsByText:textStr title:title image:nil url:url latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
    //qq
    [shareParams SSDKSetupQQParamsByText:textStr title:title url:url thumbImage:nil image:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    //qq 空间
    [shareParams SSDKSetupQQParamsByText:textStr title:title url:url thumbImage:nil image:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
    //微信好友
    [shareParams SSDKSetupWeChatParamsByText:textStr title:title url:url thumbImage:nil image:nil musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    //微信朋友圈
    [shareParams SSDKSetupWeChatParamsByText:textStr title:titleStr url:url thumbImage:nil image:nil musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    
    
    NSArray *activePlatforms=@[[NSNumber numberWithInt:1],[NSNumber numberWithInt:24],[NSNumber numberWithInt:6],[NSNumber numberWithInt:22],[NSNumber numberWithInt:23]];
    //2、分享
    [ShareSDK showShareActionSheet:nil
                             items:activePlatforms
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}
@end
