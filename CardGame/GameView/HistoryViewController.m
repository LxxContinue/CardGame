//
//  HistoryViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/22.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "HistoryViewController.h"
#import "RankTableViewCell.h"
#import "HisDetailViewController.h"
#import "UserInfo.h"
#import "LxxInterfaceConnection.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) NSString * token ;
@property (nonatomic) UserInfo *userInfo;


@end


@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self dataConfiguration];
    [self creatTabelView];
}

#pragma mark - Private DataConfiguration
- (void)dataConfiguration{
    
}

-(void)creatTabelView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50,80, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hisArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [RankTableViewCell cellInit:self.tableView];
    
    NSDictionary *gameDic = self.hisArr[indexPath.row];
    
    cell.userID.text = [NSString stringWithFormat:@"%@",[gameDic objectForKey:@"id"]];
    
    NSArray *card = [gameDic objectForKey:@"card"];
    if (card.count>=3) {
        NSString *card1 = [NSString stringWithFormat:@"%@",card[0]];
        NSString *card2 = [NSString stringWithFormat:@"%@",card[1]];
        NSString *card3 = [NSString stringWithFormat:@"%@",card[2]];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@ , %@ , %@",card1,card2,card3];
    }
    else{
        cell.contentLabel.text = @"牌数有错误";
    }
    
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[gameDic objectForKey:@"score"]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *gameDic = self.hisArr[indexPath.row];
    NSString *url = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history/%@",[gameDic objectForKey:@"id"]];
    NSDictionary *dic = [[NSDictionary alloc]init];
    LxxInterfaceConnection *connect = [[LxxInterfaceConnection alloc] init];
    [connect connetNetWithGetMethod:url parms:dic block:^(int fail,NSString *dataMessage,NSDictionary *dictionary) {
        
            NSMutableArray *detailArr =[[NSMutableArray alloc]init];
            if(fail == 0){
                NSDictionary *dict = [dictionary objectForKey:@"data"];
                detailArr = [dict objectForKey:@"detail"];
                NSLog(@"detail: %lu",(unsigned long)detailArr.count);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    HisDetailViewController *dvc = [[HisDetailViewController alloc]init];
                    dvc.detailArr = detailArr;
                    [self presentViewController:dvc animated:YES completion:nil];
                });
            }

    }];
    
//    NSDictionary *gameDic = self.hisArr[indexPath.row];
//    NSLog(@"点击战局详情");
//    NSLog(@"game id: %@",[gameDic objectForKey:@"id"]);
//    // 1.创建请求
//    NSString *urlStr = [NSString stringWithFormat: @"https://api.shisanshui.rtxux.xyz/history/%@",[gameDic objectForKey:@"id"]];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
//    request.HTTPMethod = @"GET";
//    // 2.设置请求头
//    [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    // 4.发送请求
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        if (!error) {
//            NSDictionary *dictionary=[self readJsonData:data];
//            NSLog(@"历史战局详情：%@",dictionary);
//
//            NSMutableArray *detailArr =[[NSMutableArray alloc]init];
//            if([[dictionary objectForKey:@"status"] integerValue] == 0){
//                NSDictionary *dict = [dictionary objectForKey:@"data"];
//                detailArr = [dict objectForKey:@"detail"];
//                NSLog(@"detail: %lu",(unsigned long)detailArr.count);
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if([[dictionary objectForKey:@"status"] integerValue] == 0){
//                    HisDetailViewController *dvc = [[HisDetailViewController alloc]init];
//                    dvc.detailArr = detailArr;
//                    [self presentViewController:dvc animated:YES completion:nil];
//                }
//            });
//
//        }else{
//            NSLog(@"错误信息：%@",error);
//        }
//    }];
//    [dataTask resume];
}

- (IBAction)popAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
