//
//  UserInfoSaveModel.m
//  Shipper
//
//  Created by xc on 15/9/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UserInfoSaveModel.h"

@implementation UserInfoSaveModel
@synthesize primaryKey;
@synthesize key;
@synthesize userId;
@synthesize username;
@synthesize type;
@synthesize status;
@synthesize isdelete;
@synthesize header;
@synthesize telephone;
@synthesize gender;
@synthesize notifyid;
@synthesize level;
@synthesize point;
@synthesize istested;
@synthesize istrained;
@synthesize cityName;
@synthesize tag;
@synthesize positiveIdPath;
@synthesize negativeIdPath;
@synthesize handIdPath;
@synthesize authenTelephone;
@synthesize realName;
@synthesize idNum;
@synthesize brokerStatus;
@synthesize isbroker;
@synthesize declaration;
@synthesize birthday;
@synthesize isauthen;
@synthesize stars;
@synthesize title;
@synthesize isFirst;
@synthesize isSetPayPassword;
@synthesize isBindWithdrawAccount;
@synthesize iswork;
@synthesize companycode;
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.primaryKey = [coder decodeObjectForKey:@"primaryKey"];
        self.key = [coder decodeObjectForKey:@"key"];
        self.userId = [coder decodeObjectForKey:@"userId"];
        self.username = [coder decodeObjectForKey:@"username"];
        self.type = [coder decodeObjectForKey:@"type"];
        self.status = [coder decodeObjectForKey:@"status"];
        self.isdelete = [coder decodeObjectForKey:@"isdelete"];
        self.header = [coder decodeObjectForKey:@"header"];
        self.telephone = [coder decodeObjectForKey:@"telephone"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.notifyid = [coder decodeObjectForKey:@"notifyid"];
        self.level = [coder decodeObjectForKey:@"level"];
        self.point = [coder decodeObjectForKey:@"point"];
        self.istested = [coder decodeObjectForKey:@"istested"];
        self.istrained = [coder decodeObjectForKey:@"istrained"];
        self.cityName = [coder decodeObjectForKey:@"cityName"];
        self.tag = [coder decodeObjectForKey:@"tag"];
        self.positiveIdPath = [coder decodeObjectForKey:@"positiveIdPath"];
        self.negativeIdPath = [coder decodeObjectForKey:@"negativeIdPath"];
        self.handIdPath = [coder decodeObjectForKey:@"handIdPath"];
        self.authenTelephone = [coder decodeObjectForKey:@"authenTelephone"];
        self.realName = [coder decodeObjectForKey:@"realName"];
        self.idNum = [coder decodeObjectForKey:@"idNum"];
        self.brokerStatus = [coder decodeObjectForKey:@"brokerStatus"];
        self.isbroker = [coder decodeObjectForKey:@"isbroker"];
        self.declaration = [coder decodeObjectForKey:@"declaration"];
        NSString *tempbirthday = [coder decodeObjectForKey:@"birthday"];
        self.birthday = tempbirthday ;
        self.isauthen = [coder decodeObjectForKey:@"isauthen"];
        self.stars = [coder decodeObjectForKey:@"stars"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.isFirst = [coder decodeObjectForKey:@"isFirst"];
        self.isSetPayPassword = [coder decodeObjectForKey:@"isSetPayPassword"];
        self.isBindWithdrawAccount = [coder decodeObjectForKey:@"isBindWithdrawAccount"];
        self.iswork = [coder decodeObjectForKey:@"iswork"];
        self.companycode=[coder decodeObjectForKey:@"companycode"] ;
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.primaryKey forKey:@"primaryKey"];
    [coder encodeObject:self.key forKey:@"key"];
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.username forKey:@"username"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.type] forKey:@"type"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.status] forKey:@"status"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.isdelete] forKey:@"isdelete"];
    [coder encodeObject:self.header forKey:@"header"];
    [coder encodeObject:self.telephone forKey:@"telephone"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.gender] forKey:@"gender"];
    [coder encodeObject:self.notifyid forKey:@"notifyid"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.level] forKey:@"level"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.point] forKey:@"point"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.istested] forKey:@"istested"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.istrained] forKey:@"istrained"];
    [coder encodeObject:self.cityName forKey:@"cityName"];
    [coder encodeObject:self.tag forKey:@"tag"];
     [coder encodeObject:self.positiveIdPath forKey:@"positiveIdPath"];
     [coder encodeObject:self.negativeIdPath forKey:@"negativeIdPath"];
     [coder encodeObject:self.handIdPath forKey:@"handIdPath"];
     [coder encodeObject:self.authenTelephone forKey:@"authenTelephone"];
     [coder encodeObject:self.realName forKey:@"realName"];
     [coder encodeObject:self.idNum forKey:@"idNum"];
     [coder encodeObject:[NSString stringWithFormat:@"%@",self.brokerStatus] forKey:@"brokerStatus"];
     [coder encodeObject:[NSString stringWithFormat:@"%@",self.isbroker]  forKey:@"isbroker"];
     [coder encodeObject:self.declaration forKey:@"declaration"];
     [coder encodeObject:[NSString stringWithFormat:@"%@",self.birthday]  forKey:@"birthday"];
     [coder encodeObject:[NSString stringWithFormat:@"%@",self.isauthen] forKey:@"isauthen"];
     [coder encodeObject:[NSString stringWithFormat:@"%@",self.stars] forKey:@"stars"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.isFirst] forKey:@"isFirst"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.isSetPayPassword] forKey:@"isSetPayPassword"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.isBindWithdrawAccount] forKey:@"isBindWithdrawAccount"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.iswork] forKey:@"iswork"];
    [coder encodeObject:[NSString stringWithFormat:@"%@",self.companycode] forKey:@"companycode"];

    
}


@end
