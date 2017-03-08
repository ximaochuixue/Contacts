//
//  AddViewController.h
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/20.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ContacViewController,Contact;

typedef void(^addViewControllerBlock)(Contact *contact);


@interface AddViewController : UIViewController

@property (nonatomic,strong) Contact *contact;

@property (nonatomic,strong) addViewControllerBlock block;

@end
