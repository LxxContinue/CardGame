//
//  RankTableViewCell.m
//  CardGame
//
//  Created by LXX on 2019/9/29.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 12;
    frame.origin.x += 15;
    frame.origin.y += 6;
    frame.size.width -= 30;
    
    [super setFrame:frame];
}

-(void)setUpUI {
    self.layer.cornerRadius = 7;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    
}

+(instancetype)cellInit:(UITableView *)tableView{
    static NSString *identifier=@"RankTableViewCell";
    RankTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"RankTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

@end
