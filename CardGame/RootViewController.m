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

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)beginGameAction:(UIButton *)sender {
    GameViewController *gc = [[GameViewController alloc]init];
    [self presentViewController:gc animated:YES completion:nil];
}
- (IBAction)rankingListAction:(UIButton *)sender {
    HistoryViewController *hc = [[HistoryViewController alloc]init];
    [self presentViewController:hc animated:YES completion:nil];
}
- (IBAction)historyAction:(UIButton *)sender {
    RankListViewController *rc = [[RankListViewController alloc]init];
    [self presentViewController:rc animated:YES completion:nil];
}
- (IBAction)personViewAction:(UIButton *)sender {
    PersonalViewController *pc = [[PersonalViewController alloc]init];
    [self presentViewController:pc animated:YES completion:nil];
}
- (IBAction)taskViewAction:(UIButton *)sender {
    TaskViewController *tc = [[TaskViewController alloc]init];
    [self presentViewController:tc animated:YES completion:nil];
    
}


@end
