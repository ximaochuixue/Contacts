//
//  EditViewController.h
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/22.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact;

typedef void(^EditViewControllerBlock)();

@interface EditViewController : UIViewController


@property (nonatomic,strong) Contact *contact;


@property (nonatomic,strong) EditViewControllerBlock block;

@end
