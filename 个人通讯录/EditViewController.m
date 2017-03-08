//
//  EditViewController.m
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/22.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditViewController
- (IBAction)save:(id)sender {
    
    _contact.name = _nameField.text;
    _contact.phone = _phoneField.text;
    
    if (_block) {
        _block();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"查看/编辑";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    
    _nameField.text = _contact.name;
    _phoneField.text = _contact.phone;
    
//    [_phoneField becomeFirstResponder];
    
    [_nameField addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    [_phoneField addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    
    [self textchange];
}

-(void)textchange
{
    _saveBtn.enabled = _nameField.text.length && _phoneField.text.length;
}

-(void)edit:(UIBarButtonItem *)item
{
    
    if ([item.title isEqualToString:@"编辑"]) {
        
        item.title = @"取消";
        
        _nameField.enabled = YES;
        _phoneField.enabled = YES;
        
        [_phoneField becomeFirstResponder];
        
        _saveBtn.hidden = NO;
        
    }else{
        
        item.title = @"编辑";
        
        _nameField.enabled = NO;
        _phoneField.enabled = NO;
        
        _saveBtn.hidden = YES;
        
        _nameField.text = _contact.name;
        _phoneField.text = _contact.phone;
    }
    
}


@end
