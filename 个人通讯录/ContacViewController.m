//
//  ContacViewController.m
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/20.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import "ContacViewController.h"
#import "Contact.h"
#import "AddViewController.h"
#import "EditViewController.h"

#define FilePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]


@interface ContacViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContacViewController


- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
        
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    
    return _contacts;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddViewController *addVc = segue.destinationViewController;
    
    addVc.block = ^(Contact *contact){
        
        [self.contacts addObject:contact];
        
        [self.tableView reloadData];
        
        //保存联系人
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:FilePath];
    };
}


- (IBAction)logout:(id)sender {

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注销" message:@"是否注销" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
    
    self.tableView.tableFooterView = [[UIView alloc] init]; //有数据才有分割线


}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contacts.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    Contact *c = self.contacts[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.phone;
    
    return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    EditViewController *editVc = [stroyboard instantiateViewControllerWithIdentifier:@"edit"];
    
    editVc.contact = self.contacts[indexPath.row];
    
    //编辑后调用
    editVc.block = ^(){
      
        [self.tableView reloadData];
        
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:FilePath];
        
    };
    
    [self.navigationController pushViewController:editVc animated:YES];
    
}


//删除

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.contacts removeObjectAtIndex:indexPath.row];
//    
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}



- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"增加" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        
        UIStoryboard *uisb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        AddViewController *add = [uisb instantiateViewControllerWithIdentifier:@"add"];
        
        [self.navigationController pushViewController:add animated:YES];
        
//        NSLog(@"增加");
    }];
    
    
    action.backgroundColor = [UIColor greenColor];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

//        NSLog(@"删除");
        
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    
    return @[action,action1];
}


@end
