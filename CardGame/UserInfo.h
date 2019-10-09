//
//  UserInfo.h
//  CardGame
//
//  Created by LXX on 2019/10/9.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic) NSString *token;
@property (nonatomic) NSString *user_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *score;

   -(instancetype) initWithNSDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
