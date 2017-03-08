//
//  AddViewController.m
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/20.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import "AddViewController.h"
#import "ContacViewController.h"
#import "Contact.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController



- (IBAction)add:(id)sender {
    
    Contact *c = [Contact contactWithName:_nameFiled.text phone:_phoneFiled.text];
    
    if (_block) {
        _block(c);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
    [_phoneFiled addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [_nameFiled becomeFirstResponder];
    
}

- (void)textChange
{
    _addBtn.enabled = _nameFiled.text.length && _phoneFiled.text.length;
    
    NSLog(@"%@--%@",_nameFiled.text,_phoneFiled.text);
}





@end
