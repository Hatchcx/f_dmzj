#import "BaseService.h"
#import <CommonCrypto/CommonDigest.h>
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

@implementation BaseService
/*
 post请求方式 只提交数据
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
#pragma marks - POST URL-Form-Encoded Request
+(void)postRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock
{
    if ([NSJSONSerialization isValidJSONObject:parameters])
    {
        //POST请求
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //设置服务端返回的数据类型
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"*/*", nil];
        [manager POST:parameter parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            finishBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
            errorBlock(error);
        }];
        
        
    }
    
}
/*
 post请求方式 提交数据和图片
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 _filePaths 里面都是NSDictionary *dic例如下面
 NSURL *filePath = [dic objectForKey:@"filePath"];
 NSString *imageName = [dic objectForKey:@"image"];
 
 filePath 表示NSURL地址
 imageName 上传参数名
 */
+(void)postRequest:(NSString *)parameter :(NSDictionary *)parameters :(NSMutableArray *)_filePaths finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock{
    
    //    if ([NSJSONSerialization isValidJSONObject:_parameters])
    //    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[BaseService headerKey] forHTTPHeaderField:@"X-NBB-SIGN"];
    [manager.requestSerializer setValue:[BaseService getPhoneNumber] forHTTPHeaderField:@"X-NBB-AUTHID"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil, nil];
   
    [manager POST:[NSString stringWithFormat:@"%@%@",@"http://192.168.0.158:9001/api.php/",parameter] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSDictionary *dic in _filePaths) {
            NSURL *filePath = [dic objectForKey:@"filePath"];
            NSString *imageName = [dic objectForKey:@"image"];
            [formData appendPartWithFileURL:filePath name:imageName error:nil];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finishBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
    
    //    }
}

/*
 get请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)getRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置服务端返回的数据类型
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //加头部验证
    //[manager.requestSerializer setValue:@"40c62a333ee9_868904023225828" forHTTPHeaderField:@"APPUSERID"];
    [manager GET:parameter parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finishBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
    
    // }
}

/*
 DELETE请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)deleteRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock{
    
    //    if ([NSJSONSerialization isValidJSONObject:_parameters])
    //    {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil, nil];
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@",@"",parameter] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finishBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
    
    // }
}

/*
 PUT请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)putRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock{
    
    //    if ([NSJSONSerialization isValidJSONObject:_parameters])
    //    {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil, nil];
       
    [manager PUT:[NSString stringWithFormat:@"%@%@",@"",parameter] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finishBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
    
    // }
}


#pragma marks - 把数据转换成json
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        //        CLog(error);
        //        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+(void)showMesg:(NSString*)myMessage
{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:myMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

+(NSString *)md5:(NSString*)str
{
    if (str.length==0) {
        return @"";
    }
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+(NSString*)sha1:(NSString*)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+(NSString*)headerKey
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    NSString *strTime=[NSString stringWithFormat:@"%.0f",time];
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    NSString* key=[NSString stringWithFormat:@"%@,%@",[BaseService md5:[NSString stringWithFormat:@"%@%@%@",strTime,@"MjNW3%Qz~lPxOG:gL,^RcF?Xf)EqS_{h[J<t!4=8",[ud objectForKey:@"myPhoneNumber"]]],strTime];
    return key;
}
//生成应用验证安全秘钥
+(NSString*)headerKey1
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    NSString *strTime=[NSString stringWithFormat:@"%.0f",time];
    NSString* key=[NSString stringWithFormat:@"%@,%@",[BaseService md5:[NSString stringWithFormat:@"%@%@",strTime,@"MjNW3%Qz~lPxOG:gL,^RcF?Xf)EqS_{h[J<t!4=8"]],strTime];
    return key;
}

+(NSString*)getPhoneNumber
{
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"myPhoneNumber"];
}
//获取当前时间戳
+(NSString*)getTimeString{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    NSString *strTime=[NSString stringWithFormat:@"%.0f",time];
    return strTime;
}

+(BOOL)checkNumber:(NSString*)phone
{
    BOOL isMatch = NO;
    if (phone.length>0&&phone.length<12) {
        isMatch=YES;
    }
    return isMatch;
}

+(NSString*)getHeadImageText:(NSString*)name
{
    NSMutableArray*  sumArr=[NSMutableArray new];//记录有几个中文字符
    int  location=-1;//记录第一个中文字符的位置
    BOOL isAllChinese=YES;
    for (int i=0; i<name.length; i++) {
        int a = [name characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            [sumArr addObject:[name substringWithRange:NSMakeRange(i, 1)]];
            if (location==-1) {
                location=i;
            }
        }else{
            isAllChinese=NO;
        }
    }
    NSInteger nameLength = name.length;
    if (isAllChinese) {
        nameLength = nameLength >= 2 ? (nameLength - 2) : 0;
        return [name substringFromIndex:nameLength];
    }else{
        if (sumArr.count>=2) {
            return [NSString stringWithFormat:@"%@%@",sumArr[sumArr.count-2],sumArr[sumArr.count-1]];
        }else if (sumArr.count==0){
            nameLength = nameLength >= 2 ? 2 : nameLength;
            return [name substringToIndex:nameLength];
        }else{
            if (location<name.length-1) {
                return [name substringWithRange:NSMakeRange(location, 2)];
            }else
                return [name substringWithRange:NSMakeRange(location-1, 2)];
        }
    }
}

+ (NSString *)stringContainsEmoji:(NSString *)string
{
    NSMutableArray* textArr = [NSMutableArray array];
    NSString *returnString = nil;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                NSLog(@"%c",hs);
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            NSString *string = [self emojiChangeUnicode:substring];
                                            [textArr addObject:string];
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        NSString *string = [self emojiChangeUnicode:substring];
                                        [textArr addObject:string];
                                        
                                    }else{
                                        [textArr addObject:substring];
                                    }
                                }
                            }];
    returnString = [textArr componentsJoinedByString:@""];
    //    NSString *reurnS = [returnString stringByReplacingOccurrencesOfString:@"," withString:@""];
    return returnString;
}

+ (NSString *)stringContainsEmoji1:(NSString *)string
{
    NSMutableArray* textArr = [NSMutableArray array];
    NSString *returnString = nil;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                NSLog(@"%c",hs);
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            NSString *string = [self emojiChangeUnicode:substring];
//                                            [textArr addObject:string];
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        NSString *string = [self emojiChangeUnicode:substring];
//                                        [textArr addObject:string];
                                        
                                    }else{
                                        [textArr addObject:substring];
                                    }
                                }
                            }];
    returnString = [textArr componentsJoinedByString:@""];
    //    NSString *reurnS = [returnString stringByReplacingOccurrencesOfString:@"," withString:@""];
    return returnString;
}

+(NSString *)emojiChangeUnicode:(NSString *)str
{
    
    NSString *hexstr = @"";
    
    for (int i=0;i< [str length];i++)
    {
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%1X ",[str characterAtIndex:i]]];
    }
    hexstr = @"";
    int slen = strlen([str UTF8String]);
    for (int i = 0; i < slen; i++)
    {
        //fffffff0 去除前面六个F & 0xFF
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%X ",[str UTF8String][i] & 0xFF ]];
    }
    
    hexstr = @"";
    
    if ([str length] >= 2) {
        
        for (int i = 0; i < [str length] / 2 && ([str length] % 2 == 0) ; i++)
        {
            // three bytes
            if (([str characterAtIndex:i*2] & 0xFF00) == 0 ) {
                hexstr = [hexstr stringByAppendingFormat:@"Ox%1X 0x%1X",[str characterAtIndex:i*2],[str characterAtIndex:i*2+1]];
            }
            else
            {
                // four bytes
                hexstr = [hexstr stringByAppendingFormat:@"%1X ",MULITTHREEBYTEUTF16TOUNICODE([str characterAtIndex:i*2],[str characterAtIndex:i*2+1])];
            }
            
        }
    }
    else
    {
        NSLog(@"(unicode) U+%1X",[str characterAtIndex:0]);
    }
    NSString *  replace = [hexstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger i = strtoul([replace UTF8String],0,16);
    NSString * emojiS= [NSString stringWithFormat:@"&#%ld;",(unsigned long)i];
    return emojiS;
}
@end



