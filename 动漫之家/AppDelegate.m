//
//  AppDelegate.m
//  动漫之家
//
//  Created by 黄启明 on 2017/3/6.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[NSThread sleepForTimeInterval:1.0];//设置启动页面时间,延长1秒的时间
    
    NSUserDefaults *myUD=[NSUserDefaults standardUserDefaults];
    
    if(![myUD boolForKey:@"firstStart"])
    {
        [myUD setBool:YES forKey:@"firstStart"];
        
        [myUD synchronize];//同步
        
        NSLog(@"第一次启动");
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        self.window.rootViewController = [[ViewController alloc]init];
        
        [self.window makeKeyAndVisible];
    }
    else
    {
        NSLog(@"不是第一次启动");
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        self.window.rootViewController = [[RootViewController alloc]init];
        
        [self.window makeKeyAndVisible];
    }
    
    // Override point for customization after application launch.
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    /* [ShareSDK registerApp:@"iosv1101"
     
     activePlatforms:@[
     @(SSDKPlatformTypeSinaWeibo),
     @(SSDKPlatformTypeMail),
     @(SSDKPlatformTypeSMS),
     @(SSDKPlatformTypeCopy),
     @(SSDKPlatformTypeWechat),
     @(SSDKPlatformTypeQQ),
     @(SSDKPlatformTypeRenren),
     @(SSDKPlatformTypeGooglePlus)]
     onImport:^(SSDKPlatformType platformType)
     {
     switch (platformType)
     {
     case SSDKPlatformTypeWechat:
     [ShareSDKConnector connectWeChat:[WXApi class]];
     break;
     case SSDKPlatformTypeQQ:
     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
     break;
     case SSDKPlatformTypeSinaWeibo:
     [ShareSDKConnector connectWeibo:[WeiboSDK class]];
     break;
     default:
     break;
     }
     }
     onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
     
     switch (platformType)
     {
     case SSDKPlatformTypeSinaWeibo:
     //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
     [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
     appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
     redirectUri:@"http://www.sharesdk.cn"
     authType:SSDKAuthTypeBoth];
     break;
     case SSDKPlatformTypeWechat:
     [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
     appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
     break;
     case SSDKPlatformTypeQQ:
     [appInfo SSDKSetupQQByAppId:@"100371282"
     appKey:@"aed9b0303e3ed1e27bae87c33761161d"
     authType:SSDKAuthTypeBoth];
     break;
     case SSDKPlatformTypeRenren:
     [appInfo        SSDKSetupRenRenByAppId:@"226427"
     appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
     secretKey:@"f29df781abdd4f49beca5a2194676ca4"
     authType:SSDKAuthTypeBoth];
     break;
     case SSDKPlatformTypeGooglePlus:
     [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
     clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
     redirectUri:@"http://localhost"];
     break;
     default:
     break;
     }
     }];*/
    
    [ShareSDK registerApp:@"bd433c5fc07c"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx10727a21c4e3f8fa"
                                            appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1105452272"
                                           appKey:@"EkmUs3Cp4h0p5uKG"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }
     ];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}


- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
