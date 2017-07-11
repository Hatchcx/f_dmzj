//
//  LightNovelPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/13.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "LightNovelPage.h"
#import "UIImageView+WebCache.h"
#import "Dfine.h"
#import "UrlDfine.h"
#import "BaseService.h"
#import "LightNoveTableViewCell1.h"
#import "LightNoveTableViewCell2.h"
#import "LightNoveTabelViewCell3.h"
#import "MJRefresh.h"

@interface LightNovelPage ()<UIScrollViewDelegate, UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)UIPageControl* pageController;
@property(nonatomic, strong)UILabel* label;
@property(nonatomic, strong)UITapGestureRecognizer* tap1;
@property(nonatomic, strong)UITapGestureRecognizer* tap2;
@property(nonatomic, strong)UITapGestureRecognizer* tap3;
@property(nonatomic, strong)UITapGestureRecognizer* tap4;
@property(nonatomic, strong)UITapGestureRecognizer* tap5;
@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)UIView* view1;
@property(nonatomic, strong)NSMutableArray* dataSource1;

@end

@implementation LightNovelPage

static NSString* cellID=@"cell";
static NSString* cellID1=@"cell1";
static NSString* cellID2=@"cell2";

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataSource1 = [NSMutableArray array];
    _view1=[[UIView alloc]initWithFrame:CGRectMake(0, 64, width1, height1/3+height1/6.3+height1/64)];
    _view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addTimer];
    [self createNavigation];
    [self downData1];
}

-(void)downData1
{
    [BaseService getRequest:LightNovePageUrl1 :nil finshedBlock:^(id dataString)
     {
         [_dataSource1 removeAllObjects];
         _dataSource1=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
         //NSLog(@"==========%@", _dataSource1);
         if (_tableView == nil) {
             [self createTableView];
         }
         if (_scrollView == nil) {
             [self createScrollView];
         }
         [self createTableView1];
         [_tableView.header endRefreshing];
     } ErrorBlock:^(NSError *error)
     {
         NSLog(@"请求失败！");
     }];
}

- (void)createTableView1
{
    //通过xib文件获取单元格，第一个参数是xib文件的文件名
    UINib* nib1=[UINib nibWithNibName:@"LightNoveTableViewCell1" bundle:nil];
    //向表格注册单元格，第一个参数是单元格，第二个参数是单元格的标记
    [_tableView registerNib:nib1 forCellReuseIdentifier:cellID];
    
    //通过xib文件获取单元格，第一个参数是xib文件的文件名
    UINib* nib2=[UINib nibWithNibName:@"LightNoveTableViewCell2" bundle:nil];
    //向表格注册单元格，第一个参数是单元格，第二个参数是单元格的标记
    [_tableView registerNib:nib2 forCellReuseIdentifier:cellID1];
    
    //通过xib文件获取单元格，第一个参数是xib文件的文件名
    UINib* nib3=[UINib nibWithNibName:@"LightNoveTabelViewCell3" bundle:nil];
    //向表格注册单元格，第一个参数是单元格，第二个参数是单元格的标记
    [_tableView registerNib:nib3 forCellReuseIdentifier:cellID2];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, width1, (height1-64-44)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [_tableView.header beginRefreshing];
        [self downData1];
    }];
}

//返回表格有多少个组，在分组风格的表格中这个方法是必须实现的
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"分区");
    return 4;
}

//返回每组有多少行，无论是什么风格的表格都必须实现的方法.||section就是组的索引值,可以通过索引值找到当前小数组，然后返回小数组的长度
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"行");
    return 1;
}

//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%ld", (long)indexPath.section);
    //NSLog(@"====%@", _dataSource1);
    if (indexPath.section == 0) {
        LightNoveTableViewCell1 * cell1=[tableView dequeueReusableCellWithIdentifier:cellID];
        NSArray* arr = [_dataSource1[1]objectForKey:@"data"];
        cell1.lab1.text = [arr[0]objectForKey:@"title"];
        cell1.lab2.text = [arr[1]objectForKey:@"title"];
        cell1.lab3.text = [arr[2]objectForKey:@"title"];
        [cell1.btn1.layer setMasksToBounds:YES];
        [cell1.btn1.layer setCornerRadius:5.0];
        [cell1.btn2.layer setMasksToBounds:YES];
        [cell1.btn2.layer setCornerRadius:5.0];
        [cell1.btn3.layer setMasksToBounds:YES];
        [cell1.btn3.layer setCornerRadius:5.0];
        
//        NSURL *imageurl = [NSURL URLWithString:[arr[0]objectForKey:@"cover"]];
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
//        [cell1.btn1 setImage:image forState:UIControlStateNormal];
//        NSURL *imageurl1 = [NSURL URLWithString:[arr[1]objectForKey:@"cover"]];
//        UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl1]];
//        [cell1.btn2 setImage:image1 forState:UIControlStateNormal];
//        NSURL *imageurl2 = [NSURL URLWithString:[arr[2]objectForKey:@"cover"]];
//        UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl2]];
//        [cell1.btn3 setImage:image2 forState:UIControlStateNormal];
        return cell1;
    }else if(indexPath.section == 1)
    {
        LightNoveTableViewCell2 * cell2=[tableView dequeueReusableCellWithIdentifier:cellID1];
        NSArray* arr = [_dataSource1[2]objectForKey:@"data"];
        cell2.lab1.text = [arr[0]objectForKey:@"title"];
        cell2.lab2.text = [arr[1]objectForKey:@"title"];
        cell2.lab3.text = [arr[2]objectForKey:@"title"];
        cell2.subTitle1.text = [arr[0]objectForKey:@"sub_title"];
        cell2.subTitle2.text = [arr[1]objectForKey:@"sub_title"];
        cell2.subTitle3.text = [arr[2]objectForKey:@"sub_title"];
        cell2.labHeard.text = [_dataSource1[2]objectForKey:@"title"];
        cell2.image1.image = [UIImage imageNamed:@"novelHeaderIcon_60"];
        [cell2.btn1.layer setMasksToBounds:YES];
        [cell2.btn1.layer setCornerRadius:5.0];
        [cell2.btn2.layer setMasksToBounds:YES];
        [cell2.btn2.layer setCornerRadius:5.0];
        [cell2.btn3.layer setMasksToBounds:YES];
        [cell2.btn3.layer setCornerRadius:5.0];
        return cell2;
    }else if(indexPath.section == 2)
    {
        LightNoveTableViewCell2 * cell3=[tableView dequeueReusableCellWithIdentifier:cellID1];
        NSArray* arr = [_dataSource1[3]objectForKey:@"data"];
        cell3.lab1.text = [arr[0]objectForKey:@"title"];
        cell3.lab2.text = [arr[1]objectForKey:@"title"];
        cell3.lab3.text = [arr[2]objectForKey:@"title"];
        cell3.subTitle1.text = [arr[0]objectForKey:@"sub_title"];
        cell3.subTitle2.text = [arr[1]objectForKey:@"sub_title"];
        cell3.subTitle3.text = [arr[2]objectForKey:@"sub_title"];
        cell3.labHeard.text = [_dataSource1[3]objectForKey:@"title"];
        cell3.image1.image = [UIImage imageNamed:@"novelHeaderIcon_62"];
        [cell3.btn1.layer setMasksToBounds:YES];
        [cell3.btn1.layer setCornerRadius:5.0];
        [cell3.btn2.layer setMasksToBounds:YES];
        [cell3.btn2.layer setCornerRadius:5.0];
        [cell3.btn3.layer setMasksToBounds:YES];
        [cell3.btn3.layer setCornerRadius:5.0];
        return cell3;
    }else
    {
        LightNoveTabelViewCell3 * cell4=[tableView dequeueReusableCellWithIdentifier:cellID2];
        NSArray* arr = [_dataSource1[4]objectForKey:@"data"];
        cell4.lab1.text = [arr[0]objectForKey:@"title"];
        cell4.lab2.text = [arr[1]objectForKey:@"title"];
        cell4.lab3.text = [arr[2]objectForKey:@"title"];
        cell4.lab4.text = [arr[3]objectForKey:@"title"];
        cell4.lab5.text = [arr[4]objectForKey:@"title"];
        cell4.lab6.text = [arr[5]objectForKey:@"title"];
        cell4.subTitle1.text = [arr[0]objectForKey:@"sub_title"];
        cell4.subTitle2.text = [arr[1]objectForKey:@"sub_title"];
        cell4.subTitle3.text = [arr[2]objectForKey:@"sub_title"];
        cell4.subTitle4.text = [arr[3]objectForKey:@"sub_title"];
        cell4.subTitle5.text = [arr[4]objectForKey:@"sub_title"];
        cell4.subTitle6.text = [arr[5]objectForKey:@"sub_title"];
        [cell4.btn1.layer setMasksToBounds:YES];
        [cell4.btn1.layer setCornerRadius:5.0];
        [cell4.btn2.layer setMasksToBounds:YES];
        [cell4.btn2.layer setCornerRadius:5.0];
        [cell4.btn3.layer setMasksToBounds:YES];
        [cell4.btn3.layer setCornerRadius:5.0];
        [cell4.btn4.layer setMasksToBounds:YES];
        [cell4.btn4.layer setCornerRadius:5.0];
        [cell4.btn5.layer setMasksToBounds:YES];
        [cell4.btn5.layer setCornerRadius:5.0];
        [cell4.btn6.layer setMasksToBounds:YES];
        [cell4.btn6.layer setCornerRadius:5.0];
        return cell4;
    }
}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return height1/3.1;
    }else if(indexPath.section == 1)
    {
        return height1/2.84;
    }else if(indexPath.section == 2)
    {
        return height1/2.84;
    }else
    {
        return height1/1.53;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return height1/3+height1/6.3+height1/64;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return height1/64;
}

//自定义头部视图
-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _view1;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)createScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/3)];
    [_view1 addSubview:_scrollView];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, (height1/3)-27, width1, 30)];
    _label.textColor=[UIColor whiteColor];
    _label.backgroundColor=[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:0.7];
    _label.font = [UIFont boldSystemFontOfSize:12];
    NSArray* arr = [_dataSource1[0]objectForKey:@"data"];
    _label.text = [arr[0]objectForKey:@"title"];
    [_view1 addSubview:_label];
    
    NSArray* arrWithImage=@[@"-925760583",@"1084058371",@"1199381870",@"937569063",@"-1802506844"];
    for (int i=0; i<5; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(width1*i, 0, width1, height1/3)];
        imageView.image=[UIImage imageNamed:arrWithImage[i]];
        //[imageView setImageWithURL:[NSURL URLWithString:_arrImage[i]]];
        imageView.tag = i+10;
        [_scrollView addSubview:imageView];
        
        if (imageView.tag == 10) {
            _tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtion1)];
            _tap1.numberOfTapsRequired = 1;
            _tap1.numberOfTouchesRequired = 1;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:_tap1];
        }else if(imageView.tag == 11)
        {
            _tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtion2)];
            _tap2.numberOfTapsRequired = 1;
            _tap2.numberOfTouchesRequired = 1;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:_tap2];
        }else if(imageView.tag == 12)
        {
            _tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtion3)];
            _tap3.numberOfTapsRequired = 1;
            _tap3.numberOfTouchesRequired = 1;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:_tap3];
        }else if(imageView.tag == 13)
        {
            _tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtion4)];
            _tap4.numberOfTapsRequired = 1;
            _tap4.numberOfTouchesRequired = 1;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:_tap4];
        }else if(imageView.tag == 14)
        {
            _tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtion5)];
            _tap5.numberOfTapsRequired = 1;
            _tap5.numberOfTouchesRequired = 1;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:_tap5];
        }
    }
    
    NSArray* arrWithImage2 = @[@"pursueNovel", @"filterNovel", @"novelRecommend"];
    NSArray* arrWithlabel = @[@"追小说", @"找小说", @"排行榜"];
    for (int j = 0; j < 3; j++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width1/10)+j*((width1-width1/10*6)/3+width1/10*2), height1/3+20, (width1-width1/10*6)/3, (width1-width1/10*6)/3);
        [btn setImage:[UIImage imageNamed:arrWithImage2[j]] forState:UIControlStateNormal];
        //btn.backgroundColor = [UIColor redColor];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:20];
        btn.tag = 10000+j;
        [btn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        [_view1 addSubview:btn];
        
        UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake((width1/10)+j*((width1-width1/10*6)/3+width1/10*2), height1/3+((width1-width1/10*6)/3+(width1-width1/10*6)/3/2), (width1-width1/10*6)/3, (width1-width1/10*6)/3/2)];
        //label1.backgroundColor = [UIColor yellowColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont boldSystemFontOfSize:13];
        label1.text = arrWithlabel[j];
        [_view1 addSubview:label1];
    }
    
    UIView* smallView = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/6.3, width1, height1/64)];
    smallView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [_view1 addSubview:smallView];
    
    _scrollView.contentSize=CGSizeMake(width1*5, height1/4);
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    
    //创建分页控制器  并加载到self.view视图上
    _pageController=[[UIPageControl alloc]initWithFrame:CGRectMake((width1/3)*2, (height1/3)-30, 100, 30)];
    _pageController.backgroundColor=[UIColor clearColor];
    _pageController.numberOfPages=5;
    _pageController.currentPage=0;
    [_view1 addSubview:_pageController];
    [_pageController addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
}

//开启定时器
- (void)addTimer{
    //设置定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change:) userInfo:nil repeats:YES];
}
//关闭定时器
- (void)removeTimer{
    if (_timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
            _timer=nil;
        }
    }
}
//定时器执行方法
- (void)change:(NSTimer *)time{
    if (_pageController.currentPage == _pageController.numberOfPages - 1) {
        _pageController.currentPage = 0;
        NSArray* arr = [_dataSource1[0]objectForKey:@"data"];
        _label.text = [arr[_pageController.currentPage]objectForKey:@"title"];
    } else if (_pageController.currentPage < _pageController.numberOfPages - 1) {
        _pageController.currentPage++;
        NSArray* arr = [_dataSource1[0]objectForKey:@"data"];
        _label.text = [arr[_pageController.currentPage]objectForKey:@"title"];
    }
    _scrollView.contentOffset=CGPointMake(width1*(_pageController.currentPage), 0);
}

//开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //关闭定时器(注意,定时器一旦被关闭,无法在开启)
    [self removeTimer];
}
//拖拽结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //开启定时器
    [self addTimer];
}

- (void)pageAction:(UIPageControl*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset=CGPointMake(width1*(_pageController.currentPage), 0);
        NSArray* arr = [_dataSource1[0]objectForKey:@"data"];
        _label.text = [arr[_pageController.currentPage]objectForKey:@"title"];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView) {
        CGPoint point=scrollView.contentOffset;
        NSInteger page=point.x/width1;
        NSLog(@"%f",point.x/width1);
        _pageController.currentPage=page;
        NSArray* arr = [_dataSource1[0]objectForKey:@"data"];
        _label.text = [arr[page]objectForKey:@"title"];
    }
}

- (void)tapAtion1
{
    NSLog(@"1");
    /*
     self.hidesBottomBarWhenPushed = YES;
     RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
     recommendWeb.strUrl = [_arr[0] objectForKey:@"object_url"];
     [self.navigationController pushViewController:recommendWeb animated:YES];
     self.hidesBottomBarWhenPushed = NO;*/
}
- (void)tapAtion2
{
    NSLog(@"2");
    /*
     self.hidesBottomBarWhenPushed = YES;
     RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
     recommendWeb.strUrl = [_arr[1] objectForKey:@"object_url"];
     [self.navigationController pushViewController:recommendWeb animated:YES];
     self.hidesBottomBarWhenPushed = NO;*/
}
- (void)tapAtion3
{
    NSLog(@"3");
    /*
     self.hidesBottomBarWhenPushed = YES;
     RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
     recommendWeb.strUrl = [_arr[2] objectForKey:@"object_url"];
     [self.navigationController pushViewController:recommendWeb animated:YES];
     self.hidesBottomBarWhenPushed = NO;*/
}
- (void)tapAtion4
{
    NSLog(@"4");
    /*
     self.hidesBottomBarWhenPushed = YES;
     RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
     recommendWeb.strUrl = [_arr[3] objectForKey:@"object_url"];
     [self.navigationController pushViewController:recommendWeb animated:YES];
     self.hidesBottomBarWhenPushed = NO;*/
}
- (void)tapAtion5
{
    NSLog(@"5");
    /*
     self.hidesBottomBarWhenPushed = YES;
     RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
     recommendWeb.strUrl = [_arr[4] objectForKey:@"object_url"];
     [self.navigationController pushViewController:recommendWeb animated:YES];
     self.hidesBottomBarWhenPushed = NO;*/
}

- (void)btnAction1:(UIButton*)sender
{
    switch (sender.tag) {
        case 10000:
        {
            NSLog(@"追小说按钮被点击！");
            break;
        }
        case 10001:
        {
            NSLog(@"找小说按钮被点击！");
            break;
        }
        case 10002:
        {
            NSLog(@"排行榜按钮被点击！");
            break;
        }
        default:
            break;
    }
}

- (void)navigationBarSearch:(UIButton* )sender
{
    NSLog(@"被点击！");
}

- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 44)];
    [self.view addSubview:view];
    
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 41, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [view addSubview:navigationBarBottomLineImage];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"轻小说";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelTitle];
    
    UIButton* navigationBarSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationBarSearch.frame = CGRectMake(width1-45, 10, 37, 26);
    [navigationBarSearch setImage:[UIImage imageNamed:@"NavigationBarSearch"] forState:UIControlStateNormal];
    [navigationBarSearch addTarget:self action:@selector(navigationBarSearch:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:navigationBarSearch];
}

@end
