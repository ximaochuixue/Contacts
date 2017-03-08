//
//  Contact.h
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/21.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;

//


+(instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;

@end
