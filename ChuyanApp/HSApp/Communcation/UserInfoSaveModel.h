//
//  UserInfoSaveModel.h
//  Shipper
//
//  Created by xc on 15/9/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UserKey  @"UserInfoChuYan"


/**
 *  登录后，序列化一些身份相关信息
 */
@interface UserInfoSaveModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *primaryKey;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *isdelete;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *notifyid;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString *istested;
@property (nonatomic, strong) NSString *istrained;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *positiveIdPath;
@property (nonatomic, strong) NSString *negativeIdPath;
@property (nonatomic, strong) NSString *handIdPath;
@property (nonatomic, strong) NSString *authenTelephone;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *idNum;
@property (nonatomic, strong) NSString *brokerStatus;
@property (nonatomic, strong) NSString *isbroker;
@property (nonatomic, strong) NSString *declaration;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *isauthen;
@property (nonatomic, strong) NSString *stars;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *isFirst;
@property (nonatomic, strong) NSString * isSetPayPassword;
@property (nonatomic, strong) NSString * isBindWithdrawAccount;
@property (nonatomic, strong) NSString * iswork;

@property(nonatomic,copy)NSString *companycode;
@end
