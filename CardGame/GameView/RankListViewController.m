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

@property (nonatomic,strong) NSURL *location;

@end

@implementation RankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadLocation];
    
    
    [self dataConfiguration];
    [self creatTabelView];
}
-(void)loadLocation{
    NSURLSession *session = [NSURLSession sharedSession];

    NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/rank/rank.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {

        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;

        self.location = res.URL;
        
        //NSLog(@"head: %@\n",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"res: %@",res);
        
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"login返回正确：%@",arr);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadData];
        });
    }];
    [dataTask resume];
}

-(void)loadData{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.location];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {

        
        self.rankArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"login返回正确：%@",self.rankArr);
        

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
    [dataTask resume];
}

#pragma mark - Private DataConfiguration
- (void)dataConfiguration{
    self.rankArr = [[NSMutableArray alloc]init];
    self.location =[[NSURL alloc]init];
}


-(void)creatTabelView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50,80, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)];
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
    
    return self.rankArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [RankTableViewCell cellInit:self.tableView];
    
    NSDictionary *playerDic = self.rankArr[indexPath.row];
    
    cell.userID.text = [NSString stringWithFormat:@"%@",[playerDic objectForKey:@"player_id"]];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",[playerDic objectForKey:@"name"]];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[playerDic objectForKey:@"score"]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)popAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
