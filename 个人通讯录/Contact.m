//
//  Contact.m
//  个人通讯录
//
//  Created by 希毛吹雪 on 2017/2/21.
//  Copyright © 2017年 希毛吹雪. All rights reserved.
//

#import "Contact.h"

@implementation Contact


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"nameKey"];
    
    [aCoder encodeObject:_phone forKey:@"phoneKey"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"nameKey"];
        
        _phone = [aDecoder decodeObjectForKey:@"phoneKey"];
    }
    return self;
}



+(instancetype) contactWithName:(NSString *)name phone:(NSString *)phone
{
    Contact *c = [[self alloc] init];
    c.name = name;
    c.phone = phone;
    
    return c;
}

@end
