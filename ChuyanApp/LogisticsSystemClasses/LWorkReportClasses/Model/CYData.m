//
//  CYData.m
//
//  Created by Han  on 16/5/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CYData.h"


NSString *const kCYDataPaybackfee = @"paybackfee";
NSString *const kCYDataSuccesscount = @"successcount";
NSString *const kCYDataPos = @"pos";
NSString *const kCYDataCheckedmoney = @"checkedmoney";
NSString *const kCYDataTotalcount = @"totalcount";
NSString *const kCYDataYifuTuiFee = @"yifuTuiFee";
NSString *const kCYDataPayfee = @"payfee";
NSString *const kCYDataTotalmoney = @"totalmoney";
NSString *const kCYDataUncheckedmoney = @"uncheckedmoney";
NSString *const kCYDataAlipay = @"alipay";
NSString *const kCYDataCash = @"cash";
NSString *const kCYDataPayedfee = @"payedfee";
NSString *const kCYDataExptcount = @"exptcount";


@interface CYData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CYData

@synthesize paybackfee = _paybackfee;
@synthesize successcount = _successcount;
@synthesize pos = _pos;
@synthesize checkedmoney = _checkedmoney;
@synthesize totalcount = _totalcount;
@synthesize yifuTuiFee = _yifuTuiFee;
@synthesize payfee = _payfee;
@synthesize totalmoney = _totalmoney;
@synthesize uncheckedmoney = _uncheckedmoney;
@synthesize alipay = _alipay;
@synthesize cash = _cash;
@synthesize payedfee = _payedfee;
@synthesize exptcount = _exptcount;


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
            self.paybackfee = [[self objectOrNilForKey:kCYDataPaybackfee fromDictionary:dict] doubleValue];
            self.successcount = [[self objectOrNilForKey:kCYDataSuccesscount fromDictionary:dict] doubleValue];
            self.pos = [[self objectOrNilForKey:kCYDataPos fromDictionary:dict] doubleValue];
            self.checkedmoney = [[self objectOrNilForKey:kCYDataCheckedmoney fromDictionary:dict] doubleValue];
            self.totalcount = [[self objectOrNilForKey:kCYDataTotalcount fromDictionary:dict] doubleValue];
            self.yifuTuiFee = [[self objectOrNilForKey:kCYDataYifuTuiFee fromDictionary:dict] doubleValue];
            self.payfee = [[self objectOrNilForKey:kCYDataPayfee fromDictionary:dict] doubleValue];
            self.totalmoney = [[self objectOrNilForKey:kCYDataTotalmoney fromDictionary:dict] doubleValue];
            self.uncheckedmoney = [[self objectOrNilForKey:kCYDataUncheckedmoney fromDictionary:dict] doubleValue];
            self.alipay = [[self objectOrNilForKey:kCYDataAlipay fromDictionary:dict] doubleValue];
            self.cash = [[self objectOrNilForKey:kCYDataCash fromDictionary:dict] doubleValue];
            self.payedfee = [[self objectOrNilForKey:kCYDataPayedfee fromDictionary:dict] doubleValue];
            self.exptcount = [[self objectOrNilForKey:kCYDataExptcount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.paybackfee] forKey:kCYDataPaybackfee];
    [mutableDict setValue:[NSNumber numberWithDouble:self.successcount] forKey:kCYDataSuccesscount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pos] forKey:kCYDataPos];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkedmoney] forKey:kCYDataCheckedmoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalcount] forKey:kCYDataTotalcount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.yifuTuiFee] forKey:kCYDataYifuTuiFee];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payfee] forKey:kCYDataPayfee];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalmoney] forKey:kCYDataTotalmoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uncheckedmoney] forKey:kCYDataUncheckedmoney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.alipay] forKey:kCYDataAlipay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cash] forKey:kCYDataCash];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payedfee] forKey:kCYDataPayedfee];
    [mutableDict setValue:[NSNumber numberWithDouble:self.exptcount] forKey:kCYDataExptcount];

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

    self.paybackfee = [aDecoder decodeDoubleForKey:kCYDataPaybackfee];
    self.successcount = [aDecoder decodeDoubleForKey:kCYDataSuccesscount];
    self.pos = [aDecoder decodeDoubleForKey:kCYDataPos];
    self.checkedmoney = [aDecoder decodeDoubleForKey:kCYDataCheckedmoney];
    self.totalcount = [aDecoder decodeDoubleForKey:kCYDataTotalcount];
    self.yifuTuiFee = [aDecoder decodeDoubleForKey:kCYDataYifuTuiFee];
    self.payfee = [aDecoder decodeDoubleForKey:kCYDataPayfee];
    self.totalmoney = [aDecoder decodeDoubleForKey:kCYDataTotalmoney];
    self.uncheckedmoney = [aDecoder decodeDoubleForKey:kCYDataUncheckedmoney];
    self.alipay = [aDecoder decodeDoubleForKey:kCYDataAlipay];
    self.cash = [aDecoder decodeDoubleForKey:kCYDataCash];
    self.payedfee = [aDecoder decodeDoubleForKey:kCYDataPayedfee];
    self.exptcount = [aDecoder decodeDoubleForKey:kCYDataExptcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_paybackfee forKey:kCYDataPaybackfee];
    [aCoder encodeDouble:_successcount forKey:kCYDataSuccesscount];
    [aCoder encodeDouble:_pos forKey:kCYDataPos];
    [aCoder encodeDouble:_checkedmoney forKey:kCYDataCheckedmoney];
    [aCoder encodeDouble:_totalcount forKey:kCYDataTotalcount];
    [aCoder encodeDouble:_yifuTuiFee forKey:kCYDataYifuTuiFee];
    [aCoder encodeDouble:_payfee forKey:kCYDataPayfee];
    [aCoder encodeDouble:_totalmoney forKey:kCYDataTotalmoney];
    [aCoder encodeDouble:_uncheckedmoney forKey:kCYDataUncheckedmoney];
    [aCoder encodeDouble:_alipay forKey:kCYDataAlipay];
    [aCoder encodeDouble:_cash forKey:kCYDataCash];
    [aCoder encodeDouble:_payedfee forKey:kCYDataPayedfee];
    [aCoder encodeDouble:_exptcount forKey:kCYDataExptcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    CYData *copy = [[CYData alloc] init];
    
    if (copy) {

        copy.paybackfee = self.paybackfee;
        copy.successcount = self.successcount;
        copy.pos = self.pos;
        copy.checkedmoney = self.checkedmoney;
        copy.totalcount = self.totalcount;
        copy.yifuTuiFee = self.yifuTuiFee;
        copy.payfee = self.payfee;
        copy.totalmoney = self.totalmoney;
        copy.uncheckedmoney = self.uncheckedmoney;
        copy.alipay = self.alipay;
        copy.cash = self.cash;
        copy.payedfee = self.payedfee;
        copy.exptcount = self.exptcount;
    }
    
    return copy;
}


@end
