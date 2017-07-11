//
//  ClassificationPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/9.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ClassificationPage.h"
#import "Dfine.h"
#import "MJRefresh.h"
#import "BaseService.h"
#import "RecommendWeb.h"
#import "NewsCollectionViewCell.h"

@interface ClassificationPage ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView* newsPageCollectionView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray* dataSourceNews;

@end

static NSString* newsCell = @"Cell1";

@implementation ClassificationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _page = 0;
    _dataSourceNews = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"新闻分类";
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
    
    UIButton* imgClassifyIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    imgClassifyIcon.frame = CGRectMake(width1-45, 10, 37, 26);
    [imgClassifyIcon setImage:[UIImage imageNamed:@"newsMenu"] forState:UIControlStateNormal];
    [imgClassifyIcon addTarget:self action:@selector(imgClassifyIcon:) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:imgClassifyIcon];
    
    [self createCollectionView];
    [self downData2];
}

- (void)downData2
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/article/list/v2/0/2/%ld.json", (long)_page] :nil finshedBlock:^(id dataString)
     {
         if (_page == 0) {
             [_dataSourceNews removeAllObjects];
             NSArray* arr=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSourceNews addObjectsFromArray:arr];
             if (_newsPageCollectionView == nil) {
                 [self createCollectionView];
             }
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.header endRefreshing];
             NSLog(@"_dataSource2 == %ld", _dataSourceNews.count);
         }else
         {
             NSArray* arr1 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
             [_dataSourceNews addObjectsFromArray:arr1];
             [_newsPageCollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
             [_newsPageCollectionView reloadData];
             [_newsPageCollectionView.footer endRefreshing];
             NSLog(@"_dataSource2 == %ld", _dataSourceNews.count);
         }
     } ErrorBlock:^(NSError *error)
     {
         NSLog(@"请求失败！");
     }];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //  设置网格布局方向(垂直)
    [layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    layOut.minimumLineSpacing =3;//横向的最小间隔 (可以直接调节)
    layOut.minimumInteritemSpacing = 0; //纵向的最小间隔(结合UIEageInsets调节)
    //初始化集合视图，传入布局对象
    _newsPageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 67, width1, (height1-(height1/3+100)-44)+(height1/3+84)) collectionViewLayout:layOut];
    _newsPageCollectionView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    //设置数据源和代理
    _newsPageCollectionView.delegate = self;
    _newsPageCollectionView.dataSource = self;
    [self.view addSubview:_newsPageCollectionView];
    
    [_newsPageCollectionView addLegendHeaderWithRefreshingBlock:^{
        [_newsPageCollectionView.header beginRefreshing];
        _page=0;
        [self downData2];
    }];
    [_newsPageCollectionView addLegendFooterWithRefreshingBlock:^{
        [_newsPageCollectionView.footer beginRefreshing];
        _page++;
        [self downData2];
    }];
}
#pragma mark - UICollectionViewDelegate
//选中某一个item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"select section:%ld item:%ld",(long)indexPath.section,(long)indexPath.item);
    self.hidesBottomBarWhenPushed = YES;
    RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
    recommendWeb.strUrl = [_dataSourceNews[indexPath.section] objectForKey:@"page_url"];
    [self.navigationController pushViewController:recommendWeb animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
}
#pragma mark - UICollectionViewDataSource
//集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSourceNews.count;
}
//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
//创建单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        NewsCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:newsCell forIndexPath:indexPath];
        cell1.btn1.backgroundColor = [UIColor redColor];
        [cell1.btn1.layer setMasksToBounds:YES];
        [cell1.btn1.layer setCornerRadius:5.0];
        cell1.label1.text = [_dataSourceNews[indexPath.section] objectForKey:@"title"];
        cell1.btn2.backgroundColor = [UIColor orangeColor];
        [cell1.btn2.layer setMasksToBounds:YES];
        [cell1.btn2.layer setCornerRadius:15];
        [cell1.btn3 setTitle:[_dataSourceNews[indexPath.section] objectForKey:@"nickname"]forState:UIControlStateNormal];
        return cell1;
}
//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(width1,height1/5);
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, height1/64, 0);
}
- (void)imgClassifyIcon:(UIButton* )sender
{
    NSLog(@"被点击");
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
