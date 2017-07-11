//
//  RootViewController.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "RootViewController.h"
#import "PageInfo.h"
#import "ComicPage.h"
#import "NewsPage.h"
#import "LightNovelPage.h"
#import "MyPage.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(id)init
{
    self = [super init];
    if (self) {
        [self addTabControllers];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addTabControllers
{
    self.tabBar.tintColor = [UIColor blueColor];
    self.viewControllers = [PageInfo pageControllers];
    
    /*
    NSMutableArray* controllers = [NSMutableArray array];
    BaseNavPage* page = nil;
    UINavigationController* navPage = nil;
    
    page = [[ComicPage alloc]init];
    navPage = [[UINavigationController alloc]initWithRootViewController:page];
    [controllers addObject:navPage];
    page.title = @"漫画";
    page.tabBarItem.image = [UIImage imageNamed:@"TabComic"];
    
    page = [[NewsPage alloc]init];
    navPage = [[UINavigationController alloc]initWithRootViewController:page];
    [controllers addObject:navPage];
    page.title = @"新闻";
    page.tabBarItem.image = [UIImage imageNamed:@"TabNews"];
    
    page = [[LightNovelPage alloc]init];
    navPage = [[UINavigationController alloc]initWithRootViewController:page];
    [controllers addObject:navPage];
    page.title = @"轻小说";
    page.tabBarItem.image = [UIImage imageNamed:@"TabNovel"];
    
    page = [[MyPage alloc]init];
    navPage = [[UINavigationController alloc]initWithRootViewController:page];
    [controllers addObject:navPage];
    page.title = @"我的";
    page.tabBarItem.image = [UIImage imageNamed:@"TabMy"];
    
    self.viewControllers = controllers;*/
}

@end
