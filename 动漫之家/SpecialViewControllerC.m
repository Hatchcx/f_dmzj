//
//  SpecialViewControllerC.m
//  动漫之家
//
//  Created by 黄启明 on 2017/6/21.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "SpecialViewControllerC.h"

#import "Dfine.h"
#import "UrlDfine.h"
#import "ProjectViewCell.h"
#import "BaseService.h"
#import "TypeTwoWeb.h"
#import "TypeThreeWeb.h"
#import "MJRefresh.h"


@interface SpecialViewControllerC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView* collectionView;
@property(nonatomic, strong)NSMutableArray* ararar;
@property(nonatomic, assign)NSInteger page;

@end

@implementation SpecialViewControllerC

static NSString *cellIde = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ararar = [[NSMutableArray alloc]init];
    _page = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    UIView* viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 47)];
    [self.view addSubview:viewTitle];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width1, 24)];
    labelTitle.text = @"专题";
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
    
    [self download1];
}

//  网络请求-专题页面
- (void)download1
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/subject/0/%ld.json", _page] :nil finshedBlock:^(id dataString) {
        if (_page == 0) {
            [_ararar removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_ararar addObjectsFromArray:a];
            if (_collectionView == nil) {
                [self createCollectionView];
            }
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_collectionView registerNib:[UINib nibWithNibName:@"ProjectViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
            
            [_collectionView reloadData];
            [_collectionView.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_ararar addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_collectionView registerNib:[UINib nibWithNibName:@"ProjectViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
            [_collectionView reloadData];
            [_collectionView.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
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
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,67,width1,height1-67) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    //设置数据源和代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView addLegendHeaderWithRefreshingBlock:^{
        [_collectionView.header beginRefreshing];
        _page = 0;
        [self download1];
    }];
    [_collectionView addLegendFooterWithRefreshingBlock:^{
        [_collectionView.footer beginRefreshing];
        _page++;
        [self download1];
    }];
    [self.view addSubview:_collectionView];
}

- (void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDelegate
//选中某一个item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"select section:%ld item:%ld",(long)indexPath.section,(long)indexPath.item);
}
#pragma mark - UICollectionViewDataSource
//集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _ararar.count;
}
//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //collectionView 会自动创建cell，或者自动从重用队列中取cell
    //indexPath.item
    ProjectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    cell.label1.text = [_ararar[indexPath.section]objectForKey:@"title"];
    cell.btn.tag = 500+indexPath.section;
    [cell.btn.layer setMasksToBounds:YES];
    [cell.btn.layer setCornerRadius:5.0];
    [cell.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%ld", 500+indexPath.section);
    return cell;
}
//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //每个item也可以调成不同的大小
    return CGSizeMake(width1,height1/3);
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(height1/64,0, 0, 0);
}

- (void)btnAction:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    if ((sender.tag-500)%10 == 0) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 1) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 2) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 3) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 4) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 5) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 6) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 7) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 8) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }else if ((sender.tag-500)%10 == 9) {
        NSInteger num1 = sender.tag-500;
        NSInteger typeNum = [[_ararar[num1]objectForKey:@"page_type"] integerValue];
        if (typeNum == 2)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeTwoWeb* typeTwoWeb = [[TypeTwoWeb alloc]init];
            typeTwoWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeTwoWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeTwoWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }else if(typeNum == 3)
        {
            self.hidesBottomBarWhenPushed = YES;
            TypeThreeWeb* typeThreeWeb = [[TypeThreeWeb alloc]init];
            typeThreeWeb.strUrl = [_ararar[num1]objectForKey:@"page_url"];
            typeThreeWeb.labelTitleStr = [_ararar[num1]objectForKey:@"title"];
            [self.navigationController pushViewController:typeThreeWeb animated:YES];
            //self.hidesBottomBarWhenPushed = NO;
        }
    }
}
@end
