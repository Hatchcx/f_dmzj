//
//  NewsPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "NewsPage.h"
#import "Dfine.h"
#import "UrlDfine.h"
#import "ClassificationPage.h"
#import "NewsCollectionViewCell.h"
#import "AlertsCollectionViewCell.h"
#import "HeardCollectionReusableView.h"
#import "BaseService.h"
#import "RecommendWeb.h"
#import "MJRefresh.h"

@interface NewsPage ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView* newsPageCollectionView;
@property(nonatomic, strong)UIView* heardView;
@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)UIPageControl* pageController;
@property(nonatomic, strong)UILabel* label;
@property(nonatomic, strong)UITapGestureRecognizer* tap1;
@property(nonatomic, strong)UITapGestureRecognizer* tap2;
@property(nonatomic, strong)UITapGestureRecognizer* tap3;
@property(nonatomic, strong)UITapGestureRecognizer* tap4;
@property(nonatomic, strong)UITapGestureRecognizer* tap5;
@property(nonatomic, strong)UITapGestureRecognizer* tapleftLaebl;
@property(nonatomic, strong)UITapGestureRecognizer* tapRightLabel;
@property(nonatomic, strong)UILabel* u5Normal2Label;
@property(nonatomic, strong)UILabel* u5Normal1Label;
@property(nonatomic, assign)NSInteger newPage;
@property(nonatomic, assign)NSInteger alertsPage;
@property(nonatomic, assign)BOOL isCell;
@property(nonatomic, strong)NSMutableArray* dataSource1;
@property(nonatomic, strong)NSMutableArray* dataSource2;
@property(nonatomic, strong)NSMutableArray* dataSource3;

@end

@implementation NewsPage

static NSString* newsCell = @"Cell1";
static NSString* alertsCell = @"Cell2";
static NSString *viewIde = @"Heard1";

- (void)viewDidLoad
{
    [super viewDidLoad];
    _newPage = 0;
    _alertsPage = 0;
    _isCell = NO;
    _dataSource1 = [NSMutableArray array];
    _dataSource2 = [NSMutableArray array];
    _dataSource3 = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addTimer];
    [self createNavigation];
    [self downData2];
    [self downData1];
}

- (void)downData1
{
    NSLog(@"%d", _isCell);
    [BaseService getRequest:NewsPageUrl1 :nil finshedBlock:^(id dataString)
    {
        [_dataSource1 removeAllObjects];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
        _dataSource1 = [dic objectForKey:@"data"];
        [_newsPageCollectionView.header endRefreshing];
    } ErrorBlock:^(NSError *error)
    {
        NSLog(@"请求失败！");
    }];
}
- (void)downData2
{
    NSLog(@"%d", _isCell);
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/article/list/v2/0/2/%ld.json", (long)_newPage] :nil finshedBlock:^(id dataString)
     {
         if (_newPage == 0) {
             [_dataSource2 removeAllObjects];
             NSArray* arr=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSource2 addObjectsFromArray:arr];
             if (_newsPageCollectionView == nil) {
                 [self createCollectionView];
             }
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
             [_newsPageCollectionView registerClass:[HeardCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Heard1"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.header endRefreshing];
             NSLog(@"_dataSource2 == %ld", _dataSource2.count);
         }else
         {
             NSArray* arr1 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSource2 addObjectsFromArray:arr1];
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.footer endRefreshing];
             NSLog(@"_dataSource2 == %ld", _dataSource2.count);
         }
     } ErrorBlock:^(NSError *error)
     {
         NSLog(@"请求失败！");
     }];
}
- (void)downData3
{
    NSLog(@"%d", _isCell);
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/message/list/%ld.json", (long)_alertsPage] :nil finshedBlock:^(id dataString)
     {
         if (_alertsPage == 0) {
             [_dataSource3 removeAllObjects];
             NSArray* arr=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSource3 addObjectsFromArray:arr];
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"AlertsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell2"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.header endRefreshing];
             NSLog(@"_dataSource3 == %ld", _dataSource3.count);
         }else
         {
             NSArray* arr1 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSource3 addObjectsFromArray:arr1];
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"AlertsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell2"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.footer endRefreshing];
             NSLog(@"_dataSource3 == %ld", _dataSource3.count);
         }
     } ErrorBlock:^(NSError *error)
     {
         NSLog(@"请求失败！");
     }];
}
#pragma mark-创建UICollectionView
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //  设置网格布局方向(垂直)
    [layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    layOut.minimumLineSpacing =3;//横向的最小间隔 (可以直接调节)
    layOut.minimumInteritemSpacing = 0; //纵向的最小间隔(结合UIEageInsets调节)
    layOut.headerReferenceSize = CGSizeMake(0, height1 / 4);
    //初始化集合视图，传入布局对象
    _newsPageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 67, width1, (height1-(height1/3+100)-44)+(height1/3+40)) collectionViewLayout:layOut];
    _newsPageCollectionView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    //设置数据源和代理
    _newsPageCollectionView.delegate = self;
    _newsPageCollectionView.dataSource = self;
    [self.view addSubview:_newsPageCollectionView];
    
    [_newsPageCollectionView addLegendHeaderWithRefreshingBlock:^{
        [_newsPageCollectionView.header beginRefreshing];
        [self downData1];
        _newPage = 0;
        _alertsPage = 0;
        if (_isCell == NO) {
            [self downData2];
        }else
        {
            [self downData3];
        }
    }];
    [_newsPageCollectionView addLegendFooterWithRefreshingBlock:^{
        [_newsPageCollectionView.footer beginRefreshing];
        _newPage++;
        _alertsPage++;
        if (_isCell == NO) {
            [self downData2];
        }else
        {
            [self downData3];
        }
    }];
}
#pragma mark - UICollectionViewDelegate
//选中某一个item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"select section:%ld item:%ld",(long)indexPath.section,(long)indexPath.item);
    if (_isCell == NO) {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [_dataSource2[indexPath.section] objectForKey:@"page_url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
#pragma mark - UICollectionViewDataSource
//集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_isCell == NO) {
        return _dataSource2.count;
    }else
    {
        return _dataSource3.count;
    }
}
//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isCell == NO) {
        NewsCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:newsCell forIndexPath:indexPath];
        cell1.btn1.backgroundColor = [UIColor redColor];
        [cell1.btn1.layer setMasksToBounds:YES];
        [cell1.btn1.layer setCornerRadius:5.0];
        cell1.label1.text = [_dataSource2[indexPath.section] objectForKey:@"title"];
        cell1.btn2.backgroundColor = [UIColor orangeColor];
        [cell1.btn2.layer setMasksToBounds:YES];
        [cell1.btn2.layer setCornerRadius:15];
        [cell1.btn3 setTitle:[_dataSource2[indexPath.section] objectForKey:@"nickname"]forState:UIControlStateNormal];
        return cell1;
    }else
    {
        AlertsCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:alertsCell forIndexPath:indexPath];
        cell1.btn1.backgroundColor = [UIColor redColor];
        [cell1.imageView1.layer setMasksToBounds:YES];
        [cell1.imageView1.layer setCornerRadius:15];
        cell1.label1.text = [_dataSource3[indexPath.section] objectForKey:@"nickname"];
        cell1.label3.text = [_dataSource3[indexPath.section] objectForKey:@"content"];
        return cell1;
    }
}
//collectionView对header和footer会自动创建,我们需要对header和footer赋不同的值
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     //从重用队列中取header和footerview 取不到会自动创建
    HeardCollectionReusableView *view1 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewIde forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (_scrollView == nil) {
            [self createScrollView];
        }
        [view1 addSubview:_heardView];
    }
    return view1;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(width1, height1/3+40);
    }
    else
    {
        return CGSizeMake(0, 0);
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isCell == NO) {
        return CGSizeMake(width1,height1/5);
    }else
    {
        return CGSizeMake(width1,height1/3);
    }
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, height1/64, 0);
}
#pragma mark - 滚动视图
- (void)createScrollView{
    _heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/3+40)];
    [self.view addSubview:_heardView];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/3)];
    [_heardView addSubview:_scrollView];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, (height1/3)-30, width1, 30)];
    _label.textColor=[UIColor whiteColor];
    _label.backgroundColor=[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:0.7];
    _label.font = [UIFont boldSystemFontOfSize:12];
    [_heardView addSubview:_label];
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
    [_heardView addSubview:_pageController];
    [_pageController addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    UIImageView* u5Normal1 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/2/15, (height1/3)+5, width1/2-width1/2/15, 32)];
    u5Normal1.image = [UIImage imageNamed:@"u5_normal"];
    [_heardView addSubview:u5Normal1];
    _u5Normal1Label = [[UILabel alloc]initWithFrame:CGRectMake(width1/2/15, (height1/3)+7, width1/2-width1/2/15, 29)];
    _u5Normal1Label.text = @"新闻";
    _u5Normal1Label.textColor = [UIColor whiteColor];
    _u5Normal1Label.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    _u5Normal1Label.font = [UIFont boldSystemFontOfSize:14];
    _u5Normal1Label.textAlignment = NSTextAlignmentCenter;
    _u5Normal1Label.layer.masksToBounds = YES;//必须设置
    _u5Normal1Label.layer.cornerRadius = 3;//设置圆角的弧度，等于label的高的一半的时候，是个圆
    _u5Normal1Label.layer.borderColor =[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;//边框颜色
    _u5Normal1Label.layer.borderWidth = 1;//边框的宽度
    _tapleftLaebl = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapleftLaeblAction)];
    _tapleftLaebl.numberOfTapsRequired = 1;
    _tapleftLaebl.numberOfTouchesRequired = 1;
    _u5Normal1Label.userInteractionEnabled = YES;
    [_u5Normal1Label addGestureRecognizer:_tapleftLaebl];
    [_heardView addSubview:_u5Normal1Label];
    
    UIImageView* u5Normal2 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/2/15+width1/2-width1/2/15-4, (height1/3)+5, width1/2-width1/2/15, 32)];
    u5Normal2.image = [UIImage imageNamed:@"u5_normal"];
    [_heardView addSubview:u5Normal2];
    _u5Normal2Label = [[UILabel alloc]initWithFrame:CGRectMake(width1/2/15+width1/2-width1/2/15-4, (height1/3)+7, width1/2-width1/2/15, 29)];
    _u5Normal2Label.text = @"快讯";
    _u5Normal2Label.textColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    _u5Normal2Label.font = [UIFont boldSystemFontOfSize:14];
    _u5Normal2Label.textAlignment = NSTextAlignmentCenter;
    _u5Normal2Label.layer.masksToBounds = YES;//必须设置
    _u5Normal2Label.layer.cornerRadius = 3;//设置圆角的弧度，等于label的高的一半的时候，是个圆
    _u5Normal2Label.layer.borderColor =[UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1].CGColor;//边框颜色
    _u5Normal2Label.layer.borderWidth = 1;//边框的宽度
    _tapRightLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRightLabelAction)];
    _tapRightLabel.numberOfTapsRequired = 1;
    _tapRightLabel.numberOfTouchesRequired = 1;
    _u5Normal2Label.userInteractionEnabled = YES;
    [_u5Normal2Label addGestureRecognizer:_tapRightLabel];
    [_heardView addSubview:_u5Normal2Label];
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
        _label.text=[_dataSource1[_pageController.currentPage] objectForKey:@"title"];
    } else if (_pageController.currentPage < _pageController.numberOfPages - 1) {
        _pageController.currentPage++;
        _label.text=[_dataSource1[_pageController.currentPage] objectForKey:@"title"];
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

-(void)pageAction:(UIPageControl*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset=CGPointMake(width1*(_pageController.currentPage), 0);
        _label.text=[_dataSource1[_pageController.currentPage] objectForKey:@"title"];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView) {
        CGPoint point=scrollView.contentOffset;
        NSInteger page=point.x/width1;
        NSLog(@"%f",point.x/width1);
        _pageController.currentPage=page;
        _label.text=[_dataSource1[page] objectForKey:@"title"];
    }
}

-(void)tapAtion1
{
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSource1[0] objectForKey:@"object_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)tapAtion2
{
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSource1[1] objectForKey:@"object_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)tapAtion3
{
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSource1[2] objectForKey:@"object_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)tapAtion4
{
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSource1[3] objectForKey:@"object_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)tapAtion5
{
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSource1[4] objectForKey:@"object_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)tapleftLaeblAction
{
    NSLog(@"左边被点击！");
    _u5Normal1Label.textColor = [UIColor whiteColor];
    _u5Normal1Label.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    _u5Normal2Label.backgroundColor = [UIColor whiteColor];
    _u5Normal2Label.textColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    
    _isCell = NO;
    [self downData2];
}
- (void)tapRightLabelAction
{
    NSLog(@"右边被点击！");
    _u5Normal2Label.textColor = [UIColor whiteColor];
    _u5Normal2Label.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    _u5Normal1Label.backgroundColor = [UIColor whiteColor];
    _u5Normal1Label.textColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    
    _isCell = YES;
    [self downData3];
}
#pragma mark-创建自定义导航栏
- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 44)];
    [self.view addSubview:view];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"动漫资讯";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelTitle];
    
    UIButton* imgClassifyIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    imgClassifyIcon.frame = CGRectMake(width1-45, 10, 37, 26);
    [imgClassifyIcon setImage:[UIImage imageNamed:@"img_classify_icon"] forState:UIControlStateNormal];
    [imgClassifyIcon addTarget:self action:@selector(imgClassifyIcon1:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:imgClassifyIcon];
    
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [view addSubview:navigationBarBottomLineImage];
}

- (void)imgClassifyIcon1:(UIButton* )sender
{
    self.hidesBottomBarWhenPushed = YES;
    ClassificationPage* classificationPage = [[ClassificationPage alloc]init];
    [self.navigationController pushViewController:classificationPage animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
