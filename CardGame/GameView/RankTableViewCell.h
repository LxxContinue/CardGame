//
//  RankTableViewCell.h
//  CardGame
//
//  Created by LXX on 2019/9/29.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

+(instancetype)cellInit:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
