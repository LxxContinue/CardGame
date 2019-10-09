//
//  RankListViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/22.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "RankListViewController.h"
#import "RankTableViewCell.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface RankListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *rankArr;

@end

@implementation RankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    UILabel *titile = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 10, 100, 50)];
    titile.text = @"英雄榜";
    titile.textColor = [UIColor redColor];
    titile.textAlignment = NSTextAlignmentCenter;
    titile.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:titile];
    
    [self dataConfiguration];
    [self creatTabelView];
    
}
-(void)loadData{
    //1.创建NSURLSession对象（可以获取单例对象）
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据NSURLSession对象创建一个Task
    
    NSURL *url = [NSURL URLWithString:@"http://shisanshui.rtxux.xyz/game/rank"];
    
//    NSString* URLString = @"http://www.baidu.com";
//    NSURL *url = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"HEAD"];
    
    //方法参数说明
    /*
     注意：该block是在子线程中调用的，如果拿到数据之后要做一些UI刷新操作，那么需要回到主线程刷新
     第一个参数：需要发送的请求对象
     block:当请求结束拿到服务器响应的数据时调用block
     block-NSData:该请求的响应体
     block-NSURLResponse:存放本次请求的响应信息，响应头，真实类型为NSHTTPURLResponse
     block-NSErroe:请求错误信息
     */
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        //拿到响应头信息
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        //4.解析拿到的响应数据
        NSLog(@"head: %@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
    }];
    
    //3.执行Task
    //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask resume];
    
}


#pragma mark - Private DataConfiguration
- (void)dataConfiguration{
    self.rankArr = [[NSMutableArray alloc]init];

}


-(void)creatTabelView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50,50, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if(!cell){
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
//    }
//    cell.textLabel.text = @"name";
//    cell.detailTextLabel.text = @"score";
    
    RankTableViewCell *cell = [RankTableViewCell cellInit:self.tableView];
    
    cell.userID.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.contentLabel.text = [NSString stringWithFormat:@"luzhiyang03170240%ld",(long)indexPath.row+1];
    cell.scoreLabel.text = @"100";
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)popAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
