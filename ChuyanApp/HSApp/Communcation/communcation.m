//
//  communcation.m
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "communcation.h"
//#import "DataModels.h"

@implementation communcation

+ (id)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}


//获取注册验证码
- (Out_RegisterCodeModel*)getRegisterCodeWithModel:(In_RegisterCodeModel*)model
{
    //#define HOSTURL @"http://120.27.186.69/hsconsumer/"   // W 外网

    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/regist/code", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.telephone forKey:@"telephone"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_RegisterCodeModel *outModel = [[Out_RegisterCodeModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//注册账号
- (Out_RegisterModel*)registerAccountWithModel:(In_RegisterModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/regist", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.telephone forKey:@"telephone"];
    [request setPostValue:model.cityname forKey:@"cityname"];
    [request setPostValue:model.code forKey:@"code"];
    [request setPostValue:model.inviteCode forKey:@"inviteCode"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_RegisterModel *outModel = [[Out_RegisterModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}


//获取登录验证码
- (Out_LoginCodeModel*)getLoginCodeWithModel:(In_LoginCodeModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/login/code", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.telephone forKey:@"telephone"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    DLog(@"错误   %@",error);
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LoginCodeModel *outModel = [[Out_LoginCodeModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

//用户登录
- (Out_LoginModel*)userLoginWithModel:(In_LoginModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/login", LogisticsHOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
//    http://172.168.35.252:8082/hs-deliveryconsumer/user/login?employeeno=12452&password=2456
    [request setPostValue:model.employeeno forKey:@"employeeno"];
    [request setPostValue:model.password forKey:@"password"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LoginModel *outModel = [[Out_LoginModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            DLog(@"登录信息%@",ReturnDic);
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取小费列表
- (Out_TipsModel*)getTipsWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/get/tips", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_TipsModel *outModel = [[Out_TipsModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取订单类型列表
- (Out_TypeModel*)getTypesWithKey:(NSString*)key AndDigest:(NSString*)digest;
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/get/types", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_TypeModel *outModel = [[Out_TypeModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取常用地址列表
- (Out_AddressModel*)getAddressWithMode:(In_AddressModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/get/addresses", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userId forKey:@"userId"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AddressModel *outModel = [[Out_AddressModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//新增常用地址列表
- (Out_AddAddressModel*)addNewAddressWithModel:(In_AddAddressModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/add/address", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.name forKey:@"name"];
    [request setPostValue:model.telephone forKey:@"telephone"];
    [request setPostValue:model.text forKey:@"text"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AddAddressModel *outModel = [[Out_AddAddressModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



///获取培训内容
- (Out_TrainModel*)getTrainContentWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/trainpic", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_TrainModel *outModel = [[Out_TrainModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

///完成培训
- (Out_ComPleteTrainModel*)completeTrainContentWithKey:(NSString*)key AndDigest:(NSString*)digest AndBrokerId:(NSString*)Id
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/trainpic/finish", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:Id forKey:@"brokerid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_ComPleteTrainModel *outModel = [[Out_ComPleteTrainModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}


///获取测试内容
- (Out_TestModel*)getTestContentWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/traintest", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_TestModel *outModel = [[Out_TestModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//完成测试model
- (Out_ComPleteTestModel*)completeTestContentWithKey:(NSString*)key AndDigest:(NSString*)digest AndBrokerId:(NSString*)Id
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/traintest/finish", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:Id forKey:@"brokerid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_ComPleteTestModel *outModel = [[Out_ComPleteTestModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

//删除常用地址
- (Out_DeleteAddressModel*)deleteAddressWithModel:(In_DeleteAddressModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/delete/address", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.addressid forKey:@"addressid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_DeleteAddressModel *outModel = [[Out_DeleteAddressModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}



///获取呼单圈内容
- (Out_HomeListModel*)getHomeContentWithCity:(NSString*)city AndLastDate:(NSString*)date AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/index/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:city forKey:@"cityname"];
    [request setPostValue:date forKey:@"lastDate"];
    [request setPostValue:orderId forKey:@"lastorderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_HomeListModel *outModel = [[Out_HomeListModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}
#pragma mark 发布订单
- (Out_PulishOrderModel*)publishOrderWithModel:(In_PublishOrderModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/publish", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.desc forKey:@"desc"];
    [request setPostValue:model.tip forKey:@"tip"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.type forKey:@"type"];
    [request setPostValue:model.orderTypeId forKey:@"orderTypeId"];
    [request setPostValue:model.cityname forKey:@"cityname"];
    [request setPostValue:model.lng forKey:@"lng"];
    [request setPostValue:model.lat forKey:@"lat"];
    [request setPostValue:model.advertId forKey:@"advertId"];
    [request setPostValue:model.addressId forKey:@"addressId"];
    [request setPostValue:model.toAddressId forKey:@"toAddressId"];
    [request setPostValue:model.voicePath forKey:@"voicePath"];
    [request setPostValue:model.picurls forKey:@"picurls"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_PulishOrderModel *outModel = [[Out_PulishOrderModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

#pragma mark 认证经纪人
- (Out_AuthenBrokerModel*)authenBrokerWithModel:(In_AuthenBrokerModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/authen", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.positiveIdPath forKey:@"positiveIdPath"];
    [request setPostValue:model.negativeIdPath forKey:@"negativeIdPath"];
    [request setPostValue:model.handIdPath forKey:@"handIdPath"];
    [request setPostValue:model.authenTelephone  forKey:@"authenTelephone "];
    [request setPostValue:model.realName  forKey:@"realName "];
    [request setPostValue:model.idNum  forKey:@"idNum "];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AuthenBrokerModel *outModel = [[Out_AuthenBrokerModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 获取首页广告内容接口
- (Out_AdvertModel*)getHomeAdvertWithCity:(NSString*)city
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/index/advert", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:city forKey:@"cityname"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AdvertModel *outModel = [[Out_AdvertModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 修改常用地址接口
- (Out_UpdateAddressModel*)updateAddressWithModel:(In_UpdateAddressModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/update/address", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.name forKey:@"name"];
    [request setPostValue:model.telephone forKey:@"telephone"];
    [request setPostValue:model.text forKey:@"text"];
    [request setPostValue:model.addressid forKey:@"addressid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_UpdateAddressModel *outModel = [[Out_UpdateAddressModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 获取钱包信息接口
- (Out_MoneyModel*)getMoneyInfoWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/wallet", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:key forKey:@"user_id"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_MoneyModel *outModel = [[Out_MoneyModel alloc] initWithString:responseString usingEncoding:NSUTF8StringEncoding error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

#pragma mark 获取钱包密码,绑定支付宝验证码
- (Out_MoneyCodeModel*)getMoneyCodeWithPhone:(NSString*)phone AndKey:(NSString*)key AndDigest:(NSString*)digest;
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/pay/code", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:phone forKey:@"telephone"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_MoneyCodeModel *outModel = [[Out_MoneyCodeModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

#pragma mark 设置或修改支付钱包接口
- (Out_SetMoneyPwdModel*)setMoneyPwdWithModel:(In_SetMoneyPwdModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/wallet/password/update", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.password forKey:@"password"];
    [request setPostValue:model.code forKey:@"code"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_SetMoneyPwdModel *outModel = [[Out_SetMoneyPwdModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



#pragma mark 获取待接单列表接口
- (Out_WaitOrderListModel*)getWaitOrderListWithModel:(In_WaitOrderListModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/wait/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.cityname forKey:@"cityname"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.type] forKey:@"type"];
    [request setPostValue:model.lastDate forKey:@"lastDate"];
    [request setPostValue:model.lastorderid forKey:@"lastorderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_WaitOrderListModel *outModel = [[Out_WaitOrderListModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 经纪人抢单接口
- (Out_GetOrderModel*)getOrderWithModel:(In_GetOrderModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/grab", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.lng forKey:@"lng"];
    [request setPostValue:model.lat forKey:@"lat"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_GetOrderModel *outModel = [[Out_GetOrderModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

#pragma mark 24获取已抢单经纪人列表接口
- (Out_GetOrderBrokerModel*)getOrderBrokerListWithModel:(In_GetOrderBrokerModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/choose/broker/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:model.type forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_GetOrderBrokerModel *outModel = [[Out_GetOrderBrokerModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 呼单列表接口
- (Out_OrderIngListModel*)getOrderIngListWithModel:(In_OrderIngListModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userId forKey:@"userId"];
    [request setPostValue:model.usertype forKey:@"usertype"];
    [request setPostValue:[NSString stringWithFormat:@"%@",model.type] forKey:@"type"];
    [request setPostValue:model.lastDate forKey:@"lastDate"];
    [request setPostValue:model.lastorderid forKey:@"lastorderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderIngListModel *outModel = [[Out_OrderIngListModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 绑定提现账号接口
- (Out_BindingWithdrawAccountModel*)bindingWithdrawAccountWithModel:(In_BindingWithdrawAccountModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/withdraw/account/bind", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.account_no forKey:@"account_no"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.account_type] forKey:@"account_type"];
    [request setPostValue:model.code forKey:@"code"];
    [request setPostValue:model.real_name forKey:@"real_name"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_BindingWithdrawAccountModel *outModel = [[Out_BindingWithdrawAccountModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

#pragma mark 选择经纪人
- (Out_ChooseBrokerModel*)chooseBrokerWithKey:(NSString*)key AndDegist:(NSString*)degist AndOrderbrokerid:(NSString*)orderbrokerid
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/choose/broker", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:degist forKey:@"digest"];
    [request setPostValue:orderbrokerid forKey:@"orderbrokerid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_ChooseBrokerModel *outModel = [[Out_ChooseBrokerModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//修改用户资料接口
- (Out_UpdateUserInfoModel*)updateUserInfoWithModel:(In_UpdateUserInfoModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/update", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.username forKey:@"username"];
    [request setPostValue:model.header forKey:@"header"];
    [request setPostValue:model.birthday forKey:@"birthday"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.gender] forKey:@"gender"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_UpdateUserInfoModel *outModel = [[Out_UpdateUserInfoModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


#pragma mark 刷新用户信息接口
- (Out_RefreshUserInfoModel*)refreshUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/info", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:key forKey:@"user_id"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_RefreshUserInfoModel *outModel = [[Out_RefreshUserInfoModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

#pragma mark 编辑江湖口号接口
- (Out_EditUserDeclare*)editUserDeclareWithModel:(In_EditUserDeclare*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/declare", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.declaration forKey:@"declaration"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_EditUserDeclare *outModel = [[Out_EditUserDeclare alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

#pragma mark 雇主端确认订单完成接口
- (Out_CustomerConfirmOrderModel*)CustomerConfirmOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/confirm", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CustomerConfirmOrderModel *outModel = [[Out_CustomerConfirmOrderModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//经纪人代送订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDSOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/got", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CustomerConfirmOrderModel *outModel = [[Out_CustomerConfirmOrderModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//经纪人代办订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDBOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/dealed", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CustomerConfirmOrderModel *outModel = [[Out_CustomerConfirmOrderModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//33经纪人代购订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDGOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndFee:(NSString*)fee
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/buy", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    [request setPostValue:fee forKey:@"fee"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CustomerConfirmOrderModel *outModel = [[Out_CustomerConfirmOrderModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

}

//34获取订单详情接口
- (Out_OrderDetailModel*)getOrderDetailWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndType:(NSString*)type
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/detail", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    [request setPostValue:type forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderDetailModel *outModel = [[Out_OrderDetailModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取评论列表接口
- (Out_CommentListModel*)getCommentListWithModel:(In_CommentListModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/evaluate/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastDate] forKey:@"lastDate"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastrowid] forKey:@"lastrowid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.type] forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CommentListModel *outModel = [[Out_CommentListModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//36支付前获取订单信息接口
- (Out_ReadyPayDetailModel*)getReadyPayDetailWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/pay/detail", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_ReadyPayDetailModel *outModel = [[Out_ReadyPayDetailModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//呼单圈点赞接口
- (Out_OrderPraiseModel*)orderPraiseWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/zan", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"order_id"];
    [request setPostValue:key forKey:@"user_id"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderPraiseModel *outModel = [[Out_OrderPraiseModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取评价用户信息接口
- (Out_CommentUserModel*)getCommentUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndType:(NSString*)type
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/evaluate/detail", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    [request setPostValue:type forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CommentUserModel *outModel = [[Out_CommentUserModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//评价用户接口
- (Out_UserCommentModel*)userCommentUserWithModel:(In_UserCommentModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/evaluate/add", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userid forKey:@"userid"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:model.content forKey:@"content"];
    [request setPostValue:[NSString stringWithFormat:@"%0.1f",model.point] forKey:@"point"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_UserCommentModel *outModel = [[Out_UserCommentModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取订单动态接口
- (Out_OrderDynamicModel*)getOrderDynamicWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/dynamic", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderDynamicModel *outModel = [[Out_OrderDynamicModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//余额支付接口
- (Out_UserPacketPayModel*)packetPayWithModel:(In_UserPacketPayModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/balance/pay", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.redid forKey:@"redid"];
    [request setPostValue:model.password forKey:@"password"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_UserPacketPayModel *outModel = [[Out_UserPacketPayModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取订单详情中的订单状态列表接口
- (Out_OrderDetailStatusModel*)getOrderDetailStatusWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/progress", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderDetailStatusModel *outModel = [[Out_OrderDetailStatusModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取充值金额列表接口
- (Out_RechargeMoneyModel*)getRechargeMoneyListWithKey:(NSString*)key AndDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/recharge/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_RechargeMoneyModel *outModel = [[Out_RechargeMoneyModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取红包列表接口(Type 1：可用的红包2：所有的红包)
- (Out_RedPacketModel*)getRedPacketWithModel:(In_RedPacketModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/get/reds", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.type] forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_RedPacketModel *outModel = [[Out_RedPacketModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取呼单动态中评论列表接口
- (Out_OrderDynamicCommentModel*)getOrderDynamicCommentListWithModel:(In_OrderDynamicCommentModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/comment/list", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastDate] forKey:@"lastDate"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastrowid] forKey:@"lastrowid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderDynamicCommentModel *outModel = [[Out_OrderDynamicCommentModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取提现明细列表接口
- (Out_BillsDetailModel*)getBillsDetailWithModel:(In_BillsDetailModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/bills/by/type", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastDate] forKey:@"lastDate"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastrowid] forKey:@"lastrowid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.type] forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_BillsDetailModel *outModel = [[Out_BillsDetailModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//获取热线电话接口
- (Out_HotLineModel*)getHotLine
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/hotline", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_HotLineModel *outModel = [[Out_HotLineModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//意见反馈接口
- (Out_FeedbackModel*)userFeedBackWithModel:(In_FeedbackModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/feedback", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.text forKey:@"text"];
    [request setPostValue:model.version forKey:@"version"];
    [request setPostValue:model.system forKey:@"system"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_FeedbackModel *outModel = [[Out_FeedbackModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取账单列表接口
- (Out_PacketBillsModel*)getPacketBillsWithModel:(In_BillsDetailModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/bills", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastDate] forKey:@"lastDate"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastrowid] forKey:@"lastrowid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_PacketBillsModel *outModel = [[Out_PacketBillsModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



//接单前取消呼单接口
- (Out_CancelOrderBeforeModel*)cancelOrderBeforeWithWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/cancel", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CancelOrderBeforeModel *outModel = [[Out_CancelOrderBeforeModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//申请取消呼单接口
- (Out_AllSameModel*)applyCancelOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/need/cancel", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}
//同意取消呼单接口
- (Out_AllSameModel*)allowCancelOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/agree/cancel", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



//追加小费接口
- (Out_AllSameModel*)addMoreTipsWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndTipsId:(int)tipsId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/append/tip", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:orderId forKey:@"orderid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",tipsId] forKey:@"tipid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//提现接口
- (Out_AllSameModel*)withdrawCashWithModel:(In_WithdrawCashModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/build/withdraw/order", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.bindaccountid forKey:@"bindaccountid"];
    [request setPostValue:[NSString stringWithFormat:@"%0.2f",model.amount] forKey:@"amount"];
    [request setPostValue:model.password forKey:@"password"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取绑定提现账号接口
- (Out_WithdrawBindingModel*)getWithdrawBindingAccountWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/withdraw/account/bind/get", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:userId forKey:@"user_id"];

    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_WithdrawBindingModel *outModel = [[Out_WithdrawBindingModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//获取雏燕消息接口
- (Out_HSMessageModel*)getHSMessageWithModel:(In_HSMessageModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/get/messages", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userid forKey:@"userid"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastDate] forKey:@"lastDate"];
    [request setPostValue:[NSString stringWithFormat:@"%ld",model.lastrowid] forKey:@"lastrowid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.type] forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_HSMessageModel *outModel = [[Out_HSMessageModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//推荐有奖接口
- (Out_InviteModel*)inviteRewardWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserid:(NSString*)userid
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/invite", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:userid forKey:@"user_id"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_InviteModel *outModel = [[Out_InviteModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//用户设置接收推送接口
- (Out_AllSameModel*)setPushNotificationWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId AndType:(NSString*)type
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/advice", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:userId forKey:@"user_id"];
    [request setPostValue:type forKey:@"type"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//呼单动态添加评论接口
- (Out_AllSameModel*)addCommentToOrderDynamicWithModel:(In_AddDynamicCommentModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/comment/add", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    [request setPostValue:model.order_id forKey:@"order_id"];
    [request setPostValue:model.parent_comment_id forKey:@"parent_comment_id"];
    [request setPostValue:model.content forKey:@"content"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//投诉接口
- (Out_AllSameModel*)complainOrderWithModel:(In_ComplainModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/complain", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.userid forKey:@"userid"];
    [request setPostValue:model.orderid forKey:@"orderid"];
    [request setPostValue:model.text forKey:@"text"];
    [request setPostValue:model.telephone forKey:@"telephone"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//查看个人信息接口
- (Out_CheckUserInfoModel*)checkUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/person/info", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:userId forKey:@"user_id"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_CheckUserInfoModel *outModel = [[Out_CheckUserInfoModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}


//订单支付接口
- (Out_OrderPayModel*)OrderPayWithModel:(In_OrderPayModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/build/pay/order", HOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.coupon_type] forKey:@"coupon_type"];
    [request setPostValue:model.coupon_id forKey:@"coupon_id"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.pay_type] forKey:@"pay_type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.pay_way] forKey:@"pay_way"];
    [request setPostValue:model.order_id forKey:@"order_id"];
    [request setPostValue:model.user_id forKey:@"user_id"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_OrderPayModel *outModel = [[Out_OrderPayModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



//---------------------------物流接口--------------------------------------
//***************************************************************************
///扫码领货接口
- (Out_LScanGoodsModel*)scanAndGetGoodsWithModel:(In_LScanGoodsModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/scan", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    NSString *dingdan = [model.cwbs stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:dingdan forKey:@"cwbs"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.terminaltype] forKey:@"terminaltype"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LScanGoodsModel *outModel = [[Out_LScanGoodsModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}
#pragma mark 到货
///扫码到货接口
- (Out_LScanGoodsModel*)scanAndDaoGoodsWithModel:(In_LScanGoodsModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/branchimport", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    NSString *dingdan = [model.cwbs stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:dingdan forKey:@"cwbs"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.terminaltype] forKey:@"terminaltype"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LScanGoodsModel *outModel = [[Out_LScanGoodsModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

//首页信息获取
- (Out_LogisticsHomeModel*)getLogisticsInfoWith:(NSString*)key andDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/workNew", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LogisticsHomeModel *outModel = [[Out_LogisticsHomeModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



///送货列表接口
- (Out_LDeliveringModel*)getDeliveringOrderWithModel:(In_DeliveringGoodsModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/dispatch", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.offset] forKey:@"offset"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.pagesize] forKey:@"pagesize"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.deliverystate] forKey:@"deliverystate"];
    [request setPostValue:[NSString stringWithFormat:@"%f",model.lon] forKey:@"lon"];
    [request setPostValue:[NSString stringWithFormat:@"%f",model.lat] forKey:@"lat"];
    [request setPostValue:model.searchstr forKey:@"searchstr"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
//        DLog(@"订单>>>>>>>>>%@",responseString);
        if (ReturnDic) {
            Out_LDeliveringModel *outModel = [[Out_LDeliveringModel alloc] initWithDictionary:ReturnDic error:nil];
            DLog(@"送货列表字典%@",ReturnDic);
            return outModel;
        }else{
            return nil;
        }
        
    }
    
    return nil;
}



///获取订单详情
- (Out_LOrderDetailModel*)getLOrderDetailWith:(NSString*)key andDigest:(NSString*)digest andOrder:(NSString*)order
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/cwb/search", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:order forKey:@"cwb"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {

            Out_LOrderDetailModel *outModel = [[Out_LOrderDetailModel alloc] initWithDictionary:ReturnDic error:nil];
            DLog(@"÷5.29订单详情汇总zidian %@",ReturnDic);
            return outModel;
        }else{
            return nil;
        }
    }
    return nil;
}


///获取异常列表
- (Out_LExptreasonModel*)getExptReasonListWith:(NSString*)key andDigest:(NSString*)digest andExpttype:(NSString*)expttype
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/exptreason", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:expttype forKey:@"expttype"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LExptreasonModel *outModel = [[Out_LExptreasonModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}

///反馈列表
- (Out_FeedbackOrderidWithModel *)getFeedBackWithModel:(In_FeedbackOrderidWithModel *)model{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/feedback", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.cwbs forKey:@"cwbs"];
    [request setPostValue:model.exptioncode forKey:@"exptioncode"];
    [request setPostValue:model.nextdispatchtime forKey:@"nextdispatchtime"];
    [request setPostValue:model.signman forKey:@"signman"];
    [request setPostValue:model.signtime forKey:@"signtime"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.deliverystate] forKey:@"deliverystate"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.paywayid] forKey:@"paywayid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.cwbordertypeid] forKey:@"cwbordertypeid"];
    [request setPostValue:[NSString stringWithFormat:@"%f",model.cash] forKey:@"cash"];
   [request setPostValue:[NSString stringWithFormat:@"%d",model.terminaltype] forKey:@"terminaltype"];
    
    [request setPostValue:model.terminalid forKey:@"terminalid"];
    [request setPostValue:model.postrace forKey:@"postrace"];
    [request setPostValue:model.traceno forKey:@"traceno"];
     [request setPostValue:[NSString stringWithFormat:@"%d",model.signtypeid] forKey:@"signtypeid"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];

    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
        if (ReturnDic) {
            
            Out_FeedbackOrderidWithModel *OutModel = [[Out_FeedbackOrderidWithModel alloc] initWithDictionary:ReturnDic error:nil];
     
            return OutModel;
            
        }else{
            
            return nil;
            
        }
        
    }
    return nil;
}

///获取个人信息
- (Out_LPersonInfoModel*)getPersonInfoWith:(NSString*)key andDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/personinfo", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LPersonInfoModel *outModel = [[Out_LPersonInfoModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;


}
#pragma mark  生成缴款单
///生成缴款单
- (Out_jiaoKuanModel *)creacteJiaoKuanWith:(NSString*)key andDigest:(NSString*)digest
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/queryTodayBalance", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_jiaoKuanModel *outModel = [[Out_jiaoKuanModel alloc] initWithDictionary:ReturnDic error:nil];
            DLog(@"jao缴款%@",ReturnDic);
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
    
}
#pragma mark  保存缴款单
- (NSDictionary *)saveJiaoKuanWith:(In_BalanceModel *)inModel
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/saveTodayBalance", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:inModel.key forKey:@"key"];
    [request setPostValue:inModel.digest forKey:@"digest"];
    [request setPostValue:inModel.jsfs forKey:@"jsfs"];

    [request setPostValue:inModel.jkje forKey:@"jkje"];
    [request setPostValue:inModel.jyh forKey:@"jyh"];
    [request setPostValue:inModel.remark forKey:@"remark"];
    [request setPostValue:inModel.yjze forKey:@"yjze"];

    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
//            Out_jiaoKuanModel *outModel = [[Out_jiaoKuanModel alloc] initWithDictionary:ReturnDic error:nil];
            DLog(@"价款了 : %@",ReturnDic);
            return ReturnDic;
        }else{
            return nil;
        }
        
    }
    return nil;
    
}

///获取工作汇总
- (CYNSObject*)getWrokReportWith:(NSString*)key andDigest:(NSString*)digest andTime:(NSString*)time
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/summary", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:time forKey:@"summarytime"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {

            CYNSObject *obj = [CYNSObject modelObjectWithDictionary:ReturnDic];
//           Out_LWorkReportModel *outModel= obj.data
            DLog(@"当前工作汇总   %@",ReturnDic);
            return obj;
        }else{
            return nil;
        }
        
    }
    return nil;

}


///获取通知
- (Out_LNotificationModel*)getNotificationWithModel:(In_LNotificationModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/notify", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.offset] forKey:@"offset"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.pagesize] forKey:@"pagesize"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LNotificationModel *outModel = [[Out_LNotificationModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
    

}

///用户反馈
- (Out_AllSameModel*)userLFeedBackWith:(NSString*)key andDigest:(NSString*)digest andcontent:(NSString*)feedcontent
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/feedback", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:feedcontent forKey:@"feedcontent"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_AllSameModel *outModel = [[Out_AllSameModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}



///发送短信
- (Out_LSendMsgModel*)userSendMsgWithModel:(In_LSendMsgModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/sms/sendByMobile", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.mobiles forKey:@"mobiles"];
    [request setPostValue:model.recipients forKey:@"recipients"];
    [request setPostValue:model.senddetail forKey:@"senddetail"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LSendMsgModel *outModel = [[Out_LSendMsgModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
    

}


///订单状态反馈
- (Out_LOrderStatusFeedbackModel*)orderStatusFeedbackWithModel:(In_LOrderStatusFeedbackModel*)model
{
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/sms/sendByMobile", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.cwbs forKey:@"cwbs"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.deliverystate] forKey:@"cwbs"];
    [request setPostValue:model.exptioncode forKey:@"exptioncode"];
    [request setPostValue:model.nextdispatchtime forKey:@"nextdispatchtime"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.paywayid] forKey:@"paywayid"];
    [request setPostValue:[NSString stringWithFormat:@"%0.2f",model.cash] forKey:@"cash"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_LOrderStatusFeedbackModel *outModel = [[Out_LOrderStatusFeedbackModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
    

}

//帐号绑定
- (NSDictionary *)QiYeRenZhengWithModel:(In_QiYeModel *)model{
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/authentication", LogisticsHOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.mobile forKey:@"mobile"];
    [request setPostValue:model.notifyid forKey:@"notifyid"];
    [request setPostValue:model.companycode forKey:@"companycode"];
    [request setPostValue:model.username forKey:@"username"];
    [request setPostValue:model.password forKey:@"password"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
//            Out_QiYeModel *outModel = [[Out_QiYeModel alloc] initWithDictionary:ReturnDic error:nil];
            return ReturnDic;
        }else{
            return nil;
        }
        
    }
    
    return nil;
}
#pragma mark 雏燕对接   帐号绑定
- (NSDictionary *)CertificateVControllerWithModel:(In_QiYeModel *)model{
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/changeSys", LogisticsHOSTURL];
    
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.mobile forKey:@"mobile"];
    [request setPostValue:model.notifyid forKey:@"notifyid"];
    [request setPostValue:model.companycode forKey:@"companycode"];
    [request setPostValue:model.username forKey:@"username"];
    [request setPostValue:model.password forKey:@"password"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
//            Out_QiYeModel *outModel = [[Out_QiYeModel alloc] initWithDictionary:ReturnDic error:nil];
            DLog(@"切换系统  %@",ReturnDic);
            return ReturnDic;
        }else{
            return nil;
        }
        
    }
    
    return nil;
}

///缴款前调用
- (NSDictionary *)WorkPayBeforeWithModel:(In_WorkPayBefore *)model{
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/pay/payment/save", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:[NSString stringWithFormat:@"%f",model.payamount] forKey:@"payamount"];
    [request setPostValue:model.terminalno forKey:@"terminalno"];
    [request setPostValue:model.summarytime forKey:@"summarytime"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.paytype] forKey:@"paytype"];
    [request setPostValue:[NSString stringWithFormat:@"%d",2] forKey:@"terminaltype"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
//            Out_WorkPayBefore *outModel = [[Out_WorkPayBefore alloc] initWithDictionary:ReturnDic error:nil];
//            NSDictionary *dic=[ReturnDic objectForKey:@"data"];
//            DLog(@"字典字典%@",ReturnDic);
//            DLog(@"字典3333字典%@",dic);
            
            return ReturnDic;
        }else{
            return nil;
        }
        
    }
    return nil;
    
}
- (Out_WorkPayLater *)WorkPayOverWithModel:(In_WorkPayLater *)model{

    NSString* InPutUrl = [NSString stringWithFormat:@"%@/pay/app/notify", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
     [request setPostValue:model.paystatus forKey:@"paystatus"];
     [request setPostValue:model.payorderno forKey:@"payorderno"];
     [request setPostValue:model.postrace forKey:@"postrace"];
     [request setPostValue:model.traceno forKey:@"traceno"];
    [request setPostValue:model.finishtime forKey:@"finshtime"];
    [request setPostValue:model.terminalno forKey:@"terminalno"];
    [request setPostValue:[NSString stringWithFormat:@"%d",model.paytype] forKey:@"paytype"];
    [request setPostValue:model.aplipayaccount forKey:@"aplipayaccount"];
    [request setPostValue:[NSString stringWithFormat:@"%d",2] forKey:@"terminaltype"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            Out_WorkPayLater *outModel = [[Out_WorkPayLater alloc] initWithDictionary:ReturnDic error:nil];
        

            return outModel;
        }else{

            return nil;
        }
        
    }
    return nil;
    
}
#pragma mark 扫描二维码
-(out_ScanModel *)scanErWeiMaWithInModel:(In_ScanModel *)model{
    
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/pay/getQrCode", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.trade_no forKey:@"trade_no"];
    [request setPostValue:model.subjectName forKey:@"subjectName"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            out_ScanModel *outModel = [[out_ScanModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;

    
}
#pragma mark   获取当前版本号
-(void)getVerisonWithMsg:(NSString *)msg  resultDic:(void (^)(NSDictionary *dic))dic;
{
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/pay/getQrCode", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:msg forKey:@"key"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
          
            dic(ReturnDic);
        }else{
            return;
        }
        
    }
}
-(void)getVerisonFromAppStoreWithResultDic:(void (^)(NSDictionary *dic))dic;
{
    
    NSString* InPutUrl = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup"];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:@"1102695904" forKey:@"id"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            
            dic(ReturnDic);
        }else{
            return;
        }
        
    }
}
-(Out_chagnPswModel *)changePswWithInModel:(in_chagnPswModel *)model digest:(NSString *)digest andKey:(NSString *)key{
 
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/updateThirdPasswordForApp", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request setPostValue:digest forKey:@"digest"];
    [request setPostValue:key forKey:@"key"];
    [request setPostValue:model.phone forKey:@"mobile"];
    [request setPostValue:model.psw forKey:@"password"];
//    [request setPostValue:model.key forKey:@"key"];
//    [request setPostValue:model.digest forKey:@"digest"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];

        if (ReturnDic) {
            DLog(@"修改密码输出%@",ReturnDic);
            Out_chagnPswModel *outModel = [[Out_chagnPswModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
        
    }
    return nil;
}
#pragma mark----------修改手机号码
- (out_chagnPhoneNumberModel*)changtelephoneNumberWithModel:(in_chagnPhoneNumberModel*)model{
    
    
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/user/updatePhone", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:model.key forKey:@"key"];
    [request setPostValue:model.digest forKey:@"digest"];
    [request setPostValue:model.oldPhone forKey:@"oldPhone"];
    [request setPostValue:model.Phone forKey:@"newPhone"];
    
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (ReturnDic) {
            out_chagnPhoneNumberModel *outModel = [[out_chagnPhoneNumberModel alloc] initWithDictionary:ReturnDic error:nil];
            return outModel;
        }else{
            return nil;
        }
    }
    return nil;
}

//创建图片
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}


//加密
-(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    return HMAC;
}


//数组排序 和加密
- (NSString*)ArrayCompareAndHMac:(NSArray*)array
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    // 返回一个排好序的数组，原来数组的元素顺序不会改变
    // 指定元素的比较方法：compare:
    NSString *tempContent = @"";
    NSArray *array2 = [array sortedArrayUsingSelector:@selector(compare:)];
    for (int i = 0; i<[array2 count]; i++) {
        NSString *temp = [array2 objectAtIndex:i];
        tempContent = [NSString stringWithFormat:@"%@%@",tempContent,temp];
    }
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        const char *cKey  = [userInfoModel.primaryKey cStringUsingEncoding:NSASCIIStringEncoding];
        const char *cData = [tempContent cStringUsingEncoding:NSUTF8StringEncoding];
        unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
        NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
        const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
        NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
        for (int i = 0; i < HMACData.length; ++i){
            [HMAC appendFormat:@"%02x", buffer[i]];
        }
        return HMAC;
    }else
    {
        return tempContent;
    }
    
    
}


#pragma mark 验证手机号码
- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    
    NSString *regex =  @"^1+[3578]+\\d{9}";
   
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    
    
    
    return YES;
    
}

//md5加密
- (NSString *) getmd5:(NSString *)str

{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString
            
            stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            result[0], result[1],
            
            result[2], result[3],
            
            result[4], result[5],
            
            result[6], result[7],
            
            result[8], result[9],
            
            result[10], result[11],
            
            result[12], result[13],
            
            result[14], result[15]
            
            ];
    
}
#pragma mark --------------------------------------------------
#pragma mark  AFNetworking  获取送货列表


-(void)sendGoodsListWithMsg:(In_DeliveringGoodsModel *)model  resultDic:(void (^)(NSDictionary *dic))dic{
    NSMutableDictionary *request=[[NSMutableDictionary alloc]init];
    [request setObject:model.key forKey:@"key"];
    [request setObject:model.digest forKey:@"digest"];
    [request setObject:[NSString stringWithFormat:@"%d",model.offset] forKey:@"offset"];
    [request setObject:[NSString stringWithFormat:@"%d",model.pagesize] forKey:@"pagesize"];
    [request setObject:[NSString stringWithFormat:@"%d",model.deliverystate] forKey:@"deliverystate"];
    [request setObject:[NSString stringWithFormat:@"%f",model.lon] forKey:@"lon"];
    [request setObject:[NSString stringWithFormat:@"%f",model.lat] forKey:@"lat"];
    [request setObject:[NSString stringWithFormat:@"%@",model.searchstr] forKey:@"searchstr"];

    
    NSString *url=[NSString stringWithFormat:@"%@/delivery/dispatch", LogisticsHOSTURL];
    
    [self getMessageUsePostWithDic:request url:url result:^(NSDictionary *resultDic) {
        DLog(@"订单列表dic%@",resultDic);

//        Out_LDeliveringModel *outModel = [[Out_LDeliveringModel alloc] initWithDictionary:resultDic error:nil];
        
            
        dic(resultDic);
    }];
}

#pragma mark 网络请求时对AFnetWork的封装
-(void)getMessageUsePostWithDic:(NSDictionary *)dic url:(NSString *)url result:(void(^)(NSDictionary * resultDic))resultDic{
    if ([[dic objectForKey:@"digest"] isEqualToString:@""]) {
        return;
    }
    _manager =[AFHTTPSessionManager manager];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [_manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithBytes:[responseObject bytes] length:[responseObject length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        DLog(@"url***%@",url);
        DLog(@"dic***%@",dicJson);
        resultDic(dicJson);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"失败%@",error);
        
    }];
    
}
@end
