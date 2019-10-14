//
//  HisDetailViewController.m
//  CardGame
//
//  Created by LXX on 2019/10/11.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "HisDetailViewController.h"
#import "RankTableViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface HisDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HisDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTabelView];
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
    
    return self.detailArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [RankTableViewCell cellInit:self.tableView];
    
    NSDictionary *gameDic = self.detailArr[indexPath.row];
    
    cell.userID.text = [NSString stringWithFormat:@"%@",[gameDic objectForKey:@"name"]];
    
    NSArray *card = [gameDic objectForKey:@"card"];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@ , %@ , %@",card[0],card[1],card[2]];
    
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[gameDic objectForKey:@"score"]];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)popAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
