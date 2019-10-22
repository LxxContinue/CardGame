//
//  RegistViewController.h
//  CardGame
//
//  Created by LXX on 2019/9/28.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UITextField *passText;

@end

NS_ASSUME_NONNULL_END
