//
//  LoginViewController.m
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/20.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+XMG.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation LoginViewController

#define XMUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *accountKey = @"account";
static NSString *pwdKey = @"pwd";
static NSString *rmbKey = @"rmb";
static NSString *loginKey = @"login";




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.title = [NSString stringWithFormat:@"%@的联系人列表",_accountFiled.text];
}




- (IBAction)login:(id)sender {
    
    [MBProgressHUD showMessage:@"正在登录ing..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
        
        if ([_accountFiled.text isEqualToString:@"zxc"] && [_pwdFiled.text isEqualToString:@"123"]) {
            
//            [[NSUserDefaults standardUserDefaults] setObject:_accountFiled.text forKey:@"accountKey"];
//            [[NSUserDefaults standardUserDefaults] setBool:_rmbPwdSwitch forKey:@"rmbKey"];
            [XMUserDefaults setObject:_accountFiled.text forKey:accountKey];
            [XMUserDefaults setObject:_pwdFiled.text forKey:pwdKey];
            [XMUserDefaults setBool:_rmbPwdSwitch.on forKey:rmbKey];
            [XMUserDefaults setBool:_autoLoginSwitch.on forKey:loginKey];
            
            
            
        
            
            [self performSegueWithIdentifier:@"login2Contact" sender:nil];
            
        }else{
            
            [MBProgressHUD showError:@"密码错误"];
            
        }
    });
    
}

- (IBAction)rmbPwdChange:(id)sender {
    
    if (_rmbPwdSwitch.on == NO) {
        [_autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange:(id)sender {
    
    if (_autoLoginSwitch.on == YES) {
        [_rmbPwdSwitch setOn:YES animated:YES];
    }
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *account = [XMUserDefaults objectForKey:accountKey];
    NSString *pwd = [XMUserDefaults objectForKey:pwdKey];
    BOOL rmb = [XMUserDefaults boolForKey:rmbKey];
    BOOL login = [XMUserDefaults boolForKey:loginKey];
    
    _accountFiled.text = account;
    
//    [_accountFiled becomeFirstResponder];
    
    if (rmb == YES) {
        _pwdFiled.text = pwd;
    }
    
    _rmbPwdSwitch.on = rmb;
    _autoLoginSwitch.on = login;
    
    if (login == YES) {
        
        [self login:nil];
    }
    
    [_accountFiled addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_pwdFiled addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self textChange];
    
}



- (void)textChange
{
    _loginBtn.enabled = _accountFiled.text.length && _pwdFiled.text.length;
    
    NSLog(@"%@--%@",_accountFiled.text,_pwdFiled.text);
}

@end
