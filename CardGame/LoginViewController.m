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

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameText.keyboardType = UIReturnKeyDefault;
    self.usernameText.delegate = self;
    
    self.passwordText.keyboardType = UIReturnKeyDefault;
    self.passwordText.delegate = self;
    
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
    
    //[self login];
    
    RootViewController *rvc = [[RootViewController alloc ] init];
    // 获取主代理
    AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    delegete.window.rootViewController = rvc;
}

-(void)login{
    LxxInterfaceConnection *connect = [[LxxInterfaceConnection alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_usernameText.text forKey:@"username"];
    [dic setObject:_passwordText.text forKey:@"password"];
    [connect connetNetWithHaddleV2:@"auth/login" parms:dic type:1 needToken:NO block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){

        if(fail == 0) {
            RootViewController *rvc = [[RootViewController alloc ] init];
            // 获取主代理
            AppDelegate *delegete = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
            delegete.window.rootViewController = rvc;
            
        } else {
            NSLog(@"login error");
        }
    }];
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
