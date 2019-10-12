//
//  LoginViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/27.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "RegistViewController.h"
#import "AppDelegate.h"

#import "LxxInterfaceConnection.h"
#import "UserInfo.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

static const CGFloat kTimeOutTime = 10.f;

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameText.keyboardType = UIReturnKeyDefault;
    self.usernameText.delegate = self;
    
    self.passwordText.keyboardType = UIReturnKeyDefault;
    self.passwordText.delegate = self;
    
    self.passwordText.text = @"123";
    self.usernameText.text = @"031702432";
    
}

- (IBAction)loginBtnAction:(UIButton *)sender {

    NSString*pattern =@"^[0-9]{9}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    if(![pred evaluateWithObject:_usernameText.text]) {
        [self showError:@"请输入9位正确学号"];
        return;
    }
    
    if (_passwordText.text.length == 0) {
        [self showError:@"请输入密码"];
        return;
    }

    [self login];
    
//    RootViewController *rvc = [[RootViewController alloc ] init];
//    // 获取主代理
//    AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
//    delegete.window.rootViewController = rvc;
}

-(void)login{
//    LxxInterfaceConnection *connect = [[LxxInterfaceConnection alloc] init];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:_usernameText.text forKey:@"username"];
//    [dic setObject:_passwordText.text forKey:@"password"];
//    [connect connetNetWithHaddleV2:@"auth/login" parms:dic type:1 needToken:NO block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
//
//        if(fail == 0) {
//            RootViewController *rvc = [[RootViewController alloc ] init];
//            // 获取主代理
//            AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
//            delegete.window.rootViewController = rvc;
//
//        } else {
//            NSLog(@"login error");
//        }
//    }];
    
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/auth/login"];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:kTimeOutTime];
    request.HTTPMethod = @"POST";
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 3.设置请求体
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_usernameText.text forKey:@"username"];
    [dic setObject:_passwordText.text forKey:@"password"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = data;
    
    // 4.发送请求
    //    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    __block  NSString *result = @"";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            UserInfo *userInfo = [[UserInfo alloc] initWithNSDictionary:[dict objectForKey:@"data"] ];
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
            [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.user_id forKey:@"user_id"];
            
            result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"返回正确：%@",result);
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"login返回正确：%@",arr);
            
            NSLog(@"**** token:%@   id:%@",userInfo.token,userInfo.user_id);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                RootViewController *rvc = [[RootViewController alloc ] init];
                // 获取主代理
                AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
                delegete.window.rootViewController = rvc;
            });
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];

    
}
- (IBAction)showRegistView:(UIButton *)sender {
    RegistViewController *rvc = [[RegistViewController alloc]init];
    [self presentViewController:rvc animated:YES completion:nil];
}

- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - UITextFieldDelegate
//点击return收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
