//
//  GameInfo.m
//  CardGame
//
//  Created by LXX on 2019/10/11.
//  Copyright © 2019年 LXX. All rights reserved.
//

#import "GameInfo.h"
#import "objc/runtime.h"

@implementation GameInfo

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
    [aCoder encodeObject:self.playerId forKey:@"playerId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeObject:self.card forKey:@"card"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if(self = [super init])
    {
        if(aDecoder == nil)
        {
            return self;
        }
        self.playerId = [aDecoder decodeObjectForKey:@"playerId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.card = [aDecoder decodeObjectForKey:@"card"];
        
    }
    return self;
}

@end
