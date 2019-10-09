//
//  UserInfo.m
//  CardGame
//
//  Created by LXX on 2019/10/9.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "UserInfo.h"
#import "objc/runtime.h"


@implementation UserInfo

-(instancetype)initWithNSDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        [self prepareModel:dict];
    }
    return self;
}
-(void)prepareModel:(NSDictionary *)dict
{
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    
    u_int count = 0 ;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char *propertyCString = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propertyCString encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    for (NSString *key in keys)
    {
        if([dict valueForKey:key])
        {
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.player_id forKey:@"player_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.score forKey:@"score"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if(self = [super init])
    {
        if(aDecoder == nil)
        {
            return self;
        }
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.player_id = [aDecoder decodeObjectForKey:@"player_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        
    }
    return self;
}

@end
