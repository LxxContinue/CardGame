//
//  LxxInterfaceConnection.h
//  CardGame
//
//  Created by LXX on 2019/9/28.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NetURL @"http://shisanshui.rtxux.xyz/%@"

NS_ASSUME_NONNULL_BEGIN

@interface LxxInterfaceConnection : NSObject

-(void)connetNetWithPostMethod:(NSString *)handle parms:(NSDictionary *)params needToken:(BOOL)needToken block:(void(^)(int fail,NSString *dataMessage,NSDictionary *dictionary))block;

-(void)connetNetWithGetMethod:(NSString *)handle parms:(NSDictionary *)params block:(void (^)(int, NSString *, NSDictionary *))block;

@end

NS_ASSUME_NONNULL_END
