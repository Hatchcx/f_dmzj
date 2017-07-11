//
//  ViewController.m
//  代理练习1
//
//  Created by 黄启明 on 2017/5/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ViewController.h"
#import "A.h"
#import "B.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    A* a = [[A alloc]init];
    B* b = [[B alloc]init];
    a.delegate = b;
    [a go];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
