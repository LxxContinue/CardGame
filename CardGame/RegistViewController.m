//
//  RegistViewController.m
//  CardGame
//
//  Created by LXX on 2019/9/28.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "RegistViewController.h"
#import "LxxInterfaceConnection.h"

@interface RegistViewController ()<UITextFieldDelegate>

@end

static const CGFloat kTimeOutTime = 10.f;

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameText.keyboardType = UIReturnKeyDefault;
    self.usernameText.delegate = self;
    
    self.passwordText.keyboardType = UIReturnKeyDefault;
    self.passwordText.delegate = self;
}
- (IBAction)registBtnAction:(UIButton *)sender {
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
    
    [self regist];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)regist{
//    LxxInterfaceConnection *connect = [[LxxInterfaceConnection alloc] init];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:_usernameText.text forKey:@"username"];
//    [dic setObject:_passwordText.text forKey:@"password"];
//    [connect connetNetWithHaddleV2:@"auth/register" parms:dic type:1 needToken:NO block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
//
//        if(fail == 0) {
//            NSLog(@"regist success");
//            [self dismissViewControllerAnimated:YES completion:nil];
//        } else {
//            NSLog(@"regist error %@",dataMessage);
//        }
//
//    }];
    
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"https://api.shisanshui.rtxux.xyz/auth/register"];
    
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
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc]init]];
    
    //__block  NSString *result = @"";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //没有错误，返回正确；
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"返回正确：%@",arr);
            NSLog(@"%lu", data.length);
            
        }else{
            //出现错误；
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];

    
//    // 1. 创建请求对象（可变）
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"]];
//    // 2. 设置请求方法为 POST 请求
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [@"type=focus-c" dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    // 1. 初始化 NSURLSessionDataTask 对象
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }];
//
//    [dataTask resume];
 
}
- (IBAction)pop:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
