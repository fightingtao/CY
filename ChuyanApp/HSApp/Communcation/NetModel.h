//
//  NetModel.h
//  HSApp
//
//  Created by xc on 15/12/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "JSONModel.h"

@interface NetModel : JSONModel

@end

///通用返回model
@interface Out_AllSameModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end


///获取注册验证码Model
@interface In_RegisterCodeModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*telephone;

@end

@interface Out_RegisterCodeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///注册账号Model
@interface In_RegisterModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*cityname;
@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*inviteCode;

@end

@protocol OutRegisterBody <NSObject>
@end

@interface OutRegisterBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*primaryKey;
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*type;
@property (nonatomic, strong) NSString <Optional>*status;
@property (nonatomic, strong) NSString <Optional>*isdelete;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*gender;
@property (nonatomic, strong) NSString <Optional>*notifyid;
@property (nonatomic, strong) NSString <Optional>*level;
@property (nonatomic, strong) NSString <Optional>*point;
@property (nonatomic, strong) NSString <Optional>*istested;
@property (nonatomic, strong) NSString <Optional>*istrained;
@property (nonatomic, strong) NSString <Optional>*cityName;
@property (nonatomic, strong) NSString <Optional>*tag;
@property (nonatomic, strong) NSString <Optional>*positiveIdPath;
@property (nonatomic, strong) NSString <Optional>*negativeIdPath;
@property (nonatomic, strong) NSString <Optional>*handIdPath;
@property (nonatomic, strong) NSString <Optional>*authenTelephone;
@property (nonatomic, strong) NSString <Optional>*realName;
@property (nonatomic, strong) NSString <Optional>*idNum;
@property (nonatomic, strong) NSString <Optional>*brokerStatus;
@property (nonatomic, strong) NSString <Optional>* isbroker;
@property (nonatomic, strong) NSString <Optional>*declaration;
@property (nonatomic, strong) NSString <Optional>*birthday;
@property (nonatomic, strong) NSString <Optional>*isauthen;
@property (nonatomic, strong) NSString <Optional>* stars;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*isSetPayPassword;
@property (nonatomic, strong) NSString <Optional>*isBindWithdrawAccount;
@property (nonatomic, strong) NSString <Optional>*iswork;
@end


@interface Out_RegisterModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) OutRegisterBody <Optional>*data;

@end
//-------------------------------------------------------------


///获取登录验证码Model
@interface In_LoginCodeModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*telephone;

@end

@interface Out_LoginCodeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------


///用户登录Model
@interface In_LoginModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*employeeno;
@property (nonatomic, strong) NSString <Optional>*password;

@end

@protocol OutLoginBody <NSObject>
@end

@interface OutLoginBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*primaryKey;
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*type;
@property (nonatomic, strong) NSString <Optional>*status;
@property (nonatomic, strong) NSString <Optional>*isdelete;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*gender;
@property (nonatomic, strong) NSString <Optional>*notifyid;
@property (nonatomic, strong) NSString <Optional>*level;
@property (nonatomic, strong) NSString <Optional>* point;
@property (nonatomic, strong) NSString <Optional>*istested;
@property (nonatomic, strong) NSString <Optional>*istrained;
@property (nonatomic, strong) NSString <Optional>*cityName;
@property (nonatomic, strong) NSString <Optional>*tag;
@property (nonatomic, strong) NSString <Optional>*positiveIdPath;//身份证正面照片地址
@property (nonatomic, strong) NSString <Optional>*negativeIdPath;//身份证反面照片地址

@property (nonatomic, strong) NSString <Optional>*handIdPath;//手持身份证照片地址

@property (nonatomic, strong) NSString <Optional>*authenTelephone;//经纪人认证手机号
@property (nonatomic, strong) NSString <Optional>*realName;
@property (nonatomic, strong) NSString <Optional>*idNum;//身份证号
@property (nonatomic, strong) NSString <Optional>*brokerStatus;
@property (nonatomic, strong) NSString <Optional>*isbroker;
@property (nonatomic, strong) NSString <Optional>*declaration;//经纪人抢单宣言
@property (nonatomic, strong) NSString <Optional>*birthday;
@property (nonatomic, strong) NSString <Optional>*isauthen;
@property (nonatomic, strong) NSString <Optional>*stars;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*isSetPayPassword;//0表示没有设置支付密码，1表示设置了支付密码
@property (nonatomic, strong) NSString <Optional>*isBindWithdrawAccount;//0表示没有绑定支付宝，1表示绑定了支付宝
@property (nonatomic, strong) NSString <Optional>* iswork;

@property(nonatomic,strong)NSString <Optional>*companycode;

@end

@interface Out_LoginModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) OutLoginBody <Optional>*data;

@end
//-------------------------------------------------------------

///获取小费Model
@protocol OutTipsBody <NSObject>
@end

@interface OutTipsBody : JSONModel

@property int tipid;
@property double tip;
@end


@interface Out_TipsModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutTipsBody, Optional> *data;

@end
//-------------------------------------------------------------



///获取订单类型Model
@protocol OutTypeBody <NSObject>
@end

@interface OutTypeBody : JSONModel

@property int typeId;
@property (nonatomic, strong) NSString <Optional>*type_name;
@end


@interface Out_TypeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutTypeBody, Optional> *data;

@end
//-------------------------------------------------------------



///获取常用地址Model
@interface In_AddressModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userId;

@end

@protocol OutAddressBody <NSObject>
@end

@interface OutAddressBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*addressid;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*text;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property int isdelete;
@property long create_date;
@property long update_date;

@end


@interface Out_AddressModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutAddressBody, Optional> *data;

@end
//-------------------------------------------------------------

///新增常用地址Model
@interface In_AddAddressModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*text;
@end


@interface Out_AddAddressModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) OutAddressBody<Optional> *data;

@end
//-------------------------------------------------------------


///获取培训内容Model
@protocol OutTrainBody <NSObject>
@end

@interface OutTrainBody : JSONModel

@property long createDate;
@property long updateDate;
@property int trainPicId;
@property (nonatomic, strong) NSString <Optional>*picPath;
@property int index;
@property long createtime;
@property long updatetime;
@end


@interface Out_TrainModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutTrainBody, Optional> *data;

@end
//-------------------------------------------------------------


///完成培训model
@interface In_CompleteTrainModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*brokerid;

@end

@interface Out_ComPleteTrainModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///获取测试内容Model
@protocol OutTestBody <NSObject>
@end

@interface OutTestBody : JSONModel

@property long createDate;
@property long updateDate;
@property int testId;
@property (nonatomic, strong) NSString <Optional>*answer;
@property int correct;
@property int index;
@property long createtime;
@property long updatetime;
@end



@interface Out_TestModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutTestBody, Optional> *data;

@end
//-------------------------------------------------------------

///完成测试model
@interface In_CompleteTestModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*brokerid;

@end

@interface Out_ComPleteTestModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///删除常用地址model
@interface In_DeleteAddressModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*addressid;
@end

@interface Out_DeleteAddressModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///修改常用地址model

@interface In_UpdateAddressModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property (nonatomic, strong) NSString <Optional>*text;
@property (nonatomic, strong) NSString <Optional>*addressid;

@end

@interface Out_UpdateAddressModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end



//-------------------------------------------------------------

///获取呼单圈内容Model
@protocol OutHomeListBody <NSObject>
@end

@interface OutHomeListBody : JSONModel


@property (nonatomic, strong) NSString <Optional>*orderId;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*userId;
@property int type;
@property (nonatomic, strong) NSString <Optional>*voicePath;
@property int orderTypeId;
@property (nonatomic, strong) NSArray <Optional>*picpaths;
@property (nonatomic, strong) NSString <Optional>*fromAddress;
@property (nonatomic, strong) NSString <Optional>*toAddress;
@property (nonatomic, strong) NSString <Optional>*uName;
@property (nonatomic, strong) NSString <Optional>*uHeader;
@property long createTime;
@property int eCount;
@property int zCount;
@property double tip;
@property long row_id;
@end



@interface Out_HomeListModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutHomeListBody, Optional> *data;

@end
//-------------------------------------------------------------

///发布订单model
@interface In_PublishOrderModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*tip;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*type;
@property (nonatomic, strong) NSString <Optional>*orderTypeId;
@property (nonatomic, strong) NSString <Optional>*cityname;
@property (nonatomic, strong) NSString <Optional>*lng;
@property (nonatomic, strong) NSString <Optional>*lat;
@property (nonatomic, strong) NSString <Optional>*advertId;
@property (nonatomic, strong) NSString <Optional>*addressId;
@property (nonatomic, strong) NSString <Optional>*toAddressId;
@property (nonatomic, strong) NSString <Optional>*voicePath;
@property (nonatomic, strong) NSString <Optional>*picurls;

@end

@interface Out_PulishOrderModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///认证经纪人model
@interface In_AuthenBrokerModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*positiveIdPath;
@property (nonatomic, strong) NSString <Optional>*negativeIdPath;
@property (nonatomic, strong) NSString <Optional>*handIdPath;
@property (nonatomic, strong) NSString <Optional>*authenTelephone;
@property (nonatomic, strong) NSString <Optional>*realName;
@property (nonatomic, strong) NSString <Optional>*idNum;

@end

@interface Out_AuthenBrokerModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///获取首页广告model
@protocol OutAdVertBody <NSObject>
@end

@interface OutAdVertBody : JSONModel

@property int advertid;
@property (nonatomic, strong) NSString <Optional>*desc;
@property int type;
@property (nonatomic, strong) NSString <Optional>*url;
@property (nonatomic, strong) NSString <Optional>*pic_path;
@property (nonatomic, strong) NSString <Optional>*cityname;

@end



@protocol Out_ADInfoBody <NSObject>
@end
@interface Out_ADInfoBody : JSONModel

@property (nonatomic, strong) NSArray <ConvertOnDemand, OutAdVertBody, Optional> *adverts;
@property int brokerCount;

@end


@interface Out_AdvertModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_ADInfoBody <Optional>*data;

@end
//-------------------------------------------------------------

///获取钱包信息model
@protocol Out_MoneyBody <NSObject>
@end
@interface Out_MoneyBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*user_id;
@property int status;
@property double recharge_amount;
@property double purchase_amount;
@property double tip_amount;
@property double frozen_amount;
@property double withdrawAmount;

@end

@interface Out_MoneyModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_MoneyBody <Optional>*data;
@end
//-------------------------------------------------------------
///支付钱包验证码model
@interface Out_MoneyCodeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------
///设置或修改支付钱包model
@interface In_SetMoneyPwdModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*password;
@property (nonatomic, strong) NSString <Optional>*code;

@end

@interface Out_SetMoneyPwdModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///获取经纪人端待接单列表model
@interface In_WaitOrderListModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*cityname;
@property int type;
@property (nonatomic, strong) NSString <Optional>*lastDate;
@property (nonatomic, strong) NSString <Optional>*lastorderid;

@end

@protocol OutWaitOrderListBody <NSObject>
@end

@interface OutWaitOrderListBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*orderId;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*userId;
@property int type;
@property (nonatomic, strong) NSString <Optional>*voicePath;
@property int orderTypeId;
@property (nonatomic, strong) NSArray <Optional>*picpaths;
@property (nonatomic, strong) NSString <Optional>*fromAddress;
@property (nonatomic, strong) NSString <Optional>*toAddress;
@property (nonatomic, strong) NSString <Optional>*uName;
@property (nonatomic, strong) NSString <Optional>*uHeader;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*lng;
@property (nonatomic, strong) NSString <Optional>*lat;
@property long row_id;
@property double tip;

@end

@interface Out_WaitOrderListModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, OutWaitOrderListBody, Optional> *data;

@end
//-------------------------------------------------------------

///经纪人抢单model
@interface In_GetOrderModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*lng;
@property (nonatomic, strong) NSString <Optional>*lat;

@end

@interface Out_GetOrderModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///已抢单经纪人model
@interface In_GetOrderBrokerModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property (nonatomic, strong) NSString <Optional>*type;

@end

@protocol Out_GetOrderBrokerBody <NSObject>

@end

@interface Out_GetOrderBrokerBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*orderbrokerid;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*declaration;
@property (nonatomic, strong) NSString <Optional>*title;
@property double stars;
@property double distance;
@property long point;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*user_id;

@end

@interface Out_GetOrderBrokerModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_GetOrderBrokerBody, Optional>*data;

@end
//-------------------------------------------------------------

///呼单列表model
@interface In_OrderIngListModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*usertype;
@property (nonatomic, strong) NSString <Optional>*type;
@property (nonatomic, strong) NSString <Optional>*lastDate;
@property (nonatomic, strong) NSString <Optional>*lastorderid;

@end

@protocol Out_OrderIngListBody <NSObject>

@end

@interface Out_OrderIngListBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*orderId;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*userId;
@property int type;
@property (nonatomic, strong) NSString <Optional>*voicePath;
@property int orderTypeId;
@property (nonatomic, strong) NSArray <Optional>*picpaths;
@property (nonatomic, strong) NSString <Optional>*fromAddress;
@property (nonatomic, strong) NSString <Optional>*toAddress;
@property (nonatomic, strong) NSString <Optional>*uName;
@property (nonatomic, strong) NSString <Optional>*uHeader;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property int statusId;
@property long row_id;
@property double tip;
@property (nonatomic, strong) NSString <Optional>*fromTelephone;
@property (nonatomic, strong) NSString <Optional>*toTelephone;
@property (nonatomic, strong) NSString <Optional>*uTelephone;
@property (nonatomic, strong) NSString <Optional>*bTelephone;
@property int isEvaluated;
@end

@interface Out_OrderIngListModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_OrderIngListBody, Optional>*data;

@end


//-------------------------------------------------------------

///绑定提现账号model
@interface In_BindingWithdrawAccountModel: JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*account_no;
@property (nonatomic, strong) NSString <Optional>*code;
@property int account_type;
@property (nonatomic, strong) NSString <Optional>*real_name;

@end

@interface Out_BindingWithdrawAccountModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;
@end

//-------------------------------------------------------------

///选择经纪人model
@interface Out_ChooseBrokerModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///修改用户资料model
@interface In_UpdateUserInfoModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*birthday;
@property int gender;

@end

@interface Out_UpdateUserInfoModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///刷新用户信息model
@interface Out_RefreshUserInfoModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) OutLoginBody <Optional>*data;

@end
//-------------------------------------------------------------

///编辑江湖口号model
@interface In_EditUserDeclare : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*declaration;

@end


@interface Out_EditUserDeclare : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///雇主确认订单model
@interface Out_CustomerConfirmOrderModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
//-------------------------------------------------------------

///呼单详情model
@protocol Out_OrderDetailBody <NSObject>

@end

@interface Out_OrderDetailBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*orderId;
@property (nonatomic, strong) NSString <Optional>*orderNo;
@property (nonatomic, strong) NSString <Optional>*desc;
@property double tip;
@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*brokerId;
@property int type;
@property double fee;
@property (nonatomic, strong) NSString <Optional>*addressId;
@property (nonatomic, strong) NSString <Optional>*toAddressId;
@property (nonatomic, strong) NSString <Optional>*voicePath;
@property (nonatomic, strong) NSString <Optional>*cityname;
@property double discount;
@property int advertId;
@property int statusId;
@property int needCancel;
@property int orderTypeId;
@property (nonatomic, strong) NSString <Optional>*lng;
@property (nonatomic, strong) NSString <Optional>*lat;
@property (nonatomic, strong) NSArray <Optional>*picpaths;
@property (nonatomic, strong) NSString <Optional>*picurls;
@property (nonatomic, strong) NSString <Optional>*fromName;
@property (nonatomic, strong) NSString <Optional>*fromAddress;
@property (nonatomic, strong) NSString <Optional>*fromTelephone;
@property (nonatomic, strong) NSString <Optional>*toName;
@property (nonatomic, strong) NSString <Optional>*toAddress;
@property (nonatomic, strong) NSString <Optional>*toTelephone;
@property (nonatomic, strong) NSString <Optional>*uName;
@property (nonatomic, strong) NSString <Optional>*uHeader;
@property (nonatomic, strong) NSString <Optional>*uTelephone;
@property (nonatomic, strong) NSString <Optional>*bName;
@property (nonatomic, strong) NSString <Optional>*bHeader;
@property (nonatomic, strong) NSString <Optional>*bTelephone;
@property double redAmount;
@property int redType;
@property (nonatomic, strong) NSString <Optional>*redDesc;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*updateTime;
@property int isEvaluated;

@end

@interface Out_OrderDetailModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_OrderDetailBody
<Optional>*data;

@end
//-------------------------------------------------------------

///获取评价列表model
@interface In_CommentListModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property long lastDate;
@property long lastrowid;
@property int type;

@end


@protocol Out_CommentListBody <NSObject>

@end

@interface Out_CommentListBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*evaluateid;
@property double point;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property (nonatomic, strong) NSString <Optional>*userid;
@property long create_date;
@property long row_id;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*username;
@end


@interface Out_CommentListModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_CommentListBody, Optional> *data;

@end
//-------------------------------------------------------------


///支付前订单详细信息model

@protocol Out_ReadyPayDetailBody <NSObject>

@end

@interface Out_ReadyPayDetailBody : JSONModel

@property double fee;
@property double discount;
@property double tip;
@property (nonatomic, strong) NSString <Optional>*orderId;
@property double balance;

@end

@interface Out_ReadyPayDetailModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_ReadyPayDetailBody<Optional> *data;

@end
//-------------------------------------------------------------


///呼单圈点赞model

@protocol Out_OrderPraiseBody <NSObject>

@end


@interface Out_OrderPraiseBody : JSONModel

@property int zan_flag;

@end

@interface Out_OrderPraiseModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_OrderPraiseBody<Optional> *data;

@end
//---------------------------------------------------------------

///获取评价时用户信息model
@protocol Out_CommentUserBody <NSObject>

@end

@interface Out_CommentUserBody : JSONModel

@property (nonatomic, strong) NSString<Optional> *orderId;
@property (nonatomic, strong) NSString<Optional> *username;
@property (nonatomic, strong) NSString<Optional> *title;
@property double stars;
@property long point;
@property (nonatomic, strong) NSString<Optional> *declaration;
@property (nonatomic, strong) NSString<Optional> *header;

@end


@interface Out_CommentUserModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_CommentUserBody<Optional> *data;

@end
//---------------------------------------------------------------


///用户评价model
@interface In_UserCommentModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;//	string	用户id
@property (nonatomic, strong) NSString <Optional>*digest;//	string	token
@property (nonatomic, strong) NSString <Optional>*userid;//	string	用户id
@property (nonatomic, strong) NSString <Optional>*orderid;//	string	订单id
@property (nonatomic, strong) NSString <Optional>*content;//	string	评论内容
@property double point;//	double	评分

@end

@interface Out_UserCommentModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString<Optional> *data;

@end
//---------------------------------------------------------------


///呼单圈动态model
@protocol OutZANSBody <NSObject>

@end
@interface OutZANSBody : JSONModel

@property long zid;
@property (nonatomic, strong) NSString<Optional> *header;

@end


@protocol Out_OrderDynamicBody <NSObject>

@end

@interface Out_OrderDynamicBody : JSONModel

@property (nonatomic, strong) NSString<Optional> *orderId;
@property (nonatomic, strong) NSString<Optional> *orderNo;
@property (nonatomic, strong) NSString<Optional> *desc;
@property double tip;
@property int type;
@property (nonatomic, strong) NSString<Optional> *fromAddress;
@property (nonatomic, strong) NSString<Optional> *toAddress;
@property (nonatomic, strong) NSString<Optional> *voicePath;
@property (nonatomic, strong) NSArray<Optional> *picpaths;
@property (nonatomic, strong) NSString<Optional> *uName;
@property (nonatomic, strong) NSString<Optional> *uHeader;
@property int orderTypeId;
@property int cCount;
@property int zCount;
@property (nonatomic, strong) NSArray<ConvertOnDemand, OutZANSBody,Optional> *zans;

@end

@interface Out_OrderDynamicModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_OrderDynamicBody<Optional> *data;

@end
//---------------------------------------------------------------

///用户钱包余额支付model
@interface In_UserPacketPayModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property (nonatomic, strong) NSString <Optional>*redid;
@property (nonatomic, strong) NSString <Optional>*password;

@end

@interface Out_UserPacketPayModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString<Optional> *data;

@end
//---------------------------------------------------------------

///订单状态列表model
@protocol Out_OrderDetailStatusBody <NSObject>

@end

@interface Out_OrderDetailStatusBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*progressid;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property int order_status;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>* user_msg;
@property long create_date;

@end

@interface Out_OrderDetailStatusModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_OrderDetailStatusBody,Optional> *data;

@end
//---------------------------------------------------------------

///充值金额列表model
@protocol Out_RechargeMoneyBody <NSObject>

@end

@interface Out_RechargeMoneyBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*rechargeid;
@property (nonatomic, strong) NSString <Optional>*recharge_desc;
@property double amount;
@property double give_amount;

@end

@interface Out_RechargeMoneyModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_RechargeMoneyBody,Optional> *data;

@end
//---------------------------------------------------------------


///获取红包列表model

@interface In_RedPacketModel :JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property int type;

@end

@protocol Out_RedPacketBody <NSObject>

@end


@interface Out_RedPacketBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*redid;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*red_desc;
@property (nonatomic, strong) NSString <Optional>*order_id;
@property double amount;
@property int red_status;
@property int red_type;
@property long create_date;
@property (nonatomic, strong) NSString <Optional>*cityname;
@property long active_begin_time;
@property long active_end_time;

@end

@interface Out_RedPacketModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_RedPacketBody,Optional> *data;
@end
//---------------------------------------------------------------


///呼单动态评论列表model
@interface In_OrderDynamicCommentModel :JSONModel


@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property long lastDate;
@property long lastrowid;

@end

@protocol Out_OrderDynamicCommentBody <NSObject>

@end

@interface Out_OrderDynamicCommentBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*commentid;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*order_id;

@property (nonatomic, strong) NSString <Optional>*parent_comment_id;
@property long create_date;
@property long row_id;
@property (nonatomic, strong) NSString <Optional>*parent_username;
@property (nonatomic, strong) NSString <Optional>*username;
@property (nonatomic, strong) NSString <Optional>*header;

@end


@interface Out_OrderDynamicCommentModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_OrderDynamicCommentBody,Optional> *data;
@end
//---------------------------------------------------------------

///根据类型查询明细model
@interface In_BillsDetailModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property long lastDate;
@property long lastrowid;
@property int type;

@end

@protocol Out_BillsDetailBody <NSObject>

@end

@interface Out_BillsDetailBody : JSONModel

@property int trade_type;
@property (nonatomic, strong) NSString <Optional>*trade_desc;
@property long trade_time;
@property double brokerAmount;
@property long row_id;

@end


@protocol Out_BillsDetailTotalBody <NSObject>

@end

@interface Out_BillsDetailTotalBody :JSONModel

@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_BillsDetailBody,Optional> *bills;
@property double availableAmount;
@property double historyAmount;

@end



@interface Out_BillsDetailModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_BillsDetailTotalBody<Optional> *data;

@end
//---------------------------------------------------------------


///获取热线电话model
@protocol Out_HotLineBody <NSObject>

@end

@interface Out_HotLineBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*hotline;

@end

@interface Out_HotLineModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_HotLineBody<Optional> *data;

@end
//---------------------------------------------------------------


///意见反馈model
@interface In_FeedbackModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*text;
@property (nonatomic, strong) NSString <Optional>*version;
@property (nonatomic, strong) NSString <Optional>*system;

@end
@interface Out_FeedbackModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString<Optional>*data;

@end

//---------------------------------------------------------------

///钱包账单model
@protocol Out_PacketBillsBody <NSObject>

@end

@interface Out_PacketBillsBody : JSONModel

@property int trade_type;
@property (nonatomic, strong) NSString <Optional>*trade_desc;
@property long trade_time;
@property double brokerAmount;
@property long row_id;
@property double amount;

@end

@interface Out_PacketBillsModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand, Out_PacketBillsBody,Optional> *data;

@end
//---------------------------------------------------------------

///接单前取消呼单model
@interface Out_CancelOrderBeforeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString<Optional> *data;

@end
//---------------------------------------------------------------

///追加小费
///通用model

//---------------------------------------------------------------
///提现model
@interface In_WithdrawCashModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*bindaccountid;
@property double amount;
@property (nonatomic, strong) NSString <Optional>*password;

@end

//---------------------------------------------------------------

///获取绑定提现账号model
@protocol Out_WithdrawBindingBody <NSObject>

@end

@interface Out_WithdrawBindingBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*bindid;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property int account_type;
@property (nonatomic, strong) NSString <Optional>*account_no;
@property (nonatomic, strong) NSString <Optional>*real_name;

@end

@interface Out_WithdrawBindingModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand,Out_WithdrawBindingBody,Optional> *data;

@end

//-----------------------------------------------------------------

///获取消息（通知，动态）model
@interface In_HSMessageModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userid;
@property long lastDate;
@property long lastrowid;
@property int type;

@end

@protocol Out_HSMessageBody <NSObject>

@end

@interface Out_HSMessageBody : JSONModel

@property long messageId;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*userId;
@property int userType;
@property int type;
@property (nonatomic, strong) NSString <Optional>*orderId;
@property (nonatomic, strong) NSString <Optional>*fromUserId;
@property long createtime;
@property long updatetime;
@property (nonatomic, strong) NSString <Optional>*header;

@end

@interface Out_HSMessageModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray<ConvertOnDemand,Out_HSMessageBody,Optional> *data;

@end

//-----------------------------------------------------------------


///推荐有奖model
@protocol Out_InviteBody <NSObject>

@end

@interface Out_InviteBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*inviteCode;
@property double inviteAmount;

@end

@interface Out_InviteModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_InviteBody <Optional> *data;

@end
//-----------------------------------------------------------------

///是否接收推送model
//使用通用返回model

//-----------------------------------------------------------------

///呼单动态添加评论model
@interface In_AddDynamicCommentModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property (nonatomic, strong) NSString <Optional>*order_id;
@property (nonatomic, strong) NSString <Optional>*parent_comment_id;
@property (nonatomic, strong) NSString <Optional>*content;

@end

//返回使用通用model
//-----------------------------------------------------------------


///投诉model
@interface In_ComplainModel :JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*userid;
@property (nonatomic, strong) NSString <Optional>*orderid;
@property (nonatomic, strong) NSString <Optional>*text;
@property (nonatomic, strong) NSString <Optional>*telephone;

@end
//返回使用通用model
//-----------------------------------------------------------------

///查看用户个人信息model
@protocol Out_CheckUserInfoBody <NSObject>

@end

@interface Out_CheckUserInfoBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*header;
@property (nonatomic, strong) NSString <Optional>*telephone;
@property int sex;
@property (nonatomic, strong) NSString <Optional>*username;
@property int age;
@property int point;
@property double stars;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*declaration;

@end

@interface Out_CheckUserInfoModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_CheckUserInfoBody<Optional> *data;

@end

//-----------------------------------------------------------------

///生成支付订单并支付model
@interface In_OrderPayModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property int coupon_type;
@property (nonatomic, strong) NSString <Optional>*coupon_id;
@property int pay_type;
@property int pay_way;
@property (nonatomic, strong) NSString <Optional>*order_id;
@property (nonatomic, strong) NSString <Optional>*user_id;

@end


@protocol Out_orderPayAliBody <NSObject>

@end
@interface Out_orderPayAliBody :JSONModel

@property (nonatomic, strong) NSString <Optional>*payid;
@property int pay_type;
@property int pay_way;
@property double amount;
@property (nonatomic, strong) NSString <Optional>*pay_order_no;
@property (nonatomic, strong) NSString <Optional>*user_id;
@property int status;
@property (nonatomic, strong) NSString <Optional>*order_id;
@property int coupon_type;
@property (nonatomic, strong) NSString <Optional>*coupon_id;
@property int create_time;

@end

@protocol Out_orderPayWeChatBody <NSObject>

@end
@interface Out_orderPayWeChatBody :JSONModel

@property (nonatomic, strong) NSString <Optional>*sign;
@property (nonatomic, strong) NSString <Optional>*timestamp;
@property (nonatomic, strong) NSString <Optional>*partnerid;
@property (nonatomic, strong) NSString <Optional>*mch_id;
@property (nonatomic, strong) NSString <Optional>*packages;
@property (nonatomic, strong) NSString <Optional>*prepay_id;
@property (nonatomic, strong) NSString <Optional>*appid;
@property (nonatomic, strong) NSString <Optional>*nonce_str;
@property (nonatomic, strong) NSString <Optional>*trade_type;

@end

@protocol Out_OrderPayAllBody <NSObject>

@end
@interface Out_OrderPayAllBody :JSONModel

@property (nonatomic, strong) Out_orderPayWeChatBody <Optional>*prepay_map;
@property (nonatomic, strong) Out_orderPayAliBody <Optional>*payOrder;
@property (nonatomic, strong) NSString <Optional>*notify_url;
@end

@interface Out_OrderPayModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_OrderPayAllBody<Optional> *data;

@end

//---------------------------物流接口模型--------------------------------------
//***************************************************************************

///扫码领货model
@interface In_LScanGoodsModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*cwbs;
@property (nonatomic, assign) int terminaltype;//终端类型  2 苹果
@end




@protocol Out_LScanFailureBody <NSObject>
@property (nonatomic, strong) NSString <Optional>* reasonmsg;
@end

@interface Out_LScanFailureBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*cwb;
@property (nonatomic, strong) NSString <Optional>*reasoncode;
@property (nonatomic, strong) NSString <Optional>*reasonmsg;

@end



@protocol Out_LScanGoodsBody <NSObject>

@end

@interface Out_LScanGoodsBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*reasonmsg;
@property int successcount;
@property int faliurecount;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LScanFailureBody, Optional> *faliurecwbs;

@end


@interface Out_LScanGoodsModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LScanGoodsBody <Optional> *data;

@end
//-----------------------------------------------------------------

///物流首页model
@protocol Out_LogisticsHomeBody <NSObject>

@end

@interface Out_LogisticsHomeBody : JSONModel

@property int deliverycount;
@property double deliverycod;
@property (nonatomic,strong)NSString <Optional> *companyname;
@property (nonatomic,strong)NSString <Optional> *roleid;
@property (nonatomic,strong)NSString <Optional> *username;//工号
@property (nonatomic,strong)NSString <Optional> *realname;//配送员姓名

@end

@interface Out_LogisticsHomeModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LogisticsHomeBody <Optional> *data;

@end

///送货model
@interface In_DeliveringGoodsModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*searchstr;
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property int offset;
@property int pagesize;
@property int deliverystate;
@property double lon;
@property double lat;
@end


@protocol Out_LOrderListBody <NSObject>
@end

@interface Out_LOrderListBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*dssnname;
@property (nonatomic, strong) NSString <Optional>*deliverytime;
@property (nonatomic, strong) NSString <Optional>*cwb;
@property (nonatomic, strong) NSString <Optional>*distance;
@property (nonatomic, strong) NSString <Optional>*consigneeaddress;
@property (nonatomic, strong) NSString <Optional>*consigneename;
@property (nonatomic, strong) NSString <Optional>*consigneemobile;
@property (nonatomic, strong) NSString <Optional>*cod;
@property (nonatomic, strong) NSString <Optional>*cwbordertypeid;
@property (nonatomic, strong) NSString <Optional>*paybackfee;
@property (nonatomic, strong) NSString <Optional>* deliverystate;
@property (nonatomic, strong) NSString <Optional>* exptcode ;
@property (nonatomic, strong) NSString <Optional>* exptmsg;
@property (nonatomic, strong) NSString <Optional>*nextdeliverytime;
@end

@protocol Out_LDeliveringBody <NSObject>
@end

@interface Out_LDeliveringBody : JSONModel
@property int delivering;
@property (nonatomic, strong) NSString <Optional>* sign;
@property int exception;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LOrderListBody, Optional> *order;
@end


@interface Out_LDeliveringModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LDeliveringBody <Optional> *data;
@end




///获取订单详情
@protocol Out_LOrderDetailBody <NSObject>
@end
/*
*/
@interface Out_LOrderDetailBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*dssnname;
@property (nonatomic, strong) NSString <Optional>*deliverytime;
@property (nonatomic, strong) NSString <Optional>*cwb;
@property (nonatomic, strong) NSString <Optional>*payway;
@property (nonatomic, strong) NSString <Optional>*consigneename;//签收人
@property (nonatomic, strong) NSString <Optional>*consigneemobile;
@property (nonatomic, strong) NSString <Optional>*consigneeaddress;//收件地址
@property (nonatomic, strong) NSString <Optional>* cod;
@property (nonatomic, strong) NSString <Optional>* longitude;
@property (nonatomic, strong) NSString <Optional>*latitude;
@property (nonatomic, strong) NSString <Optional>* state;
@property (nonatomic, strong) NSString <Optional>*exptcode;
@property (nonatomic, strong) NSString <Optional>*realname;
@property (nonatomic, strong) NSString <Optional>*username;

@property (nonatomic, strong) NSString <Optional>*exptmsg;
@property (nonatomic, strong) NSString <Optional>*nextdeliverytime;
@property (nonatomic, strong) NSString <Optional>* cwbordertypeid;//1配送   2上门退  3上门换
@property (nonatomic, strong) NSString <Optional>* paybackfee; // <0 =0  直接签收   <0  跳到支付界面
@end


@interface Out_LOrderDetailModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LOrderDetailBody  *data;
@end


///获取异常列表model
@protocol Out_LExptreasonBody <NSObject>

@end

@interface Out_LExptreasonBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*exptycode;
@property (nonatomic, strong) NSString <Optional>*exptmsg;

@end

@interface Out_LExptreasonModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LExptreasonBody, Optional> *data;

@end

///反馈列表
@interface In_FeedbackOrderidWithModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*cwbs;
@property (nonatomic, strong) NSString <Optional>*exptioncode;//异常原因码 （01 滞留，修改配送时间 02客户拒收 。。。）
@property (nonatomic, strong) NSString <Optional>*nextdispatchtime;//下次配送时间（yyyy-MM-dd）
@property (nonatomic, strong) NSString <Optional>*signman;//签收人
@property (nonatomic, strong) NSString <Optional>*signtime;//签收时间 （yyyy-MM-dd HH:mm:ss）
@property (nonatomic, strong) NSString <Optional>*terminalid;//终端id
@property (nonatomic, strong) NSString <Optional>*postrace;// 流水号
@property (nonatomic, strong) NSString <Optional>*traceno;//银行参考号
@property (nonatomic, assign) int signtypeid;//签收类型 （1本人签收 2他人签收）
@property (nonatomic, assign) int deliverystate;//配送状态 （2配送成功 3滞留 4拒收）
@property (nonatomic, assign) int paywayid;//支付方式id
@property (nonatomic, assign) int cwbordertypeid;//订单类型（1配送 2上门退 3上门换）
@property (nonatomic, assign) double cash;//实收货款金额
@property (nonatomic, assign) int terminaltype;//终端类型 1 android 2 ios
/// 9-5日雏燕对接 添加参数
//@property (nonatomic, strong) NSString <Optional>*tracetime;//交易时间
//@property (nonatomic, strong) NSString <Optional>*cardid;//银行卡或支付宝微信账号
@end

@protocol Out_ContantDataWithModel <NSObject>
@end

@interface Out_ContantDataWithModel: JSONModel
@property (nonatomic, strong) NSString <Optional>*cwb;
@property (nonatomic, strong) NSString <Optional>*reasoncode;
@property (nonatomic, strong) NSString <Optional>*reasonmsg;
@property (nonatomic, strong) NSArray <Optional>*faliurecwbs;
@property int successcount;
@property int failurecount;
@end

@interface Out_FeedbackOrderidWithModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_ContantDataWithModel <Optional> *data;
@end

///个人中心model
@protocol Out_LPersonInfoBody <NSObject>

@end

@interface Out_LPersonInfoBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*company;
@property (nonatomic, strong) NSString <Optional>*employeeno;//工号
@property (nonatomic, strong) NSString <Optional>*branchname;

@end

@interface Out_LPersonInfoModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LPersonInfoBody <Optional> *data;


@end
#pragma mark 缴款
@interface Out_JiaoKuanBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*yingjiaokuan;
@property (nonatomic, strong) NSString <Optional>*yijiaokuan;


@end
@interface Out_jiaoKuanModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_JiaoKuanBody <Optional> *data;


@end
#pragma mark 保存缴款
@interface In_BalanceModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*jsfs;
@property (nonatomic, strong) NSString <Optional>*jkje;
@property (nonatomic, strong) NSString <Optional>*jyh;
@property (nonatomic, strong) NSString <Optional>*remark;
@property (nonatomic, strong) NSString <Optional>*yjze;//应交总额

@end
///工作汇总model

@protocol Out_LWorkReportBody <NSObject>

@end

@interface Out_LWorkReportBody : JSONModel

@property int totalcount;
@property int successcount;
@property int exptcount;
@property double totalmoney;
@property double checkedmoney;
@property double uncheckedmoney;
@property double payfee;
@property double yifuTuiFee;
@property double payedFee;
@end

@interface Out_LWorkReportModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LWorkReportBody <Optional> *data;


@end


///通知model

@interface In_LNotificationModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property int offset;
@property int pagesize;

@end

@protocol Out_LNotificationBody <NSObject>

@end

@interface Out_LNotificationBody : JSONModel

@property (nonatomic, strong) NSString <Optional>*messagetime;
@property (nonatomic, strong) NSString <Optional>*messagetype;
@property (nonatomic, strong) NSString <Optional>*messagecontent;
@property (nonatomic, strong) NSString <Optional>*cwb;

@end

@interface Out_LNotificationModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LNotificationBody, Optional>*data;

@end

///发送短信model
@interface In_LSendMsgModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*mobiles;
@property (nonatomic, strong) NSString <Optional>*recipients;
@property (nonatomic, strong) NSString <Optional>*senddetail;

@end


@protocol Out_LSendMsgBody <NSObject>

@end

@interface Out_LSendMsgBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*mobile;
@property (nonatomic, strong) NSString <Optional>*result;
@end


@interface Out_LSendMsgModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LSendMsgBody, Optional>*data;

@end


///订单状态反馈model
@interface In_LOrderStatusFeedbackModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*key;
@property (nonatomic, strong) NSString <Optional>*digest;
@property (nonatomic, strong) NSString <Optional>*cwbs;
@property int deliverystate;
@property (nonatomic, strong) NSString <Optional>*exptioncode;
@property (nonatomic, strong) NSString <Optional>*nextdispatchtime;
@property int paywayid;
@property double cash;
@property (nonatomic, strong) NSString <Optional>*signman;
@property (nonatomic, strong) NSString <Optional>*signtime;
@end

@protocol Out_LOrderStatusFailureBody <NSObject>
@end

@interface Out_LOrderStatusFailureBody : JSONModel
@property (nonatomic, strong) NSString <Optional>*cwb;
@property (nonatomic, strong) NSString <Optional>*reasoncode;
@property (nonatomic, strong) NSString <Optional>*reasonmsg;
@end


@protocol Out_LOrderStatusBody <NSObject>
@end

@interface Out_LOrderStatusBody : JSONModel

@property int successcount;
@property int failurecount;
@property (nonatomic, strong) NSArray <ConvertOnDemand, Out_LOrderStatusFailureBody, Optional>*failurecwbs;

@end


@interface Out_LOrderStatusFeedbackModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) Out_LOrderStatusBody <Optional> *data;

@end

///绑定帐号
@interface In_QiYeModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *key;
@property (nonatomic, strong) NSString <Optional> *mobile;
@property (nonatomic, strong) NSString <Optional> *notifyid;
@property (nonatomic, strong) NSString <Optional> *companycode;
@property (nonatomic, strong) NSString <Optional> *username;
@property (nonatomic, strong) NSString <Optional> *password;
@property (nonatomic, strong) NSString <Optional> *digest;

@end

@interface Out_QiYeModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) In_QiYeModel <Optional> *data;

@end

///缴款前调用
@interface In_WorkPayBefore : JSONModel
//@property (nonatomic, strong) NSString <Optional> *key;
//@property (nonatomic, strong) NSString <Optional> *digest;
//@property (nonatomic, strong) NSString <Optional> *paystatus;
//@property (nonatomic, strong) NSString <Optional> *payorderno;
//@property (nonatomic, strong) NSString <Optional> *postrace;
//@property (nonatomic, strong) NSString <Optional> *traceno;
//@property int paytype;
//@property (nonatomic, strong) NSString <Optional> *terminalno;
//@property (nonatomic, strong) NSString <Optional> *finishtime;
//@property (nonatomic)
@property (nonatomic, strong) NSString <Optional> *key;
@property (nonatomic, strong) NSString <Optional> *digest;
@property (nonatomic, strong) NSString <Optional> *summarytime;
@property (nonatomic, strong) NSString <Optional> *terminalno;
@property double payfee;
@property double yifuTuiFee;
@property int paytype;
@property double payamount;
@property (nonatomic,assign) int terminaltype;
@end
//缴款后调用
@interface In_WorkPayLater : JSONModel
@property (nonatomic, strong) NSString <Optional> *key;
@property (nonatomic, strong) NSString <Optional> *digest;
@property (nonatomic, strong) NSString <Optional> *paystatus;
@property (nonatomic, strong) NSString <Optional> *payorderno;
@property (nonatomic, strong) NSString <Optional> *postrace;
@property (nonatomic, strong) NSString <Optional> *traceno;
@property int paytype;
@property (nonatomic, strong) NSString <Optional> *terminalno;
@property (nonatomic, strong) NSString <Optional> *finishtime;
@property (nonatomic, strong) NSString <Optional> *aplipayaccount;
@property (nonatomic, assign) int terminaltype;
//@property (nonatomic, strong) NSString <Optional> *summarytime;
//@property (nonatomic, strong) NSString <Optional> *terminalno;
//@property double payfee;
//@property double yifuTuiFee;
//@property int paytype;
//@property double payamount;
@end
@interface Out_WorkPayBefore : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*pay_order_no;
@property (nonatomic, strong) NSString <Optional>*notify_url;
@property (nonatomic, strong) In_QiYeModel <Optional> *data;
@end
@interface Out_WorkPayLater : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) In_QiYeModel <Optional> *data;
@end

///扫描二维码
@interface In_ScanModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *key;
@property (nonatomic, strong) NSString <Optional> *digest;
@property (nonatomic, strong) NSString <Optional> *trade_no;
@property (nonatomic, strong) NSString <Optional> *subjectName;
@end

@interface out_ScanModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional> *data;
@end
//修改企业认证密码
@interface in_chagnPswModel : JSONModel
//@property int code;
@property (nonatomic, strong) NSString <Optional>*phone;
@property (nonatomic, strong) NSString <Optional> *psw;
@end
@interface Out_chagnPswModel : JSONModel

@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;

@end
#pragma mark -----------修改手机号

@interface in_chagnPhoneNumberModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *key;
@property (nonatomic, strong) NSString <Optional> *digest;
@property (nonatomic, strong) NSString <Optional>*oldPhone;
@property (nonatomic, strong) NSString <Optional> *Phone;
@end

@interface out_chagnPhoneNumberModel : JSONModel
@property int code;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*data;
@end



