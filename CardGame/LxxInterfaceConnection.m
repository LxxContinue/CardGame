//
//  LxxInterfaceConnection.m
//  CardGame
//
//  Created by LXX on 2019/9/28.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "LxxInterfaceConnection.h"

@interface LxxInterfaceConnection()

@property (nonatomic) NSString * POST_ID;
@property BOOL endSession;
@property  NSURLSession *session;
@property (nonatomic) NSString * token ;

@end

const CGFloat kTimeOutTime = 10.f;

@implementation LxxInterfaceConnection
-(NSString *)POST_ID {
    if(_POST_ID) {
        return _POST_ID;
    } else {
        return @"iOS";
    }
}

- (id)init {
    self = [super init];
    if(self) {
        //创建会话
        self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
//        NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//        UserInfo * userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
//        self.token = userInfo.access_token;
    }
    return self;
}

-(void)stopSession{
    
    //结束会话
    [self.session invalidateAndCancel];
    self.session=nil;
    self.endSession=YES;
    // _session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];//sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

//-(void)hudToView:(UIView *)view connetNetWithHaddle:(NSString *)handle parms:(NSDictionary *)params block:(void(^)(int fail,NSString *dataMessage,NSDictionary *dictionary))block{
//    __block MBProgressHUD *hud;
//    hud= [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText =@"正在获取消息...";
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
//    self.endSession=NO;
//    NSString *urlString=[NSString stringWithFormat:NetURL,
//                         handle];
//    NSArray *keys=[params allKeys];
//    NSString *content =@"";
//    if(keys.count>0)
//        content=[NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
//    if(keys.count>1)
//        for(int i=1;i<keys.count;i++)
//        {
//            content=[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
//        }
//    if(!self.session)
//        self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
//    __weak YXJInterfaceConnection *weakSelf = self;
//    [self connectWithSession:self.session URL:urlString params:params type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            hud.hidden=YES;
//            [hud removeFromSuperview];
//            hud=nil;
//        });
//        if(block&&!weakSelf.endSession)
//        {
//            block(fail,dataMessage,dictionary);
//
//            // self.stopSession=NO;
//        }
//
//    }];
//}

//type=0 获取新闻
#pragma mark - oldVersionConnect
-(void)connetNetWithHaddle:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type block:(void (^)(int, NSString *, NSDictionary *))block  {
    self.endSession=NO;
    NSString *urlString = @"";
    NSArray *keys=[params allKeys];
    NSString *content =@"";
    if(keys.count>0)
        content=[NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
    
    if(keys.count>1)
        for(int i=1;i<keys.count;i++)
        {
            content=[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
        }
    NSLog(@"contentStr:%@",content);
    if(!self.session)
        self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    if(type == 1)
    {
        urlString = [NSString stringWithFormat:NetURL1,handle];
        NSLog(@"urlStr:%@",urlString);
        [self connectWithSession:self.session URL:urlString params:params type:type block:^(int dataStatus, NSString * dataMessage,NSDictionary *dictionary){
            /*********************************************************************/
            if(block&&!self.endSession)
            {
                block(dataStatus,dataMessage,dictionary);
            }
            
        }];
    }
    else
    {
        urlString  = [NSString stringWithFormat:NetURL,handle];
        if(keys.count>1)
            for(int i=1;i<keys.count;i++)
            {
                content=[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
            }
        NSLog(@"***conten1t:%@",content);
        [self connectWithSession:self.session URL:urlString content:content type:type block:^(int dataStatus, NSString * dataMessage,NSDictionary *dictionary){
            /*********************************************************************/
            if(block&&!self.endSession)
            {
                block(dataStatus,dataMessage,dictionary);
            }
        }];
    }
    //    NSArray *keys=[params allKeys];
    //    NSString *content =@"";
    //    if(keys.count>0)
    //        content=[NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
    //    if(keys.count>1)
    //    for(int i=1;i<keys.count;i++)
    //    {
    //        content=[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
    //    }
    
    //    [self connectWithSession:self.session URL:urlString params:params  block:^(int dataStatus, NSString * dataMessage,NSDictionary *dictionary){
    //    /*********************************************************************/
    //        if(block&&!self.endSession)
    //        {
    //            block(dataStatus,dataMessage,dictionary);
    //        }
    //
    //    }];
    
    //NSString *content=[NSString stringWithFormat:@"=%@&xh=%@&token=%@",methodType,xh,token];
}

-(void)connectWithSession:(NSURLSession *)session URL:(NSString *)url content:(NSString *)content type:(NSInteger)type block:(void(^)(int dataStatus, NSString * dataMessage,NSDictionary *dictionary))block
{
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    NSURL *urll=[NSURL URLWithString:url];
    //    NSLog(@"777%@ params:%@",urll,content);
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urll cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    //    NSLog(@"***content:%@",[content dataUsingEncoding:NSUTF8StringEncoding]);
    if(![content isEqual:@""])
        request.HTTPBody=[content dataUsingEncoding:NSUTF8StringEncoding];
    //request.HTTPMethod = @"POST";
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        if(error) {
            getFail=2;
            if([error.localizedDescription isEqualToString:@"请求超时。"]||[error.localizedDescription isEqualToString:@"The request timed out."]){
                NSLog(@"time out url:%@",url);
                dataMessage=@"连接服务器超时，请稍后重试！";
            } else {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
            }
            if(block) {
                block(getFail,dataMessage,nil);
            }
            return;
        } else {
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"errCode"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errCode"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            if(!([str isEqualToString:@"0"])) {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errMsg"]];
                if([dictionary objectForKey:@"errMsg"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"]) {
                    dataMessage = @"登录已过期，请重新登录";
                }
            }
            if(block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
            }
        }
    }];
    [task resume];
}


-(void)connectWithSession:(NSURLSession *)session URL:(NSString *)url params:(NSDictionary *)params type:(NSInteger)type block:(void(^)(int dataStatus, NSString * dataMessage,NSDictionary *dictionary))block
{
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    NSURL *urll=[NSURL URLWithString:url];
    //NSLog(@"777%@ params:%@",urll,params);
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urll cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    
    //    if(![content isEqual:@""])
    //        request.HTTPBody=[content dataUsingEncoding:NSUTF8StringEncoding];
    //
    if(params)
    {
        if(![request valueForHTTPHeaderField:@"Content-Type"])
        {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        NSError *error;
        if(type == 1)
        {
            [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:&error]];
            //            NSLog(@"jsonData:%@",[NSJSONSerialization dataWithJSONObject:params options:0 error:&error]);
        }
        
    }
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        NSLog(@"handle:%@",url);
        if(error)
        {
            
            getFail=2;
            
            if([error.localizedDescription isEqualToString:@"请求超时。"]){
                NSLog(@"time out url:%@",url);
                dataMessage=@"连接服务器超时，请稍后重试！";
            }
            else
            {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
            }
            if(block) {
                block(getFail,dataMessage,nil);
            }
            return;
        } else {
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"errCode"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errCode"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            if(!([str isEqualToString:@"0"])) {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errMsg"]];
                if([dictionary objectForKey:@"errMsg"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"]) {
                    dataMessage = @"登录已过期，请重新登录";
                }
                //                if([str isEqualToString:@"11"])
                //                {
                //                    dataMessage = @"手机号已经注册";
                //                }
                //                else if([str isEqualToString:@"12"])
                //                {
                //                    dataMessage = @"发送验证码失败，请稍后重试";
                //                }
                //                if([str isEqualToString:@"1"])
                //                {
                //
                //                /Users/zhangdemao/Code/SchoolFellow/newSchool/SchoolFriendGather/YXJInterfaceConnection.m    loginOut=YES;
                //                    dataMessage=@"你的会话已过期，请重新登录";
                //                }
                //                else{
                //                    if([dictionary objectForKey:@"message"])
                //                        dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"message"]];
                //                    else if([dictionary objectForKey:@"msg"])
                //                        dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"msg"]];
                //                    else
                //                        dataMessage=@"获取数据失败";
                //
                //
                //                }
                
            }
            if(block)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
                
            }
        }
        
    }];
    [task resume];
}

/**
 新版接口函数
 
 @param handle url 后半段
 @param params 参数字典
 @param type
 type = 1 : application/json
 type = 2 : application/x-www-form-urlencoded
 @param block 后台返回信息
 @param needToken yes:需要,false:不需要
 */
-(void)connetNetWithHaddleV2:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type needToken:(BOOL)needToken block:(void (^)(int, NSString *, NSDictionary *))block  {
    self.endSession = NO;
    NSString *urlString = @"";
    if(!self.session)
        self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    urlString = [NSString stringWithFormat:NetURL,handle];
    NSLog(@"urlString:%@",urlString);
    [self connectWithSessionV2:self.session URL:urlString params:params type:type needToken:needToken block:^(int dataStatus, NSString * dataMessage,NSDictionary *dictionary){
        if(block&&!self.endSession) {
            block(dataStatus,dataMessage,dictionary);
        }
    }];
}



#pragma mark - newVersionPostConnect
-(void)connectWithSessionV2:(NSURLSession *)session URL:(NSString *)url params:(NSDictionary *)params type:(NSInteger)type needToken:(BOOL)needToken block:(void(^)(int dataStatus, NSString * dataMessage,NSDictionary *dictionary))block {
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    NSURL *urll=[NSURL URLWithString:url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urll cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    if(needToken) {
        if(![request valueForHTTPHeaderField:@"Authorization"]) {
            [request setValue:self.token forHTTPHeaderField:@"Authorization"];
        }
/*添加的字段*/ [request setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
        NSLog(@"self.token:%@",self.token);
    }
    if(params) {
        NSError *error;
        if(type == 1) {
            if(![request valueForHTTPHeaderField:@"Content-Type"]) {
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:&error]];
            }
        } else if(type == 2) {
            //            [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:&error]];
            if(![request valueForHTTPHeaderField:@"Content-Type"]) {
                [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            }
            NSArray *keys=[params allKeys];
            NSString *content =@"";
            if(keys.count > 0) {
                content=[NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
            }
            if(keys.count > 1) {
                for(int i=1; i <keys.count;i++) {
                    content=[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
                }
            }
            NSLog(@"**contentStr:%@",content);
            NSMutableData *postBody=[NSMutableData data];
            [postBody appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
            request.HTTPBody = postBody;
            
            
            //            // Get NSString from NSData object in Base64
            //            NSString *base64Encoded = [postBody base64EncodedStringWithOptions:0];
            //            // Print the Base64 encoded string
            //            NSLog(@"Encoded: %@", base64Encoded);
            //            // NSData from the Base64 encoded str
            //            NSData *nsdataFromBase64String = [[NSData alloc]
            //                                              initWithBase64EncodedString:base64Encoded options:0];
            //            // Decoded NSString from the NSData
            //            NSString *base64Decoded = [[NSString alloc]
            //                                       initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
            //            NSLog(@"Decoded: %@", base64Decoded);
            
            //            NSMutableData *postBody=[NSMutableData data];
            //            [postBody appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
            //            NSString *base64Encoded = [postBody base64EncodedStringWithOptions:0];
            //            NSData *nsdataFromBase64String = [[NSData alloc]
            //                                              initWithBase64EncodedString:base64Encoded options:0];
            //
            //            request.HTTPBody = nsdataFromBase64String;
            
            
            
        }
    }
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        NSLog(@"handle:%@",url);
        if(error) {
            getFail=2;
            if([error.localizedDescription isEqualToString:@"请求超时。"]){
                NSLog(@"time out url:%@",url);
                dataMessage=@"连接服务器超时，请稍后重试！";
            } else {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
                NSLog(@"lxx error %@",error);
            }
            if(block) {
                block(getFail,dataMessage,nil);
            }
            return;
        } else {
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"status"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            NSLog(@"IamString status:%@",str);
            NSLog(@"rrrdata2:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            if(!([str isEqualToString:@"0"])) {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"message"]];
                if([dictionary objectForKey:@"message"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"]) {
                    dataMessage = @"登录已过期，请重新登录";
                }
            }
            if(block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
            }
        }
        
    }];
    [task resume];
}

#pragma mark - newVersionGetConnect

/* params 传参数
 type = 0 带token的GET请求
 */
-(void)connetNetWithGetMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type block:(void (^)(int, NSString *, NSDictionary *))block  {
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    NSString *urlStr = [NSString stringWithFormat:NetURL,handle];
    
    
    //设置请求头参数
    NSArray *keys=[params allKeys];
    NSString *content = @"";
    if(keys.count>0)
        content = [NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
    if(keys.count>1)
        for(int i=1;i<keys.count;i++)
        {
            content =[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
        }
    NSLog(@"contentStr:%@",content);
    if(![content isEqualToString:@""])
        urlStr = [NSString stringWithFormat:@"%@?%@",urlStr,content];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"GET";
    NSLog(@"&&&&& self.token:%@",self.token);
    if(type == 0)
        [request setValue:self.token forHTTPHeaderField:@"Authorization"];
    NSURLSession *sess = [NSURLSession sharedSession];
    //创建网络任务
    NSURLSessionDataTask *dataTask = [sess dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        NSLog(@"handle:%@",handle);
        if(error)
        {
            getFail=2;
            if([error.localizedDescription isEqualToString:@"请求超时。"]){
                NSLog(@"time out url:%@",url);
                dataMessage=@"连接服务器超时，请稍后重试！";
            }
            else
            {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
            }
            if(block)
            {
                block(getFail,dataMessage,nil);
            }
            return;
        }
        else{
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"status"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            NSLog(@"IamString%@  : url : %@",str,url );
            // NSMutableString *strr=[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            
            NSLog(@"rrrdata2:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            if(!([str isEqualToString:@"0"]))
            {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"message"]];
                if([dictionary objectForKey:@"message"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"])
                {
                    dataMessage = @"登录已过期，请重新登录";
                    //                    dispatch_async(dispatch_get_main_queue(), ^{
                    //                        LoginViewController *lvc = [[LoginViewController alloc] init];
                    //                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                    //
                    //                        AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
                    //                        delegete.window.rootViewController = nav;
                    //                    });
                    
                }
            }
            if(block)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
                
            }
        }
        
    }];
    [dataTask resume];
}
/* params 传参数
 type = 0 带token的PUT请求
 type = 2 application/x-www-form-urlencoded 的put请求
 */
-(void)connetNetWithPutMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type block:(void (^)(int, NSString *, NSDictionary *))block  {
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    
//**    NSString *urlStr = [NSString stringWithFormat:NetURL,handle];
    NSString *urlStr = [NSString stringWithFormat:@"%@", handle];
    
    //设置请求头参数
    NSString *content = @"";
    //    if(keys.count>0) {
    //        content = [NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
    //    }
    //    if(keys.count>1) {
    //        for(int i=1;i<keys.count;i++) {
    //            content =[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
    //        }
    //    }
    NSLog(@"contentStr:%@",content);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"PUT";
    content = [self convertToJsonData:params];
    NSLog(@"contentStr:%@",content);
    NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    if(type == 2) {
        //设置请求头参数
        NSArray *keys=[params allKeys];
        NSString *myContent = @"";
        if(keys.count>0)
            myContent = [NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
        if(keys.count>1) {
            for(int i=1;i<keys.count;i++) {
                myContent =[NSString stringWithFormat:@"%@&%@=%@",myContent,keys[i],[params objectForKey:keys[i]]];
            }
        }
        NSLog(@"contentStr:%@",myContent);
        if(![request valueForHTTPHeaderField:@"Content-Type"]) {
            [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        [request setValue:self.token forHTTPHeaderField:@"Authorization"];
        NSData *myData = [myContent dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = myData;
    } else {
        if(![request valueForHTTPHeaderField:@"Content-Type"]) {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        if(type == 0) {
            
//**            [request setValue:self.token forHTTPHeaderField:@"Authorization"];
            
        }
        request.HTTPBody = data;
    }
    NSURLSession *sess = [NSURLSession sharedSession];
    //创建网络任务
    NSURLSessionDataTask *dataTask = [sess dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        NSLog(@"handle:%@",handle);
        if(error) {
            getFail=2;
            if([error.localizedDescription isEqualToString:@"请求超时。"]){
                NSLog(@"time out url:%@",url);
                dataMessage=@"连接服务器超时，请稍后重试！";
            } else {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
            }
            if(block) {
                block(getFail,dataMessage,nil);
            }
            return;
        } else {
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"status"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            NSLog(@"IamString%@  : url : %@",str,url );
            // NSMutableString *strr=[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            
            NSLog(@"rrrdata2:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            if(!([str isEqualToString:@"0"])) {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"message"]];
                if([dictionary objectForKey:@"message"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"]) {
                    dataMessage = @"登录已过期，请重新登录";
                    //                    dispatch_async(dispatch_get_main_queue(), ^{
                    //                        LoginViewController *lvc = [[LoginViewController alloc] init];
                    //                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                    //
                    //                        AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
                    //                        delegete.window.rootViewController = nav;
                    //                    });
                    
                }
            }
            if(block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
                
            }
        }
        
    }];
    [dataTask resume];
}

/* params 传参数
 type = 0 带token的DELETE请求
 */
-(void)connetNetWithDeleteMethod:(NSString *)handle parms:(NSDictionary *)params type:(NSInteger)type block:(void (^)(int, NSString *, NSDictionary *))block  {
    __block BOOL getFail=0;
    __block NSString *dataMessage;
    NSString *urlStr = [NSString stringWithFormat:NetURL,handle];
    
    
    //设置请求头参数
    NSArray *keys=[params allKeys];
    NSString *content = @"";
    if(keys.count>0)
        content = [NSString stringWithFormat:@"%@=%@",keys[0],[params objectForKey:keys[0]]];
    if(keys.count>1)
        for(int i=1;i<keys.count;i++)
        {
            content =[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[params objectForKey:keys[i]]];
        }
    NSLog(@"contentStr:%@",content);
    if(![content isEqualToString:@""])
        urlStr = [NSString stringWithFormat:@"%@?%@",urlStr,content];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"DELETE";
    
    if(type == 0)
        [request setValue:self.token forHTTPHeaderField:@"Authorization"];
    NSURLSession *sess = [NSURLSession sharedSession];
    //创建网络任务
    NSURLSessionDataTask *dataTask = [sess dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"rrrdata:%@",error);
        NSLog(@"handle:%@",handle);
        if(error)
        {
            getFail=2;
            if([error.localizedDescription isEqualToString:@"请求超时。"]){
                dataMessage=@"连接服务器超时，请稍后重试！";
            }
            else
            {
                dataMessage=@"当前网络不可用，请检查您的网络设置!";
            }
            if(block)
            {
                block(getFail,dataMessage,nil);
            }
            return;
        }
        else{
            NSDictionary *dictionary=[self readJsonData:data];
            NSString *str = @"";
            if([dictionary objectForKey:@"status"]!=NULL)
                str=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
            else
                str = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errorcode"]];
            NSLog(@"IamString%@  : url : %@",str,url );
            // NSMutableString *strr=[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            
            NSLog(@"rrrdata2:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            if(!([str isEqualToString:@"0"]))
            {
                getFail=1;
                dataMessage=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"message"]];
                if([dictionary objectForKey:@"message"]==NULL)
                    dataMessage=@"获取数据失败";
                if([str isEqualToString:@"7"] || [str isEqualToString:@"403"])
                {
                    dataMessage = @"登录已过期，请重新登录";
                    //                    dispatch_async(dispatch_get_main_queue(), ^{
                    //                        LoginViewController *lvc = [[LoginViewController alloc] init];
                    //                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
                    //
                    //                        AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
                    //                        delegete.window.rootViewController = nav;
                    //                    });
                    
                }
            }
            if(block)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(getFail,dataMessage,dictionary);
                });
                
            }
        }
        
    }];
    [dataTask resume];
}

#pragma mark - readJson
-(NSDictionary *)readJsonData:data
{
    NSError *error;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error)
    {
        NSLog(@"json解析失败:%@",error);
        return nil;
    }
    return dictionary;
    
    //self.hud=[MBProgressHUD showMessage:[NSString stringWithFormat:@"%@",[self.dicionary objectForKey:@"message"]]];
    //[self.hud hide:YES afterDelay:0.7];
}

#pragma mark - updateImageData
//- (void)multiPartPost:(NSMutableDictionary *)dicData block:(void(^)(NSString * imageId))block
//{
//    NSLog(@"updatePic");
//    NSURL *url = [NSURL URLWithString:@"http://xyt.fzu.edu.cn/api/v1/files"];
//
//
//    NSMutableString *bodyContent = [NSMutableString string];
//
//    for(int i = dicData.allKeys.count-1 ;i>=0 ; i--)
//    {
//        NSLog(@"key:%@,value:%@",dicData.allKeys[i],[dicData valueForKey:dicData.allKeys[i]]);
//        NSString *key = dicData.allKeys[i];
//        NSLog(@"输出key中的内容>>%@",key);
//        if([key isEqualToString:@"access_token"])
//        {
//            NSLog(@"else update");
//            id value = [dicData objectForKey:key];
//            [bodyContent appendFormat:@"--%@\r\n",self.POST_BOUNDS];
//            [bodyContent appendFormat:@"Content-Disposition:form-data;name=\"%@\"\r\n\r\n",key];
//            [bodyContent appendFormat:@"%@\r\n",value];
//            NSLog(@"token_value:%@ ,输出content2中的内容>>\n%@",value,bodyContent);
//        }
//        else if([key isEqualToString:@"file1"])
//        {
//            id value = [dicData objectForKey:key];
//            [bodyContent appendFormat:@"--%@\r\n",self.POST_BOUNDS];
//            [bodyContent appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"pic.jpg\"\r\n",key];
//            [bodyContent appendFormat:@"Content-Type: image/jpeg\r\n\r\n"];
//            [bodyContent appendFormat:@"%@\r\n",value];
//            NSLog(@"输出content1中的内容>>\n%@",bodyContent);
//        }
//    }
//
//    [bodyContent appendFormat:@"--%@--\r\n",self.POST_BOUNDS];
//    NSData *bodyData = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
//    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",self.POST_BOUNDS] forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:bodyData];
//    NSLog(@"请求的长度:%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
//    NSLog(@"输出body中的内容>>\n%@",[[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding]);
//
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
//
//    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"rrrdata:%@",error);
//        if(error)
//        {
//            NSLog(@"出现异常:%@",error);
//            if(!block)
//            {
//                block(nil);
//            }
//        }
//        else
//        {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response ;
//            if(httpResponse.statusCode == 200)
//            {
//                NSLog(@"服务器成功响应!>>%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//                NSDictionary *dictionary=[self readJsonData:data];
//                NSLog(@"imageIds : %@",[[dictionary objectForKey:@"fileIds"] objectAtIndex:0]);
//                block([[dictionary objectForKey:@"fileIds"] objectAtIndex:0]);
//            }
//            else
//            {
//                NSLog(@"服务器返回失败!>>%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//            }
//        }
//
//    }] resume];
//}
//
//


-(void)sendImageWithImage:(UIImage *)img block:(void(^)(NSString * imageId ,BOOL isFailed))block{
    NSData *imageData;
    NSString *imageFormat;
    if (UIImagePNGRepresentation(img) != nil) {
        imageFormat = @"Content-Type: image/png \r\n";
        imageData = UIImagePNGRepresentation(img);
        
    }else{
        imageFormat = @"Content-Type: image/jpeg \r\n";
        imageData = UIImageJPEGRepresentation(img, 0.5);
        
    }
    NSString *string =[NSString stringWithFormat:NetURL,@"files"];
    NSURL *url = [NSURL URLWithString:string];
    //NSURL *url = [NSURL URLWithString:@"http://api.fzuxyt.com/v1/files"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"POST";
    //设置请求实体
    NSMutableData *body = [NSMutableData data];
    
    ///文件参数
    [body appendData:[self getDataWithString:@"--BOUNDARY\r\n" ]];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n",self.POST_ID];
    [body appendData:[self getDataWithString:disposition ]];
    [body appendData:[self getDataWithString:imageFormat]];
    [body appendData:[self getDataWithString:@"\r\n"]];
    [body appendData:imageData];
    [body appendData:[self getDataWithString:@"\r\n"]];
    //普通参数
    [body appendData:[self getDataWithString:@"--BOUNDARY\r\n" ]];
    //上传参数需要key： （相应参数，在这里是_myModel.personID）
    NSString *dispositions = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",@"key"];
    [body appendData:[self getDataWithString:dispositions ]];
    [body appendData:[self getDataWithString:@"\r\n"]];
    [body appendData:[self getDataWithString:_POST_ID]];
    [body appendData:[self getDataWithString:@"\r\n"]];
    
    //参数结束
    [body appendData:[self getDataWithString:@"--BOUNDARY--\r\n"]];
    request.HTTPBody = body;
    //设置请求体长度
    NSInteger length = [body length];
    [request setValue:[NSString stringWithFormat:@"%ld",(long)length] forHTTPHeaderField:@"Content-Length"];
    //设置 POST请求文件上传
    [request setValue:@"multipart/form-data; boundary=BOUNDARY" forHTTPHeaderField:@"Content-Type"];
    
    if(![request valueForHTTPHeaderField:@"Authorization"])
    {
        [request setValue:self.token forHTTPHeaderField:@"Authorization"];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"rrrdata:%@",error);
        if(error)
        {
            NSLog(@"出现异常:%@",error);
            //                    if(!block)
            //                    {
            block(nil,NO);
            //                    }
        }
        else
        {
            NSJSONSerialization *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dict = (NSDictionary *)object;
            NSLog(@"=====%@",[dict objectForKey:@"status"]);
            NSString *status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
            if([status isEqualToString:@"0"])
            {
                NSLog(@"服务器成功响应!>>%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                NSDictionary *dictionary=[self readJsonData:data];
                block([[dictionary objectForKey:@"data"] objectForKey:@"id"],YES);
            }
            else
            {
                NSLog(@"服务器返回失败!>>%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                block(nil,NO);
            }
        }
        
    }];
    //开始任务
    [dataTask resume];
    
}


-(NSData *)getDataWithString:(NSString *)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
    
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    //    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end
