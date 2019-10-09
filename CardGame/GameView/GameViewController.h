//
//  GameViewController.h
//  CardGame
//
//  Created by LXX on 2019/9/22.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;

@property (nonatomic) NSString * cardStr ;
@property (nonatomic) NSString * gameID ;
@end

NS_ASSUME_NONNULL_END
