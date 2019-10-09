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
    // Initialization code
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

+(instancetype)cellInit:(UITableView *)tableView{
    static NSString *identifier=@"RankTableViewCell";
    RankTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"RankTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

@end
