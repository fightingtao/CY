//
//  CYData.h
//
//  Created by Han  on 16/5/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CYData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double paybackfee;
@property (nonatomic, assign) int successcount;
@property (nonatomic, assign) double pos;
@property (nonatomic, assign) double checkedmoney;
@property (nonatomic, assign) int totalcount;
@property (nonatomic, assign) double yifuTuiFee;
@property (nonatomic, assign) double payfee;
@property (nonatomic, assign) double totalmoney;
@property (nonatomic, assign) double uncheckedmoney;
@property (nonatomic, assign) double alipay;
@property (nonatomic, assign) double cash;
@property (nonatomic, assign) double payedfee;
@property (nonatomic, assign) int exptcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
