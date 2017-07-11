#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

typedef void (^FinishBlock)(id dataString);
typedef void (^ErrorBlock)(NSError *error);


@interface BaseService : NSObject{
    
}
@property (strong, nonatomic) FinishBlock finishBlock;//成功时返回信息
@property (strong, nonatomic) ErrorBlock errorBlock;//失败时返回信息

/*
 post请求方式 只提交数据
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)postRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock;
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
+(void)postRequest:(NSString *)parameter :(NSDictionary *)parameters :(NSMutableArray *)filePaths finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock;
/*
 get请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)getRequest:(NSString *)parameter :(NSDictionary *)_parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock;


/*
 DELETE请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)deleteRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock;

/*
 PUT请求方式
 parameter 请求的地址，注意，只需要接口中的哪个方法，不需要全部的URL
 parameters 参数
 
 */
+(void)putRequest:(NSString *)parameter :(NSDictionary *)parameters finshedBlock:(FinishBlock)finishBlock ErrorBlock:(ErrorBlock) errorBlock;

+(void)showMesg:(NSString*)myMessage;
+(NSString *)md5:(NSString*)str;
+(NSString*)sha1:(NSString*)str;
//生成完整安全秘钥
+(NSString*)headerKey;
//生成应用验证安全秘钥
+(NSString*)headerKey1;
//获取帐号
+(NSString*)getPhoneNumber;
//获取当前时间戳
+(NSString*)getTimeString;
//验证手机号码
+(BOOL)checkNumber:(NSString*)phone;
/*
 1.当全是汉字时，显示后两个汉字，例如：涂华远，彩圈里面显示“华远”
 2.当不含汉字，只有字母，数字，其他字符时，显示前两个。例如：a123，彩圈里面显示“a1”
 3.当含有汉字和其他字符时
 3.1当汉字大于等于2时，显示汉字里的最后两个，例如：吴三桂123，彩圈显示“三桂”
 3.2当汉字小于2时，显示汉字和其后的一个字符，例如：吴123，彩圈显示“吴1”
 3.3汉字只有1个，且汉字后无字符，显示汉字和其前方的字符。例如：123张，彩圈显示“3张”
 3.2当汉字分开时，忽略其他字符，显示后两个汉字，例如：张叁a1李1aa王，取李王。
 */
+(NSString*)getHeadImageText:(NSString*)name;
//替换表情
+ (NSString *)stringContainsEmoji:(NSString *)string;
+ (NSString *)stringContainsEmoji1:(NSString *)string;
+(NSString *)emojiChangeUnicode:(NSString *)str;
@end
