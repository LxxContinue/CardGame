//
//  RootViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/22.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "RootViewController.h"
#import "GameViewController.h"
#import "HistoryViewController.h"
#import "RankListViewController.h"
#import "PersonalViewController.h"
#import "TaskViewController.h"
#import "UserInfo.h"
#import "GameInfo.h"

@interface RootViewController ()

@property (nonatomic) NSString * token ;
@property (nonatomic) UserInfo *userInfo;
@property (nonatomic) NSInteger count;

@end
static const CGFloat kTimeOutTime = 30.f;

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    _userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    self.token = _userInfo.token;
    
    self.count = 3400;
}
- (IBAction)beginGameAction:(UIButton *)sender {
    GameViewController *gc = [[GameViewController alloc]init];

    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/game/open"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"POST";
    // 2.设置请求头
    [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    // 3.设置请求体
    
    // 4.发送请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    //__block  NSString *result = @"";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *cardDic = [[NSDictionary alloc]initWithDictionary:[dict objectForKey:@"data"]];
            NSLog(@"id:%@  card:%@",[cardDic objectForKey:@"id"],[cardDic objectForKey:@"card"]);
            
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"beginGame返回正确：%@",arr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                gc.cardStr = [cardDic objectForKey:@"card"];
                gc.gameID = [cardDic objectForKey:@"id"];
                
                [self presentViewController:gc animated:YES completion:nil];
            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
}
- (IBAction)taskViewAction:(UIButton *)sender {
    TaskViewController *tc = [[TaskViewController alloc]init];
    [self presentViewController:tc animated:YES completion:nil];
}
- (IBAction)personViewAction:(UIButton *)sender {
    PersonalViewController *pc = [[PersonalViewController alloc]init];
    [self presentViewController:pc animated:YES completion:nil];
}
- (IBAction)rankingListAction:(UIButton *)sender {
//    RankListViewController *rc = [[RankListViewController alloc]init];
//    [self presentViewController:rc animated:YES completion:nil];
    
    NSLog(@"点击战局详情");
    // 1.创建请求
    NSLog(@"%ld",(long)self.count);
    NSString *urlStr = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history/%ld",(long)_count];
    self.count++;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"GET";
    // 2.设置请求头
    [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 4.发送请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
//            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//            NSLog(@"历史战局详情：%@",arr);
            
            NSDictionary *dictionary=[self readJsonData:data];
            NSLog(@"历史战局详情：%@",dictionary);
            NSLog(@"id 返回正确：%@",[dictionary objectForKey:@"id"]);
            
//            NSMutableArray *playerArr = [[NSMutableArray alloc]init];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSArray *gameArr = [dict objectForKey:@"detail"];
////            for (NSDictionary *Dic in dict) {
////                GameInfo *Info = [[GameInfo alloc] initWithNSDictionary:Dic];
////                [playerArr addObject:Info];
////            }
//            NSLog(@"diccount：%lu",(unsigned long)dict.count);
//            NSLog(@"arrcount：%lu",(unsigned long)gameArr.count);
//            NSLog(@"id 返回正确：%@",[dict objectForKey:@"id"]);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{

                //NSLog(@"player count %lu",(unsigned long)playerArr.count);
            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
    
}
- (IBAction)historyAction:(UIButton *)sender {
    NSLog(@"点击历史战局");

    // 1.创建请求
    //NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/history"];

    NSString *urlStr = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history?player_id=%@&limit=%@&page=%@",self.userInfo.user_id,@"10",@"0"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"GET";
    // 2.设置请求头
    [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3.设置请求体
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:self.userInfo.user_id forKey:@"player_id"];
//    [dic setObject:@"1" forKey:@"limit"];
//    [dic setObject:@"1" forKey:@"page"];
//
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
//    request.HTTPBody = data;
    
    
    // 4.发送请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//            NSDictionary *cardDic = [[NSDictionary alloc]initWithDictionary:[dict objectForKey:@"data"]];
//            NSLog(@"id:%@  card:%@",[cardDic objectForKey:@"id"],[cardDic objectForKey:@"score"]);
            
//            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//            NSLog(@"history返回正确：%@",arr);
            
            
            
            NSDictionary *dictionary = [self readJsonData:data];
            NSLog(@"game  %@",dictionary);
            
            NSMutableArray *hisArr = [[NSMutableArray alloc]init];
            hisArr = [dictionary objectForKey:@"data"];
            
            NSLog(@"count :%lu",(unsigned long)hisArr.count);
            
            //            NSMutableArray *playerArr = [[NSMutableArray alloc]init];
            //            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //            NSArray *gameArr = [dict objectForKey:@"detail"];
            ////            for (NSDictionary *Dic in dict) {
            ////                GameInfo *Info = [[GameInfo alloc] initWithNSDictionary:Dic];
            ////                [playerArr addObject:Info];
            ////            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                HistoryViewController *hc = [[HistoryViewController alloc]init];
                hc.hisArr = hisArr;
                [self presentViewController:hc animated:YES completion:nil];
            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
    
    //HistoryViewController *hc = [[HistoryViewController alloc]init];
    //[self presentViewController:hc animated:YES completion:nil];
}

#pragma mark - readJson
-(NSDictionary *)readJsonData:data
{
    NSError *error;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error)
    {
        NSLog(@"json解析失败:%@",error);
        return nil;
    }
    return dictionary;

}




@end
