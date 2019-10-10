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

@interface RootViewController ()

@property (nonatomic) NSString * token ;
@property (nonatomic) UserInfo *userInfo;

@end
static const CGFloat kTimeOutTime = 20.f;

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    _userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    self.token = _userInfo.token;
    
    
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
    RankListViewController *rc = [[RankListViewController alloc]init];
    [self presentViewController:rc animated:YES completion:nil];
}
- (IBAction)historyAction:(UIButton *)sender {
    NSLog(@"点击历史战局");
    HistoryViewController *hc = [[HistoryViewController alloc]init];

    // 1.创建请求
    //NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/history"];

    NSString *urlStr = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history?player_id=%@&page=%@&limit=%@",self.userInfo.user_id,@"0",@"10"];
    
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
            
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"history返回正确：%@",arr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                hc.cardStr = [cardDic objectForKey:@"card"];
//                [self presentViewController:hc animated:YES completion:nil];
                
                

            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
    
    
    //[self presentViewController:hc animated:YES completion:nil];
}




@end
