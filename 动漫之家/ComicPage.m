//
//  ComicPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ComicPage.h"
#import "Dfine.h"
#import "UrlDfine.h"
#import "BaseService.h"
#import "RecommendWeb.h"
#import "ShareWeb.h"
#import "DownloadWeb.h"
#import "ProjectWeb.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "SpecialViewControllerC.h"
#import "ListAllAnimationCell.h"
#import "ListOriginalCartoonCell.h"
#import "ListDubbingCartoonCell.h"
#import "GridAllAnimationCell.h"
#import "GridOriginalCartoonCell.h"
#import "SpecialViewS.h"
#import "Masonry.h"

@interface ComicPage ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//  推荐页面
@property(nonatomic, strong)UIScrollView* recommendedSV;
@property(nonatomic, strong)UIView* recommendView1;
@property(nonatomic, strong)UIView* recommendView2;
@property(nonatomic, strong)UIView* recommendView3;
@property(nonatomic, strong)UIView* recommendView4;
@property(nonatomic, strong)UIView* recommendView5;
@property(nonatomic, strong)UIView* recommendView6;
@property(nonatomic, strong)UIView* recommendView7;
@property(nonatomic, strong)UIView* recommendView8;
@property(nonatomic, strong)UIView* recommendView9;
@property(nonatomic, strong)UIView* recommendView10;
@property (nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)UIPageControl* pageController;
@property(nonatomic, strong)UILabel* label;
@property(nonatomic, strong)UITapGestureRecognizer* tap1;
@property(nonatomic, strong)UITapGestureRecognizer* tap2;
@property(nonatomic, strong)UITapGestureRecognizer* tap3;
@property(nonatomic, strong)UITapGestureRecognizer* tap4;
@property(nonatomic, strong)UITapGestureRecognizer* tap5;
@property(nonatomic, strong)NSArray* arr1;
@property(nonatomic, strong)NSDictionary* dic1;
@property(nonatomic, strong)NSDictionary* dic2;
@property(nonatomic, strong)NSDictionary* dic3;
@property(nonatomic, assign)BOOL isBtn6;
@property(nonatomic, assign)BOOL isBtn8;
@property(nonatomic, strong)UIImageView* navigationBarIndicatorView;
@property(nonatomic, strong)SpecialViewControllerC* specialVCC;

//  更新页面
@property(nonatomic, strong)UIView* updateView;
@property(nonatomic, strong)NSMutableArray* listAllAnimationArr;
@property(nonatomic, strong)NSMutableArray* listOriginalCartoonArr;
@property(nonatomic, strong)NSMutableArray* listDubbingCartoonsArr;
@property(nonatomic, assign)NSInteger listAllAnimationPage;
@property(nonatomic, assign)NSInteger listOriginalCartoonPage;
@property(nonatomic, assign)NSInteger listDubbingCartoonsPage;
@property(nonatomic, strong)NSMutableArray* gridAllAnimationArr;
@property(nonatomic, strong)NSMutableArray* gridOriginalCartoonArr;
@property(nonatomic, strong)NSMutableArray* gridDubbingCartoonsArr;
@property(nonatomic, assign)NSInteger gridAllAnimationPage;
@property(nonatomic, assign)NSInteger gridOriginalCartoonPage;
@property(nonatomic, assign)NSInteger gridDubbingCartoonsPage;
@property(nonatomic, strong)UICollectionView* listAllAnimationCV;
@property(nonatomic, strong)UIButton* chooseViwe;
@property(nonatomic, strong)UIView* chooseViewSmall;
@property(nonatomic, assign)BOOL isChoose;
@property(nonatomic, assign)BOOL isGrid;
@property(nonatomic, assign)NSInteger chooseNum;

@property(nonatomic, strong)UIView* view3;

@property(nonatomic, strong)UIView* view4;

@property(nonatomic, strong)SpecialViewS* specialVS;

@end

@implementation ComicPage

static NSString *listAllAnimation1 = @"Cell1";
static NSString *listOriginalCartoon1 = @"Cell2";
static NSString *listDubbingCartoon1 = @"Cell3";
static NSString *GridAllAnimation1 = @"Cell4";
static NSString *GridOriginalCartoon1 = @"Cell5";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isBtn6 = NO;
    _isBtn8 = NO;
    _isChoose = NO;
    _isGrid = NO;
    _chooseNum = 1;
    _listAllAnimationPage = 0;
    _listOriginalCartoonPage = 0;
    _listDubbingCartoonsPage = 0;
    _gridAllAnimationPage = 0;
    _gridOriginalCartoonPage = 0;
    _gridDubbingCartoonsPage = 0;
    _specialVCC = [[SpecialViewControllerC alloc]init];
    _listAllAnimationArr = [NSMutableArray array];
    _listOriginalCartoonArr = [NSMutableArray array];
    _listDubbingCartoonsArr = [NSMutableArray array];
    _gridAllAnimationArr = [NSMutableArray array];
    _gridOriginalCartoonArr = [NSMutableArray array];
    _gridDubbingCartoonsArr = [NSMutableArray array];
    UIImageView* navigationBarBottomLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, width1, 3)];
    navigationBarBottomLineImage.image = [UIImage imageNamed:@"NavigationBarBottomLine"];
    [self.view addSubview:navigationBarBottomLineImage];
    [self addTimer];
    [self createNavigation];
    [self createRecommended];
    [self download1];
    [self download2];
}

//--------------------------------------  推荐页面  ----------------------------------------//
#pragma mark-推荐页面
//创建推荐页面视图
- (void)createRecommended
{
    _recommendedSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 67, width1, height1-67-44)];
    _recommendedSV.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    _recommendedSV.contentSize=CGSizeMake(width1, height1/64*11+height1/3*2+height1/2.8*2+height1/2.4*3+height1/1.52*3);
    //_recommendedSV.bounces = NO;
    //_recommendedSV.scrollsToTop = YES;
    [_recommendedSV addLegendHeaderWithRefreshingBlock:^{
        [_recommendedSV.header beginRefreshing];
        _isBtn6 = NO;
        _isBtn8 = NO;
        [self download1];
        [self download2];
    }];
    [self.view addSubview:_recommendedSV];
    [self createScrollView];
}

//  网络请求-推荐页面
- (void)download1
{
    [BaseService getRequest:ComicPageUrl1 :nil finshedBlock:^(id dataString) {
         _arr1 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
        [self take1];
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
//  网络请求-推荐页面-猜你喜欢
- (void)download2
{
    [BaseService getRequest:ComicPageUrl2 :nil finshedBlock:^(id dataString) {
        _dic1 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
        [self take2];
        [_recommendedSV.header endRefreshing];
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
//  网络请求-推荐页面-国漫也精彩
- (void)download3
{
    [BaseService getRequest:ComicPageUrl3 :nil finshedBlock:^(id dataString) {
        _dic2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
        [self take3];
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
//  网络请求-推荐页面-热门连载
- (void)download4
{
    [BaseService getRequest:ComicPageUrl4 :nil finshedBlock:^(id dataString) {
        _dic3 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
        [self take4];
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
//  请求数据成功后-推荐页面
- (void)take1
{
    /*--------------------------------1--------------------------------*/
    _label.text = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"title"];
    /*--------------------------------2--------------------------------*/
    for (int i = 0; i < 3; i++) {
        UILabel* label = [self.view viewWithTag:310+i];
        label.text = [[_arr1[1] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:410+i];
        label1.text = [[_arr1[1] objectForKey:@"data"][i] objectForKey:@"sub_title"];
    }
    /*--------------------------------3--------------------------------*/
    for (int i = 0; i < 4; i++) {
        UILabel* label = [self.view viewWithTag:320+i];
        label.text = [[_arr1[2] objectForKey:@"data"][i] objectForKey:@"title"];
    }
    /*--------------------------------5--------------------------------*/
    for (int i = 0; i < 3; i++) {
        UILabel* label = [self.view viewWithTag:340+i];
        label.text = [[_arr1[3] objectForKey:@"data"][i] objectForKey:@"title"];
    }
    /*--------------------------------6--------------------------------*/
    for (int i = 0; i < 6; i++) {
        UILabel* label = [self.view viewWithTag:350+i];
        label.text = [[_arr1[4] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:450+i];
        label1.text = [[_arr1[4] objectForKey:@"data"][i] objectForKey:@"sub_title"];
    }
    /*--------------------------------7--------------------------------*/
    for (int i = 0; i < 4; i++) {
        UILabel* label = [self.view viewWithTag:360+i];
        label.text = [[_arr1[5] objectForKey:@"data"][i] objectForKey:@"title"];
    }
    /*--------------------------------8--------------------------------*/
    for (int i = 0; i < 6; i++) {
        UILabel* label = [self.view viewWithTag:370+i];
        label.text = [[_arr1[6] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:470+i];
        label1.text = [[_arr1[6] objectForKey:@"data"][i] objectForKey:@"sub_title"];
    }
    /*--------------------------------9--------------------------------*/
    for (int i = 0; i < 4; i++) {
        UILabel* label = [self.view viewWithTag:380+i];
        label.text = [[_arr1[7] objectForKey:@"data"][i] objectForKey:@"title"];
    }
    /*--------------------------------10--------------------------------*/
    for (int i = 0; i < 6; i++) {
        UILabel* label = [self.view viewWithTag:390+i];
        label.text = [[_arr1[8] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:490+i];
        label1.text = [[_arr1[8] objectForKey:@"data"][i] objectForKey:@"authors"];
    }
}
//  请求数据成功后-推荐页面-猜你喜欢
- (void)take2
{
    /*--------------------------------4--------------------------------*/
    for (int i = 0; i < 3; i++) {
        UILabel* label = [self.view viewWithTag:330+i];
        label.text = [[[_dic1 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:430+i];
        label1.text = [[[_dic1 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"authors"];
    }
}
//  请求数据成功后-推荐页面-国漫也精彩
- (void)take3
{
    /*--------------------------------6--------------------------------*/
    for (int i = 0; i < 6; i++) {
        UILabel* label = [self.view viewWithTag:350+i];
        label.text = [[[_dic2 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:450+i];
        label1.text = [[[_dic2 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"sub_title"];
    }
}
//  请求数据成功后-推荐页面-热门连载
- (void)take4
{
     /*--------------------------------8--------------------------------*/
    for (int i = 0; i < 6; i++) {
        UILabel* label = [self.view viewWithTag:370+i];
        label.text = [[[_dic3 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"title"];
        UILabel* label1 = [self.view viewWithTag:470+i];
        label1.text = [[[_dic3 objectForKey:@"data"] objectForKey:@"data"][i] objectForKey:@"sub_title"];
    }
}

- (void)createScrollView{
    
    _recommendView1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/3)];
    [_recommendedSV addSubview:_recommendView1];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/3)];
    _scrollView.contentSize = CGSizeMake(width1*5, height1/4);
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [_recommendView1 addSubview:_scrollView];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, (height1/3)-30, width1, 30)];
    _label.textColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:255/255.0 alpha:0.7];
    _label.font = [UIFont boldSystemFontOfSize:12];
    [_recommendView1 addSubview:_label];
    NSArray* arrWithImage = @[@"-925760583",@"1084058371",@"1199381870",@"937569063",@"-1802506844"];
    for (int i = 0; i < 5; i++) {
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width1*i, 0, width1, height1/3)];
        imageView.image = [UIImage imageNamed:arrWithImage[i]];
        //imageView sd_setImageWithURL:[NSURL URLWithString:urlStr];
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
    _pageController=[[UIPageControl alloc]initWithFrame:CGRectMake((width1/3)*2, (height1/3)-30, 100, 30)];
    _pageController.backgroundColor=[UIColor clearColor];
    _pageController.numberOfPages=5;
    _pageController.currentPage=0;
    [_recommendView1 addSubview:_pageController];
    [_pageController addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    /*--------------------------------2--------------------------------*/
    _recommendView2 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64, width1, height1/2.8)];
    _recommendView2.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView2];
    UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView2.image = [UIImage imageNamed:@"HeaderIcon_47"];
    [_recommendView2 addSubview:imageView2];
    UILabel* label21 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/5, height1/19.20-width1/72)];
    label21.text = @"近期必看";
    label21.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72, width1/3.28, height1/4.4);
        btn.tag = 210+i;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5.0];
        [btn addTarget:self action:@selector(recommendBtn2:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView2 addSubview:btn];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2, width1/3.28, height1/35)];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 310+i;
        [_recommendView2 addSubview:label];
        UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+4+height1/35, width1/3.28, height1/35)];
        label1.font = [UIFont systemFontOfSize:11];
        label1.tag = 410+i;
        [_recommendView2 addSubview:label1];
    }
    [_recommendView2 addSubview:label21];
    
    /*--------------------------------3--------------------------------*/
    _recommendView3=[[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64, width1, height1/2.4)];
    _recommendView3.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView3];
    UIImageView* imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView3.image = [UIImage imageNamed:@"HeaderIcon_48"];
    [_recommendView3 addSubview:imageView3];
    UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(width1-width1/72*2-width1/33.75, width1/72, width1/33.75, width1/33.75*1.75);
    [btn3 setImage:[UIImage imageNamed:@"RecommendMore"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
    [_recommendView3 addSubview:btn3];
    UILabel* label31 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/5, height1/19.20-width1/72)];
    label31.text = @"火热专题";
    label31.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/7.38+width1/72*2+height1/35+2), width1/2.15, height1/7.38);
            btn.tag = 220+(i*2)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn3:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView3 addSubview:btn];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/7.38+i*(height1/35+height1/7.38+2+width1/72*2), width1/2.15, height1/35)];
            label1.tag = 320+(i*2)+j;
            label1.font = [UIFont systemFontOfSize:13];
            [_recommendView3 addSubview:label1];
        }
    }
    [_recommendView3 addSubview:label31];
    
    /*--------------------------------4--------------------------------*/
    _recommendView4 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64, width1, height1/2.8)];
    _recommendView4.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView4];
    UIImageView* imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView4.image = [UIImage imageNamed:@"HeaderIcon_50"];
    [_recommendView4 addSubview:imageView4];
    UIButton* btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(width1-width1/72*2-width1/20, width1/72, width1/20, width1/20);
    [btn4 setImage:[UIImage imageNamed:@"RecommendRefresh"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4) forControlEvents:UIControlEventTouchUpInside];
    [_recommendView4 addSubview:btn4];
    UILabel* label41 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/5, height1/19.20-width1/72)];
    label41.text = @"猜你喜欢";
    label41.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72, width1/3.28, height1/4.4);
        btn.backgroundColor = [UIColor redColor];
        btn.tag = 230+i;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5.0];
        [btn addTarget:self action:@selector(recommendBtn4:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView4 addSubview:btn];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2, width1/3.28, height1/35)];
        label.tag = 330+i;
        label.font = [UIFont systemFontOfSize:13];
        [_recommendView4 addSubview:label];
        UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+4+height1/35, width1/3.28, height1/35)];
        label1.tag = 430+i;
        label1.font = [UIFont systemFontOfSize:11];
        [_recommendView4 addSubview:label1];
    }
    [_recommendView4 addSubview:label41];
    
    /*--------------------------------5--------------------------------*/
    _recommendView5 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64, width1, height1/3)];
    _recommendView5.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView5];
    UIImageView* imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView5.image = [UIImage imageNamed:@"HeaderIcon_51"];
    [_recommendView5 addSubview:imageView5];
    UILabel* label5 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/2, height1/19.20-width1/72)];
    label5.text = @"大师级作者怎能不看";
    label5.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72, width1/3.28, height1/4.4);
        btn.tag = 240+i;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5.0];
        [btn addTarget:self action:@selector(recommendBtn5:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView5 addSubview:btn];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+i*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2, width1/3.28, height1/35)];
        label.tag = 340+i;
        label.font = [UIFont systemFontOfSize:13];
        [_recommendView5 addSubview:label];
    }
    [_recommendView5 addSubview:label5];
    
    /*--------------------------------6--------------------------------*/
    _recommendView6 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64+height1/3+height1/64, width1, height1/1.52)];
    _recommendView6.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView6];
    UIImageView* imageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView6.image = [UIImage imageNamed:@"HeaderIcon_52"];
    [_recommendView6 addSubview:imageView6];
    UIButton* btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(width1-width1/72*2-width1/20, width1/72, width1/20, width1/20);
    [btn6 setImage:[UIImage imageNamed:@"RecommendRefresh"] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(btn6) forControlEvents:UIControlEventTouchUpInside];
    [_recommendView6 addSubview:btn6];
    UILabel* label6 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/4, height1/19.20-width1/72)];
    label6.text = @"国漫也精彩";
    label6.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/35+2+height1/35+height1/4.4+width1/72*2), width1/3.28, height1/4.4);
            btn.tag = 250+(i*3)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn6:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView6 addSubview:btn];
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label.tag = 350+(i*3)+j;
            label.font = [UIFont systemFontOfSize:13];
            [_recommendView6 addSubview:label];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+height1/35+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label1.tag = 450+(i*3)+j;
            label1.font = [UIFont systemFontOfSize:11];
            [_recommendView6 addSubview:label1];
        }
    }
    [_recommendView6 addSubview:label6];
    
    /*--------------------------------7--------------------------------*/
    _recommendView7 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64+height1/3+height1/64+height1/1.52+height1/64, width1, height1/2.4)];
    _recommendView7.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView7];
    UIImageView* imageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView7.image = [UIImage imageNamed:@"HeaderIcon_53"];
    [_recommendView7 addSubview:imageView7];
    UILabel* label7 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/4, height1/19.20-width1/72)];
    label7.text = @"美漫大事件";
    label7.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/7.38+width1/72*2+height1/35+2), width1/2.15, height1/7.38);
            btn.tag = 260+(i*2)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn7:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView7 addSubview:btn];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/7.38+i*(height1/35+height1/7.38+2+width1/72*2), width1/3.28, height1/35)];
            label1.tag = 360+(i*2)+j;
            label1.font = [UIFont systemFontOfSize:13];
            [_recommendView7 addSubview:label1];
        }
    }
    [_recommendView7 addSubview:label7];
    
    /*--------------------------------8--------------------------------*/
    _recommendView8 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64+height1/3+height1/64+height1/1.52+height1/64+height1/2.4+height1/64, width1, height1/1.52)];
    _recommendView8.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView8];
    UIImageView* imageView8 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView8.image = [UIImage imageNamed:@"HeaderIcon_54"];
    [_recommendView8 addSubview:imageView8];
    UIButton* btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.frame = CGRectMake(width1-width1/72*2-width1/20, width1/72, width1/20, width1/20);
    [btn8 setImage:[UIImage imageNamed:@"RecommendRefresh"] forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(btn8) forControlEvents:UIControlEventTouchUpInside];
    [_recommendView8 addSubview:btn8];
    UILabel* label8 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/4, height1/19.20-width1/72)];
    label8.text = @"热门连载";
    label8.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/35+2+height1/35+height1/4.4+width1/72*2), width1/3.28, height1/4.4);
            btn.tag = 270+(i*3)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn8:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView8 addSubview:btn];
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label.tag = 370+(i*3)+j;
            label.font = [UIFont systemFontOfSize:13];
            [_recommendView8 addSubview:label];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+height1/35+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label1.tag = 470+(i*3)+j;
            label1.font = [UIFont systemFontOfSize:11];
            [_recommendView8 addSubview:label1];
        }
    }
    [_recommendView8 addSubview:label8];
    /*--------------------------------9--------------------------------*/
    _recommendView9 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64+height1/3+height1/64+height1/1.52+height1/64+height1/2.4+height1/64+height1/1.52+height1/64, width1, height1/2.4)];
    _recommendView9.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView9];
    UIImageView* imageView9 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView9.image = [UIImage imageNamed:@"HeaderIcon_55"];
    [_recommendView9 addSubview:imageView9];
    UILabel* label9 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/4, height1/19.20-width1/72)];
    label9.text = @"条漫专区";
    label9.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/7.38+width1/72*2+height1/35+2), width1/2.15, height1/7.38);
            btn.tag = 280+(i*2)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn9:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView9 addSubview:btn];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/2.1+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/7.38+i*(height1/35+height1/7.38+2+width1/72*2), width1/2.15, height1/35)];
            label1.tag = 380+(i*2)+j;
            label1.font = [UIFont systemFontOfSize:13];
            [_recommendView9 addSubview:label1];
        }
    }
    [_recommendView9 addSubview:label9];

    /*--------------------------------10--------------------------------*/
   _recommendView10 = [[UIView alloc]initWithFrame:CGRectMake(0, height1/3+height1/64+height1/2.8+height1/64+height1/2.4+height1/64+height1/2.8+height1/64+height1/3+height1/64+height1/1.52+height1/64+height1/2.4+height1/64+height1/1.52+height1/64+height1/2.4+height1/64, width1, height1/1.52)];
    _recommendView10.backgroundColor = [UIColor whiteColor];
    [_recommendedSV addSubview:_recommendView10];
    UIImageView* imageView10 = [[UIImageView alloc]initWithFrame:CGRectMake(width1/72*2, width1/72, height1/19.20-width1/72, height1/19.20-width1/72)];
    imageView10.image = [UIImage imageNamed:@"HeaderIcon_56"];
    [_recommendView10 addSubview:imageView10];
    UILabel* label10 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72*2+height1/19.20-width1/72+width1/72, width1/72, width1/4, height1/19.20-width1/72)];
    label10.text = @"最新上架";
    label10.font = [UIFont systemFontOfSize:13];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+i*(height1/35+2+height1/35+height1/4.4+width1/72*2), width1/3.28, height1/4.4);
            btn.tag = 290+(i*3)+j;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://xs.dmzj.com/img/webpic/26/wx0309l.jpg"] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0];
            [btn addTarget:self action:@selector(recommendBtn10:) forControlEvents:UIControlEventTouchUpInside];
            [_recommendView10 addSubview:btn];
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label.tag = 390+(i*3)+j;
            label.font = [UIFont systemFontOfSize:13];
            [_recommendView10 addSubview:label];
            UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(width1/72+j*(width1/3.28+width1/72*2), width1/72+height1/19.20-width1/72+width1/72+height1/4.4+height1/35+2+i*(height1/35*2+height1/4.4+2+width1/72*2), width1/3.28, height1/35)];
            label1.tag = 490+(i*3)+j;
            label1.font = [UIFont systemFontOfSize:11];
            [_recommendView10 addSubview:label1];
        }
    }
    [_recommendView10 addSubview:label10];
}

//  添加定时器
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change:) userInfo:nil repeats:YES];
}
//  移除定时器
- (void)removeTimer{
    if (_timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
            _timer=nil;
        }
    }
}
//  定时器响应的方法
- (void)change:(NSTimer *)time{
    if (_pageController.currentPage == _pageController.numberOfPages - 1) {
        _pageController.currentPage = 0;
        _label.text = [[_arr1[0] objectForKey:@"data"][_pageController.currentPage] objectForKey:@"title"];
    } else if (_pageController.currentPage < _pageController.numberOfPages - 1) {
        _pageController.currentPage++;
        _label.text = [[_arr1[0] objectForKey:@"data"][_pageController.currentPage] objectForKey:@"title"];
    }
    _scrollView.contentOffset=CGPointMake(width1*(_pageController.currentPage), 0);
}
//  滚动视图方法，开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
//  滚动视图方法，结束拖拽时执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
//  分页控制器响应方法
-(void)pageAction:(UIPageControl*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset=CGPointMake(width1*(_pageController.currentPage), 0);
        _label.text = [[_arr1[0] objectForKey:@"data"][_pageController.currentPage] objectForKey:@"title"];
    }];
}
//  滚动视图方法，减速时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView) {
        CGPoint point=scrollView.contentOffset;
        NSInteger page=point.x/width1;
        NSLog(@"%f",point.x/width1);
        _pageController.currentPage=page;
        _label.text = [[_arr1[0] objectForKey:@"data"][page] objectForKey:@"title"];
    }
}
//  滚动视图响应方法1
- (void)tapAtion1
{
    NSLog(@"1");
    NSInteger typeNum = [[[_arr1[0] objectForKey:@"data"][0] objectForKey:@"type"] integerValue];
    if (typeNum == 1) {
        self.hidesBottomBarWhenPushed = YES;
        DownloadWeb * downloadWeb = [[DownloadWeb alloc]init];
        downloadWeb.strUrl = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"url"];
        downloadWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"title"];
        [self.navigationController pushViewController:downloadWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 6)
    {
        self.hidesBottomBarWhenPushed = YES;
        ShareWeb* shareWeb = [[ShareWeb alloc]init];
        shareWeb.strUrl = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"url"];
        shareWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"title"];
        [self.navigationController pushViewController:shareWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 7)
    {
        self.hidesBottomBarWhenPushed = YES;
        ProjectWeb* projectWeb = [[ProjectWeb alloc]init];
        projectWeb.strUrl = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"url"];
        [self.navigationController pushViewController:projectWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 5)
    {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [[_arr1[0] objectForKey:@"data"][0] objectForKey:@"url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
//  滚动视图响应方法2
- (void)tapAtion2
{
    NSLog(@"2");
    NSInteger typeNum = [[[_arr1[0] objectForKey:@"data"][1] objectForKey:@"type"] integerValue];
    if (typeNum == 1) {
        self.hidesBottomBarWhenPushed = YES;
        DownloadWeb * downloadWeb = [[DownloadWeb alloc]init];
        downloadWeb.strUrl = [[_arr1[0] objectForKey:@"data"][1] objectForKey:@"url"];
        downloadWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][1] objectForKey:@"title"];
        [self.navigationController pushViewController:downloadWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 6)
    {
        self.hidesBottomBarWhenPushed = YES;
        ShareWeb* shareWeb = [[ShareWeb alloc]init];
        shareWeb.strUrl = [[_arr1[0] objectForKey:@"data"][1] objectForKey:@"url"];
        shareWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][1] objectForKey:@"title"];
        [self.navigationController pushViewController:shareWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 7)
    {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [[_arr1[0] objectForKey:@"data"][1] objectForKey:@"url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
//  滚动视图响应方法3
- (void)tapAtion3
{
    NSLog(@"3");
    NSInteger typeNum = [[[_arr1[0] objectForKey:@"data"][2] objectForKey:@"type"] integerValue];
    if (typeNum == 1) {
        self.hidesBottomBarWhenPushed = YES;
        DownloadWeb * downloadWeb = [[DownloadWeb alloc]init];
        downloadWeb.strUrl = [[_arr1[0] objectForKey:@"data"][2] objectForKey:@"url"];
        downloadWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][2] objectForKey:@"title"];
        [self.navigationController pushViewController:downloadWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 6)
    {
        self.hidesBottomBarWhenPushed = YES;
        ShareWeb* shareWeb = [[ShareWeb alloc]init];
        shareWeb.strUrl = [[_arr1[0] objectForKey:@"data"][2] objectForKey:@"url"];
        shareWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][2] objectForKey:@"title"];
        [self.navigationController pushViewController:shareWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 7)
    {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [[_arr1[0] objectForKey:@"data"][2] objectForKey:@"url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
//  滚动视图响应方法4
- (void)tapAtion4
{
    NSLog(@"4");
    NSInteger typeNum = [[[_arr1[0] objectForKey:@"data"][3] objectForKey:@"type"] integerValue];
    if (typeNum == 1) {
        self.hidesBottomBarWhenPushed = YES;
        DownloadWeb * downloadWeb = [[DownloadWeb alloc]init];
        downloadWeb.strUrl = [[_arr1[0] objectForKey:@"data"][3] objectForKey:@"url"];
        downloadWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][3] objectForKey:@"title"];
        [self.navigationController pushViewController:downloadWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 6)
    {
        self.hidesBottomBarWhenPushed = YES;
        ShareWeb* shareWeb = [[ShareWeb alloc]init];
        shareWeb.strUrl = [[_arr1[0] objectForKey:@"data"][3] objectForKey:@"url"];
        shareWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][3] objectForKey:@"title"];
        [self.navigationController pushViewController:shareWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 7)
    {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [[_arr1[0] objectForKey:@"data"][3] objectForKey:@"url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
//  滚动视图响应方法5
- (void)tapAtion5
{
    NSLog(@"5");
    NSInteger typeNum = [[[_arr1[0] objectForKey:@"data"][4] objectForKey:@"type"] integerValue];
    if (typeNum == 1) {
        self.hidesBottomBarWhenPushed = YES;
        DownloadWeb * downloadWeb = [[DownloadWeb alloc]init];
        downloadWeb.strUrl = [[_arr1[0] objectForKey:@"data"][4] objectForKey:@"url"];
        downloadWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][4] objectForKey:@"title"];
        [self.navigationController pushViewController:downloadWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 6)
    {
        self.hidesBottomBarWhenPushed = YES;
        ShareWeb* shareWeb = [[ShareWeb alloc]init];
        shareWeb.strUrl = [[_arr1[0] objectForKey:@"data"][4] objectForKey:@"url"];
        shareWeb.labelTitleStr = [[_arr1[0] objectForKey:@"data"][4] objectForKey:@"title"];
        [self.navigationController pushViewController:shareWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(typeNum == 7)
    {
        self.hidesBottomBarWhenPushed = YES;
        RecommendWeb* recommendWeb = [[RecommendWeb alloc]init];
        recommendWeb.strUrl = [[_arr1[0] objectForKey:@"data"][4] objectForKey:@"url"];
        [self.navigationController pushViewController:recommendWeb animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
//  视图上按钮响应的方法2
- (void)recommendBtn2:(UIButton* )sender
{
    switch (sender.tag) {
        case 210:
        {
            NSLog(@"210");
            NSInteger typeNum = [[[_arr1[1] objectForKey:@"data"][0] objectForKey:@"type"] integerValue];
            if (typeNum == 1) {
                self.hidesBottomBarWhenPushed = YES;
                DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
                downloadWeb.strUrl = [[_arr1[1] objectForKey:@"data"][0] objectForKey:@"url"];
                downloadWeb.labelTitleStr = [[_arr1[1] objectForKey:@"data"][0] objectForKey:@"title"];
                [self.navigationController pushViewController:downloadWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else
            {
                NSLog(@"%ld", (long)typeNum);
            }
            break;
        }
        case 211:
        {
            NSLog(@"211");
            NSInteger typeNum = [[[_arr1[1] objectForKey:@"data"][1] objectForKey:@"type"] integerValue];
            if (typeNum == 1) {
                self.hidesBottomBarWhenPushed = YES;
                DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
                downloadWeb.strUrl = [[_arr1[1] objectForKey:@"data"][1] objectForKey:@"url"];
                downloadWeb.labelTitleStr = [[_arr1[1] objectForKey:@"data"][1] objectForKey:@"title"];
                [self.navigationController pushViewController:downloadWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else
            {
                NSLog(@"%ld", (long)typeNum);
            }
            break;
        }
        case 212:
        {
            NSLog(@"212");
            NSInteger typeNum = [[[_arr1[1] objectForKey:@"data"][2] objectForKey:@"type"] integerValue];
            if (typeNum == 1) {
                self.hidesBottomBarWhenPushed = YES;
                DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
                downloadWeb.strUrl = [[_arr1[1] objectForKey:@"data"][2] objectForKey:@"url"];
                downloadWeb.labelTitleStr = [[_arr1[1] objectForKey:@"data"][2] objectForKey:@"title"];
                [self.navigationController pushViewController:downloadWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else
            {
                NSLog(@"%ld", (long)typeNum);
            }
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法3
- (void)recommendBtn3:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 220:
        {
            NSInteger typeNum = [[[_arr1[2] objectForKey:@"data"][0] objectForKey:@"type"] integerValue];
            if (typeNum == 5) {
                self.hidesBottomBarWhenPushed = YES;
                ProjectWeb* projectWeb = [[ProjectWeb alloc]init];
                projectWeb.strUrl = [[_arr1[2] objectForKey:@"data"][0] objectForKey:@"url"];
                projectWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][0] objectForKey:@"title"];
                [self.navigationController pushViewController:projectWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(typeNum == 6)
            {
                self.hidesBottomBarWhenPushed = YES;
                ShareWeb* shareWeb = [[ShareWeb alloc]init];
                shareWeb.strUrl = [[_arr1[2] objectForKey:@"data"][0] objectForKey:@"url"];
                shareWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][0] objectForKey:@"title"];
                [self.navigationController pushViewController:shareWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
        case 221:
        {
            NSInteger typeNum = [[[_arr1[2] objectForKey:@"data"][1] objectForKey:@"type"] integerValue];
            if (typeNum == 5) {
                self.hidesBottomBarWhenPushed = YES;
                ProjectWeb* projectWeb = [[ProjectWeb alloc]init];
                projectWeb.strUrl = [[_arr1[2] objectForKey:@"data"][1] objectForKey:@"url"];
                projectWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][1] objectForKey:@"title"];
                [self.navigationController pushViewController:projectWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(typeNum == 6)
            {
                self.hidesBottomBarWhenPushed = YES;
                ShareWeb* shareWeb = [[ShareWeb alloc]init];
                shareWeb.strUrl = [[_arr1[2] objectForKey:@"data"][1] objectForKey:@"url"];
                shareWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][1] objectForKey:@"title"];
                [self.navigationController pushViewController:shareWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
        case 222:
        {
            NSInteger typeNum = [[[_arr1[2] objectForKey:@"data"][2] objectForKey:@"type"] integerValue];
            if (typeNum == 5) {
                self.hidesBottomBarWhenPushed = YES;
                ProjectWeb* projectWeb = [[ProjectWeb alloc]init];
                projectWeb.strUrl = [[_arr1[2] objectForKey:@"data"][2] objectForKey:@"url"];
                projectWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][2] objectForKey:@"title"];
                [self.navigationController pushViewController:projectWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(typeNum == 6)
            {
                self.hidesBottomBarWhenPushed = YES;
                ShareWeb* shareWeb = [[ShareWeb alloc]init];
                shareWeb.strUrl = [[_arr1[2] objectForKey:@"data"][2] objectForKey:@"url"];
                shareWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][2] objectForKey:@"title"];
                [self.navigationController pushViewController:shareWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
        case 223:
        {
            NSInteger typeNum = [[[_arr1[2] objectForKey:@"data"][3] objectForKey:@"type"] integerValue];
            if (typeNum == 5) {
                self.hidesBottomBarWhenPushed = YES;
                ProjectWeb* projectWeb = [[ProjectWeb alloc]init];
                projectWeb.strUrl = [[_arr1[2] objectForKey:@"data"][3] objectForKey:@"url"];
                projectWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][3] objectForKey:@"title"];
                [self.navigationController pushViewController:projectWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if(typeNum == 6)
            {
                self.hidesBottomBarWhenPushed = YES;
                ShareWeb* shareWeb = [[ShareWeb alloc]init];
                shareWeb.strUrl = [[_arr1[2] objectForKey:@"data"][3] objectForKey:@"url"];
                shareWeb.labelTitleStr = [[_arr1[2] objectForKey:@"data"][3] objectForKey:@"title"];
                [self.navigationController pushViewController:shareWeb animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法4
- (void)recommendBtn4:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 230:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[[_dic1 objectForKey:@"data"] objectForKey:@"data"][0] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 231:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[[_dic1 objectForKey:@"data"] objectForKey:@"data"][1] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 232:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[[_dic1 objectForKey:@"data"] objectForKey:@"data"][2] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法5
- (void)recommendBtn5:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    
}
//  视图上按钮响应的方法6
- (void)recommendBtn6:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 250:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][0] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][0] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 251:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][1] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][1] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 252:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][2] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][2] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 253:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][3] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][3] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 254:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][4] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][4] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 255:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn6 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[4] objectForKey:@"data"][5] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic2 objectForKey:@"data" ] objectForKey:@"data" ][5] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法7
- (void)recommendBtn7:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 260:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[5] objectForKey:@"data"][0] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 261:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[5] objectForKey:@"data"][1] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 262:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[5] objectForKey:@"data"][2] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 263:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[5] objectForKey:@"data"][3] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法8
- (void)recommendBtn8:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 270:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][0] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][0] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 271:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][1] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][1] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 272:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][2] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][2] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 273:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][3] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][3] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 274:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][4] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][4] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 275:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            if (_isBtn8 == NO) {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[_arr1[6] objectForKey:@"data"][5] objectForKey:@"title"];
            }else
            {
                downloadWeb.strUrl = nil;
                downloadWeb.labelTitleStr = [[[_dic3 objectForKey:@"data" ] objectForKey:@"data" ][5] objectForKey:@"title"];
            }
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法9
- (void)recommendBtn9:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 280:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[7] objectForKey:@"data"][0] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 281:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[7] objectForKey:@"data"][1] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 282:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[7] objectForKey:@"data"][2] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 283:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[7] objectForKey:@"data"][3] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  视图上按钮响应的方法10
- (void)recommendBtn10:(UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case 290:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][0] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 291:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][1] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 292:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][2] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 293:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][3] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 294:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][4] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        case 295:
        {
            self.hidesBottomBarWhenPushed = YES;
            DownloadWeb* downloadWeb = [[DownloadWeb alloc]init];
            downloadWeb.strUrl = nil;
            downloadWeb.labelTitleStr = [[_arr1[8] objectForKey:@"data"][5] objectForKey:@"title"];
            [self.navigationController pushViewController:downloadWeb animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
        default:
            break;
    }
}
//  火热专题-刷新按钮点击响应方法
- (void)btn3
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_specialVCC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//  猜你喜欢-刷新按钮点击响应方法
- (void)btn4
{
    [self download2];
}
//  国漫也精彩-刷新按钮点击响应方法
- (void)btn6
{
    _isBtn6 = YES;
    [self download3];
}
//  热门连载-刷新按钮点击响应方法
- (void)btn8
{
    _isBtn8 = YES;
    [self download4];
}

//--------------------------------------  更新页面  ----------------------------------------//
#pragma mark-更新页面
//  创建更新页面视图
- (void)createUpdateView
{
    _updateView = [[UIView alloc]initWithFrame:CGRectMake(width1, 67, width1, height1-67-44)];
    _updateView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.view addSubview:_updateView];
    
    UIView* viewHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, height1/15)];
    viewHead.backgroundColor = [UIColor whiteColor];
    [_updateView addSubview:viewHead];
    UIButton* btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(width1/36, height1/50, width1/7.5, height1/15-height1/50*2);
    [btnLeft setTitle:@"全部漫画" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize: 10];
    [btnLeft addTarget:self action:@selector(btnLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.tag = 590;
    [viewHead addSubview:btnLeft];
    UIImageView* imageViewLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ClassifyItemIcon"]];
    imageViewLeft.tag = 591;
    imageViewLeft.frame = CGRectMake(width1/36+width1/7.5, height1/50+(height1/15-height1/50*2)/2-height1/128/2, width1/36, height1/128);
    [viewHead addSubview:imageViewLeft];
    UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(width1 - width1/20 - width1/24, height1/50, width1/24, width1/24);
    btnRight.tag = 592;
    [btnRight setImage:[UIImage imageNamed:@"comicLatestMenuIcon2"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(gridBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewHead addSubview:btnRight];
    
    _chooseViwe = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
    _chooseViwe.backgroundColor = [UIColor blackColor];
    _chooseViwe.alpha = 0.5;
    [_chooseViwe addTarget:self action:@selector(chooseViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chooseViwe];
    
    _chooseViewSmall = [[UIView alloc]initWithFrame:CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15)];
    _chooseViewSmall.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [self.view addSubview:_chooseViewSmall];
    NSArray* arrStr = @[@"全部漫画", @"原创漫画", @"译制漫画"];
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i+1)*width1/36+i*width1/7, height1/75, width1/7, height1/15-height1/75*2);
        btn.tag = 593+i;
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:3.0];
        [btn setTitle:arrStr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        if (i == 0) {
            btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else
        {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_chooseViewSmall addSubview:btn];
    }
    
    [self ListAllAnimationCVDownload];
}
- (void)btnLeftAction:(UIButton* )sender
{
    if (_isChoose == NO)
    {
        UIButton* btn = [self.view viewWithTag:590];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        UIImageView* imageView = [self.view viewWithTag:591];
        imageView.image = [UIImage imageNamed:@"ClassifyItemIconSelected"];
        [UIView animateWithDuration:0.00001 animations:^{
            _chooseViwe.frame = CGRectMake(0, 67+height1/15*2, width1, height1-67+height1/15*2-44);
            _chooseViewSmall.frame = CGRectMake(0, 67+height1/15, width1, height1/15);
        }];
        _isChoose = YES;
    }else
    {
        UIButton* btn = [self.view viewWithTag:590];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView* imageView = [self.view viewWithTag:591];
        imageView.image = [UIImage imageNamed:@"ClassifyItemIcon"];
        [UIView animateWithDuration:0.00001 animations:^{
            _chooseViewSmall.frame = CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15);
            _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
        }];
        _isChoose = NO;
    }
}
- (void)chooseBtnAction:(UIButton* )sender
{
    switch (sender.tag) {
        case 593:
        {
            _chooseNum = 1;
            NSLog(@"全部漫画按钮被点击！");
            UIButton* btn1 = [self.view viewWithTag:593];
            btn1.backgroundColor = [UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:594];
            btn2.backgroundColor = [UIColor whiteColor];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:595];
            btn3.backgroundColor = [UIColor whiteColor];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton* btn = [self.view viewWithTag:590];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:@"全部漫画" forState:UIControlStateNormal];
            UIImageView* imageView = [self.view viewWithTag:591];
            imageView.image = [UIImage imageNamed:@"ClassifyItemIcon"];
            [UIView animateWithDuration:0.00001 animations:^{
                _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15);
            }];
            _isChoose = NO;
            
            [_listAllAnimationCV reloadData];
            if (_isGrid == YES) {
                [self GridAllAnimationCVDownload];
            }else
            {
                [self ListAllAnimationCVDownload];
            }
            break;
        }
        case 594:
        {
            _chooseNum = 2;
            NSLog(@"原创漫画按钮被点击！");
            UIButton* btn1 = [self.view viewWithTag:594];
            btn1.backgroundColor = [UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:593];
            btn2.backgroundColor = [UIColor whiteColor];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:595];
            btn3.backgroundColor = [UIColor whiteColor];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton* btn = [self.view viewWithTag:590];
            [btn setTitle:@"原创漫画" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIImageView* imageView = [self.view viewWithTag:591];
            imageView.image = [UIImage imageNamed:@"ClassifyItemIcon"];
            [UIView animateWithDuration:0.00001 animations:^{
                _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15);
            }];
            _isChoose = NO;
            
            [_listAllAnimationCV reloadData];
            if (_isGrid == YES) {
                [self GridOriginalCartoonCVDownload];
            }else
            {
                [self ListOriginalCartoonCVDownload];
            }
            break;
        }
        case 595:
        {
            _chooseNum = 3;
            NSLog(@"译制漫画按钮被点击！");
            UIButton* btn1 = [self.view viewWithTag:595];
            btn1.backgroundColor = [UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1];
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:593];
            btn2.backgroundColor = [UIColor whiteColor];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:594];
            btn3.backgroundColor = [UIColor whiteColor];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton* btn = [self.view viewWithTag:590];
            [btn setTitle:@"译制漫画" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIImageView* imageView = [self.view viewWithTag:591];
            imageView.image = [UIImage imageNamed:@"ClassifyItemIcon"];
            [UIView animateWithDuration:0.00001 animations:^{
                _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15);
            }];
            _isChoose = NO;
            
            [_listAllAnimationCV reloadData];
            if (_isGrid == YES) {
                [self GridDubbingCartoonsCVDownload];
            }else
            {
                [self ListDubbingCartoonsCVDownload];
            }
            break;
        }
        default:
            break;
    }
}
- (void)chooseViewAction
{
    UIButton* btn = [self.view viewWithTag:590];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImageView* imageView = [self.view viewWithTag:591];
    imageView.image = [UIImage imageNamed:@"ClassifyItemIcon"];
    [UIView animateWithDuration:0.00001 animations:^{
        _chooseViewSmall.frame = CGRectMake(0, -(height1-67+height1/15*2-44+height1/15), width1, height1/15);
        _chooseViwe.frame = CGRectMake(0, -(height1-67+height1/15*2-44), width1, height1-67+height1/15*2-44);
    }];
    _isChoose = NO;
}
- (void)gridBtnAction:(UIButton* )sender
{
    if (_chooseNum == 1) {
        if (_isGrid == NO) {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon1"] forState:UIControlStateNormal];
            _isGrid = YES;
            
            [self GridAllAnimationCVDownload];
        }else
        {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon2"] forState:UIControlStateNormal];
            _isGrid = NO;
            [self ListAllAnimationCVDownload];
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == NO) {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon1"] forState:UIControlStateNormal];
            _isGrid = YES;
            [self GridOriginalCartoonCVDownload];
        }else
        {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon2"] forState:UIControlStateNormal];
            _isGrid = NO;
            [self ListOriginalCartoonCVDownload];
        }
    }
    else if(_chooseNum == 3)
    {
        if (_isGrid == NO) {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon1"] forState:UIControlStateNormal];
            _isGrid = YES;
            
            [self GridDubbingCartoonsCVDownload];
        }else
        {
            UIButton* btn= [self.view viewWithTag:592];
            [btn setImage:[UIImage imageNamed:@"comicLatestMenuIcon2"] forState:UIControlStateNormal];
            _isGrid = NO;
            [self ListDubbingCartoonsCVDownload];
        }
    }
}
- (void)ListAllAnimationCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/100/%ld.json", _listAllAnimationPage] :nil finshedBlock:^(id dataString) {
        if (_listAllAnimationPage == 0) {
            [_listAllAnimationArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_listAllAnimationArr addObjectsFromArray:a];
            if (_listAllAnimationCV == nil) {
                [self createCollectionView];
            }
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListAllAnimationCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_listAllAnimationArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListAllAnimationCell" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}
- (void)ListOriginalCartoonCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/1/%ld.json", _listOriginalCartoonPage] :nil finshedBlock:^(id dataString) {
        if (_listOriginalCartoonPage == 0) {
            [_listOriginalCartoonArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_listOriginalCartoonArr addObjectsFromArray:a];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell2"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_listOriginalCartoonArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell2"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
- (void)ListDubbingCartoonsCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/0/%ld.json", _listDubbingCartoonsPage] :nil finshedBlock:^(id dataString) {
        if (_listDubbingCartoonsPage == 0) {
            [_listDubbingCartoonsArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_listDubbingCartoonsArr addObjectsFromArray:a];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListDubbingCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell3"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_listDubbingCartoonsArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"ListDubbingCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell3"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
- (void)GridAllAnimationCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/100/%ld.json", _gridAllAnimationPage] :nil finshedBlock:^(id dataString) {
        if (_gridAllAnimationPage == 0) {
            [_gridAllAnimationArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_gridAllAnimationArr addObjectsFromArray:a];
            if (_listAllAnimationCV == nil) {
                [self createCollectionView];
            }
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridAllAnimationCell" bundle:nil] forCellWithReuseIdentifier:@"Cell4"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_gridAllAnimationArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridAllAnimationCell" bundle:nil] forCellWithReuseIdentifier:@"Cell4"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
- (void)GridOriginalCartoonCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/1/%ld.json", _gridOriginalCartoonPage] :nil finshedBlock:^(id dataString) {
        if (_gridOriginalCartoonPage == 0) {
            [_gridOriginalCartoonArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_gridOriginalCartoonArr addObjectsFromArray:a];
            if (_listAllAnimationCV == nil) {
                [self createCollectionView];
            }
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell5"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_gridOriginalCartoonArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell5"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
        }
    } ErrorBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}
- (void)GridDubbingCartoonsCVDownload
{
    [BaseService getRequest:[NSString stringWithFormat:@"http://v2.api.dmzj.com/latest/0/%ld.json", _gridDubbingCartoonsPage] :nil finshedBlock:^(id dataString) {
        if (_gridDubbingCartoonsPage == 0) {
            [_gridDubbingCartoonsArr removeAllObjects];
            NSArray* a = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingAllowFragments error:nil];
            [_gridDubbingCartoonsArr addObjectsFromArray:a];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell5"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.header endRefreshing];
        }else
        {
            NSMutableArray* arr2 = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
            [_gridDubbingCartoonsArr addObjectsFromArray:arr2];
            //利用集合视图，提前注册xib(或者提前注册cell)
            [_listAllAnimationCV registerNib:[UINib nibWithNibName:@"GridOriginalCartoonCell" bundle:nil] forCellWithReuseIdentifier:@"Cell5"];
            [_listAllAnimationCV reloadData];
            [_listAllAnimationCV.footer endRefreshing];
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
    _listAllAnimationCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0,height1/15,width1,height1-67-height1/15-44) collectionViewLayout:layOut];
    _listAllAnimationCV.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    //设置数据源和代理
    _listAllAnimationCV.delegate = self;
    _listAllAnimationCV.dataSource = self;
    
    [_listAllAnimationCV addLegendHeaderWithRefreshingBlock:^{
        [_listAllAnimationCV.header beginRefreshing];
        _listAllAnimationPage = 0;
        _listOriginalCartoonPage = 0;
        _listDubbingCartoonsPage = 0;
        _gridAllAnimationPage = 0;
        _gridOriginalCartoonPage = 0;
        _gridDubbingCartoonsPage = 0;
        if (_chooseNum == 1)
        {
            if (_isGrid == YES) {
                [self GridAllAnimationCVDownload];
            }else
            {
                [self ListAllAnimationCVDownload];
            }
        }else if(_chooseNum == 2)
        {
            if (_isGrid == YES) {
                [self GridOriginalCartoonCVDownload];
            }else
            {
                [self ListOriginalCartoonCVDownload];
            }
        }else
        {
            if (_isGrid == YES) {
                [self GridDubbingCartoonsCVDownload];
            }else
            {
                [self ListDubbingCartoonsCVDownload];
            }
        }
    }];
    [_listAllAnimationCV addLegendFooterWithRefreshingBlock:^{
        [_listAllAnimationCV.footer beginRefreshing];
        _listAllAnimationPage++;
        _listOriginalCartoonPage++;
        _listDubbingCartoonsPage++;
        _gridAllAnimationPage++;
        _gridOriginalCartoonPage++;
        _gridDubbingCartoonsPage++;
        if (_chooseNum == 1)
        {
            if (_isGrid == YES) {
                [self GridAllAnimationCVDownload];
            }else
            {
                [self ListAllAnimationCVDownload];
            }
        }else if(_chooseNum == 2)
        {
            if (_isGrid == YES) {
                [self GridOriginalCartoonCVDownload];
            }else
            {
                [self ListOriginalCartoonCVDownload];
            }
        }else
        {
            if (_isGrid == YES) {
                [self GridDubbingCartoonsCVDownload];
            }else
             {
                 [self ListDubbingCartoonsCVDownload];
             }
        }
    }];
    [_updateView addSubview:_listAllAnimationCV];
}
#pragma mark - UICollectionViewDelegate
//选中某一个item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"select section:%ld item:%ld",(long)indexPath.section,(long)indexPath.item);
}
#pragma mark - UICollectionViewDataSource
//集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ( _chooseNum == 1)
    {
        if (_isGrid == YES) {
            return _gridAllAnimationArr.count/3;
        }else
        {
            return  _listAllAnimationArr.count;
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == YES) {
            return _gridOriginalCartoonArr.count/3;
        }else
        {
            return  _listOriginalCartoonArr.count;
        }
    }else
    {
        if (_isGrid == YES) {
            return _gridDubbingCartoonsArr.count/3;
        }else
        {
            return  _listDubbingCartoonsArr.count;
        }
    }
}
//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_chooseNum == 1) {
        if (_isGrid == YES) {
            return 3;
        }else
        {
            return 1;
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == YES) {
            return 3;
        }else
        {
            return 1;
        }
    }else
    {
        if (_isGrid == YES) {
            return 3;
        }else
        {
            return 1;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //collectionView 会自动创建cell，或者自动从重用队列中取cell
    //indexPath.item
    if (_chooseNum == 1) {
        if (_isGrid == YES) {
            GridAllAnimationCell *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:GridAllAnimation1 forIndexPath:indexPath];
            cell4.label1.text = [_gridAllAnimationArr[(indexPath.section*3)+indexPath.item] objectForKey:@"last_update_chapter_name"];
            cell4.label2.text = [_gridAllAnimationArr[(indexPath.section*3)+indexPath.item] objectForKey:@"title"];
            [cell4.btn1.layer setMasksToBounds:YES];
            [cell4.btn1.layer setCornerRadius:5.0];
            cell4.btn1.backgroundColor = [UIColor blueColor];
            return cell4;
        }else
        {
            ListAllAnimationCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:listAllAnimation1 forIndexPath:indexPath];
            cell1.label1.text = [_listAllAnimationArr[indexPath.section] objectForKey:@"title"];
            cell1.label2.text = [_listAllAnimationArr[indexPath.section] objectForKey:@"authors"];
            cell1.label3.text = [_listAllAnimationArr[indexPath.section] objectForKey:@"types"];
            cell1.label5.text = [_listAllAnimationArr[indexPath.section] objectForKey:@"last_update_chapter_name"];
            [cell1.btn1.layer setMasksToBounds:YES];
            [cell1.btn1.layer setCornerRadius:5.0];
            return cell1;
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == YES) {
            GridOriginalCartoonCell *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:GridOriginalCartoon1 forIndexPath:indexPath];
            cell5.label1.text = [_gridOriginalCartoonArr[(indexPath.section*3)+indexPath.item] objectForKey:@"last_update_chapter_name"];
            cell5.label2.text = [_gridOriginalCartoonArr[(indexPath.section*3)+indexPath.item] objectForKey:@"title"];
            [cell5.btn1.layer setMasksToBounds:YES];
            [cell5.btn1.layer setCornerRadius:5.0];
            cell5.btn1.backgroundColor = [UIColor cyanColor];
            return cell5;
        }else
        {
            ListOriginalCartoonCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:listOriginalCartoon1 forIndexPath:indexPath];
            cell1.label1.text = [_listOriginalCartoonArr[indexPath.section] objectForKey:@"title"];
            cell1.label2.text = [_listOriginalCartoonArr[indexPath.section] objectForKey:@"authors"];
            cell1.label3.text = [_listOriginalCartoonArr[indexPath.section] objectForKey:@"types"];
            cell1.label5.text = [_listOriginalCartoonArr[indexPath.section] objectForKey:@"last_update_chapter_name"];
            [cell1.btn1.layer setMasksToBounds:YES];
            [cell1.btn1.layer setCornerRadius:5.0];
            return cell1;
        }
    }else
    {
        if (_isGrid == YES) {
            GridOriginalCartoonCell *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:GridOriginalCartoon1 forIndexPath:indexPath];
            cell5.label1.text = [_gridDubbingCartoonsArr[(indexPath.section*3)+indexPath.item] objectForKey:@"last_update_chapter_name"];
            cell5.label2.text = [_gridDubbingCartoonsArr[(indexPath.section*3)+indexPath.item] objectForKey:@"title"];
            [cell5.btn1.layer setMasksToBounds:YES];
            [cell5.btn1.layer setCornerRadius:5.0];
            cell5.btn1.backgroundColor = [UIColor purpleColor];
            return cell5;
        }else
        {
            ListDubbingCartoonCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:listDubbingCartoon1 forIndexPath:indexPath];
            cell1.label1.text = [_listDubbingCartoonsArr[indexPath.section] objectForKey:@"title"];
            cell1.label2.text = [_listDubbingCartoonsArr[indexPath.section] objectForKey:@"authors"];
            cell1.label3.text = [_listDubbingCartoonsArr[indexPath.section] objectForKey:@"types"];
            cell1.label5.text = [_listDubbingCartoonsArr[indexPath.section] objectForKey:@"last_update_chapter_name"];
            [cell1.btn1.layer setMasksToBounds:YES];
            [cell1.btn1.layer setCornerRadius:5.0];
            return cell1;
        }
    }
}
//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_chooseNum == 1) {
        if (_isGrid == YES) {
            return CGSizeMake(width1/3.9,height1/5);
        }else
        {
            //每个item也可以调成不同的大小
            return CGSizeMake(width1,height1/5);
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == YES) {
            return CGSizeMake(width1/3.9,height1/5);
        }else
        {
            //每个item也可以调成不同的大小
            return CGSizeMake(width1,height1/5);
        }
    }else
    {
        if (_isGrid == YES) {
            return CGSizeMake(width1/3.9,height1/5);
        }else
        {
            //每个item也可以调成不同的大小
            return CGSizeMake(width1,height1/5);
        }
    }
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (_chooseNum == 1) {
        if (_isGrid == YES) {
            return UIEdgeInsetsMake(4, (width1-width1/3.9*3)/6, 4, (width1-width1/3.9*3)/6);
        }else
        {
            return UIEdgeInsetsMake(2, 0, 0, 0);
        }
    }else if(_chooseNum == 2)
    {
        if (_isGrid == YES) {
            return UIEdgeInsetsMake(4, (width1-width1/3.9*3)/6, 4, (width1-width1/3.9*3)/6);
        }else
        {
            return UIEdgeInsetsMake(2, 0, 0, 0);
        }
    }else
    {
        if (_isGrid == YES) {
            return UIEdgeInsetsMake(4, (width1-width1/3.9*3)/6, 4, (width1-width1/3.9*3)/6);
        }else
        {
            return UIEdgeInsetsMake(2, 0, 0, 0);
        }
    }
}
//  创建分类页面视图
- (void)createView3
{
    _view3 = [[UIView alloc]initWithFrame:CGRectMake(2*width1, 67, width1, height1-67-44)];
    _view3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_view3];
}
//  创建排行页面视图
- (void)createView4
{
    _view4 = [[UIView alloc]initWithFrame:CGRectMake(3*width1, 67, width1, height1-67-44)];
    _view4.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_view4];
}
//  创建专题页面视图
- (void)createView5
{
    
    _specialVS = [[SpecialViewS alloc]initWithFrame:CGRectMake(4*width1, 67, width1, height1-67-44)];
    [self.view addSubview:_specialVS];
    
}

//  创建自定义导航栏
- (void)createNavigation
{
    UIView* batteryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width1, 20)];
    batteryView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:batteryView];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width1, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSArray* arr1 = @[@"推荐", @"更新", @"分类", @"排行", @"专题"];
    CGFloat width11 = width1 - width1/12;
    for (int i = 0; i < 5; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width11/25.7)+i*(width1/10+width11/25.7*2), 10, width1/10, 24);
        //btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:arr1[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(classificationbtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    _navigationBarIndicatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NavigationBarIndicator"]];
    _navigationBarIndicatorView.frame = CGRectMake((width11/25.7)+width1/10/2-width1/40/2, 10+24+1, width1/40, height1/100);
    [view addSubview:_navigationBarIndicatorView];
    
    
//    UIButton* navigationBarSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    navigationBarSearchBtn.frame = CGRectMake(12, width1-30, 20, 20);
//    navigationBarSearchBtn.backgroundColor = [UIColor redColor];
//    //[navigationBarSearchBtn setImage:[UIImage imageNamed:@"NavigationBarSearch'"] forState:UIControlStateNormal];
//    [view addSubview:navigationBarSearchBtn];
}
//  自定义导航栏按钮响应方法
- (void)classificationbtn:(UIButton* )sender
{
    CGFloat width12 = width1 - width1/12;
    switch (sender.tag) {
        case 200:{
            NSLog(@"200");
            UIButton* btn = [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            UIButton* btn1 = [self.view viewWithTag:201];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:202];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:203];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn4 = [self.view viewWithTag:204];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.1 animations:^{
                _recommendedSV.frame = CGRectMake(0, 67, width1, height1-67-44);
                _updateView.frame = CGRectMake(width1, 67, width1, height1-67-44);
                _view3.frame = CGRectMake(2*width1, 67, width1, height1-67-44);
                _view4.frame = CGRectMake(3*width1, 67, width1, height1-67-44);
                _specialVS.frame = CGRectMake(4*width1, 67, width1, height1-67-44);
                _navigationBarIndicatorView.frame = CGRectMake((width12/25.7)+width1/10/2-width1/40/2, 10+24+1, width1/40, height1/100);
                _chooseViwe.frame = CGRectMake(width1, 67+height1/15*2, width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(width1, 67+height1/15, width1, height1/15);
            }];
            break;
        }
        case 201:{
            NSLog(@"201");
            if (_listAllAnimationCV == nil) {
                [self createUpdateView];
            }
            UIButton* btn = [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            UIButton* btn1 = [self.view viewWithTag:200];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:202];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:203];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn4 = [self.view viewWithTag:204];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.1 animations:^{
                _recommendedSV.frame = CGRectMake(-width1, 67, width1, height1-67-44);
                _updateView.frame = CGRectMake(0, 67, width1, height1-67-44);
                _view3.frame = CGRectMake(width1, 67, width1, height1-67-44);
                _view4.frame = CGRectMake(2*width1, 67, width1, height1-67-44);
                _specialVS.frame = CGRectMake(3*width1, 67, width1, height1-67-44);
                _navigationBarIndicatorView.frame = CGRectMake((width12/25.7)+width1/10/2-width1/40/2+(width1/10+width12/25.7*2), 10+24+1, width1/40, height1/100);
                if (_isChoose == YES) {
                    _chooseViewSmall.frame = CGRectMake(0, 67+height1/15, width1, height1/15);
                    _chooseViwe.frame = CGRectMake(0, 67+height1/15*2, width1, height1-67+height1/15*2-44);
                }
            }];
            break;
        }
        case 202:
        {
            NSLog(@"202");
            if (_view3 == nil) {
                [self createView3];
            }
            UIButton* btn = [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            UIButton* btn1 = [self.view viewWithTag:200];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:201];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:203];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn4 = [self.view viewWithTag:204];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.1 animations:^{
                _recommendedSV.frame = CGRectMake(-width1*2, 67, width1, height1-67-44);
                _updateView.frame = CGRectMake(-width1, 67, width1, height1-67-44);
                _view3.frame = CGRectMake(0, 67, width1, height1-67-44);
                _view4.frame = CGRectMake(1*width1, 67, width1, height1-67-44);
                _specialVS.frame = CGRectMake(2*width1, 67, width1, height1-67-44);
                _navigationBarIndicatorView.frame = CGRectMake((width12/25.7)+width1/10/2-width1/40/2+(width1/10+width12/25.7*2)*2, 10+24+1, width1/40, height1/100);
                _chooseViwe.frame = CGRectMake(-width1, 67+height1/15*2, width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(-width1, 67+height1/15, width1, height1/15);
            }];
            break;
        }
        case 203:
        {
            NSLog(@"203");
            if (_view4 == nil) {
                [self createView4];
            }
            UIButton* btn = [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            UIButton* btn1 = [self.view viewWithTag:200];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:201];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:202];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn4 = [self.view viewWithTag:204];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.1 animations:^{
                _recommendedSV.frame = CGRectMake(-width1*2, 67, width1, height1-67-44);
                _updateView.frame = CGRectMake(-width1*2, 67, width1, height1-67-44);
                _view3.frame = CGRectMake(-width1, 67, width1, height1-67-44);
                _view4.frame = CGRectMake(0, 67, width1, height1-67-44);
                _specialVS.frame = CGRectMake(1*width1, 67, width1, height1-67-44);
                _navigationBarIndicatorView.frame = CGRectMake((width12/25.7)+width1/10/2-width1/40/2+(width1/10+width12/25.7*2)*3, 10+24+1, width1/40, height1/100);
                _chooseViwe.frame = CGRectMake(-width1*2, 67+height1/15*2, width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(-width1*2, 67+height1/15, width1, height1/15);
            }];
            break;
        }
        case 204:
        {
            NSLog(@"204");
            if (_specialVS == nil) {
                [self createView5];
            }
            UIButton* btn = [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:115/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            UIButton* btn1 = [self.view viewWithTag:200];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn2 = [self.view viewWithTag:201];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn3 = [self.view viewWithTag:202];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIButton* btn4 = [self.view viewWithTag:203];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.1 animations:^{
                _recommendedSV.frame = CGRectMake(-width1*2, 67, width1, height1-67-44);
                _updateView.frame = CGRectMake(-width1*3, 67, width1, height1-67-44);
                _view3.frame = CGRectMake(-width1*2, 67, width1, height1-67-44);
                _view4.frame = CGRectMake(-width1, 67, width1, height1-67-44);
                _specialVS.frame = CGRectMake(0, 67, width1, height1-67-44);
                _navigationBarIndicatorView.frame = CGRectMake((width12/25.7)+width1/10/2-width1/40/2+(width1/10+width12/25.7*2)*4, 10+24+1, width1/40, height1/100);
                _chooseViwe.frame = CGRectMake(-width1*3, 67+height1/15*2, width1, height1-67+height1/15*2-44);
                _chooseViewSmall.frame = CGRectMake(-width1*3, 67+height1/15, width1, height1/15);
            }];
            break;
        }
        default:
            break;
    }
}

@end
