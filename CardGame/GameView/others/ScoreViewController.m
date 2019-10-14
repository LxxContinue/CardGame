//
//  ScoreViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/29.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)popAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)newGameAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
