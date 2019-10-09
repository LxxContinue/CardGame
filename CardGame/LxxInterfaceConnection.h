//
//  LxxInterfaceConnection.h
//  CardGame
//
//  Created by LXX on 2019/9/28.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NetURL1  @"http://xyt.fzu.edu.cn:54321/v1/%@"
#define NetURL @"http://shisanshui.rtxux.xyz/%@"

NS_ASSUME_NONNULL_BEGIN

@interface LxxInterfaceConnection : NSObject
//获取连接接口的单例

-(void)stopSession;//结束当前会话
//v2版本接口
-(void)connetNetWithHaddleV2:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type needToken:(BOOL)needToken block:(void(^)(int fail,NSString *dataMessage,NSDictionary *dictionary))block;
//v2get请求
-(void)connetNetWithGetMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger) type block:(void (^)(int, NSString *, NSDictionary *))block;
-(void)connetNetWithPutMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger) type block:(void (^)(int, NSString *, NSDictionary *))block;
-(void)connetNetWithDeleteMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type block:(void (^)(int, NSString *, NSDictionary *))block;
-(void)connetNetWithHaddle:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type  block:(void(^)(int fail,NSString *dataMessage,NSDictionary *dictionary))block;//handle为接口类型，如@“CourseHandler”，parms为参数键值对，loginOut表示当前用户失效，fail为获取数据的成功性，fail＝0表示成功，fail＝1表示未成功，fail＝2表示无网未成功，dataMessage为错误信息，dictionary为从服务器端得到的数据字典
//-(void)hudToView:(UIView *)view connetNetWithHaddle:(NSString *)handle parms:(NSDictionary *)params block:(void(^)(int fail,NSString *dataMessage,NSDictionary *dictionary))block;
-(void)sendImageWithImage:(UIImage *)img block:(void(^)(NSString * imageId, BOOL isFailed))block;
//添加加载框的联网


@end

NS_ASSUME_NONNULL_END
