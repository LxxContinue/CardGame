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

}

-(void)regist{
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注册成功"
                                                                               message:@"快加入战局吧！"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                                      }];

                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
            
        }else{
            //出现错误；
            NSLog(@"错误信息：%@",error);
        }
    }];
    [dataTask resume];
 
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
