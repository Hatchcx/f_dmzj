//
//  BaseNavPage.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/7.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "BaseNavPage.h"

@interface BaseNavPage ()

@end

@implementation BaseNavPage

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
