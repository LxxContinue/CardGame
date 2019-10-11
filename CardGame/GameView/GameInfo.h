//
//  GameInfo.h
//  CardGame
//
//  Created by LXX on 2019/10/11.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface GameInfo : NSObject

@property (nonatomic) NSString *playerId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *score;
@property (nonatomic) NSArray *card;

-(instancetype) initWithNSDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
