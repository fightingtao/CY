//
//  CYNSObject.m
//
//  Created by Han  on 16/5/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CYNSObject.h"
#import "CYData.h"


NSString *const kCYNSObjectMessage = @"message";
NSString *const kCYNSObjectData = @"data";
NSString *const kCYNSObjectCode = @"code";


@interface CYNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYNSObject

@synthesize message = _message;
@synthesize data = _data;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kCYNSObjectMessage fromDictionary:dict];
            self.data = [CYData modelObjectWithDictionary:[dict objectForKey:kCYNSObjectData]];
            self.code = [[self objectOrNilForKey:kCYNSObjectCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kCYNSObjectMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kCYNSObjectData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kCYNSObjectCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kCYNSObjectMessage];
    self.data = [aDecoder decodeObjectForKey:kCYNSObjectData];
    self.code = [aDecoder decodeDoubleForKey:kCYNSObjectCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kCYNSObjectMessage];
    [aCoder encodeObject:_data forKey:kCYNSObjectData];
    [aCoder encodeDouble:_code forKey:kCYNSObjectCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYNSObject *copy = [[CYNSObject alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
