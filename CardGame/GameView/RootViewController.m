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
#import "UserInfo.h"

#import "LxxInterfaceConnection.h"

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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIButton *button = [[UIButton alloc]init];
    //[self beginGameAction:button];
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

- (IBAction)rankingListAction:(UIButton *)sender {
    RankListViewController *rc = [[RankListViewController alloc]init];
    [self presentViewController:rc animated:YES completion:nil];
}
- (IBAction)historyAction:(UIButton *)sender {
    NSLog(@"点击历史战局");
    
    NSMutableDictionary * parm = [[NSMutableDictionary alloc]init];
    [parm setObject:@"1" forKey:@"page"];
    [parm setObject:self.userInfo.user_id forKey:@"player_id"];
    [parm setObject:@"100" forKey:@"limit"];
    
//    NSString *rul = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history"];
    NSString *rul = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history?player_id=%@&limit=%@&page=%@",self.userInfo.user_id,@"20",@"100"];
    
    LxxInterfaceConnection *connect = [[LxxInterfaceConnection alloc] init];
    [connect connetNetWithGetMethod:rul parms:parm block:^(int fail,NSString *dataMessage,NSDictionary *dictionary) {
        if (fail ==0) {
            NSMutableArray *hisArr = [[NSMutableArray alloc]init];
            hisArr = [dictionary objectForKey:@"data"];
            
            NSLog(@"!!!count :%lu",(unsigned long)hisArr.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                HistoryViewController *hc = [[HistoryViewController alloc]init];
                hc.hisArr = hisArr;
                [self presentViewController:hc animated:YES completion:nil];
            });
        }
    }];

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
