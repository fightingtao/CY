//
//  communcation.h
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>
#import "publicResource.h"
#import "NetModel.h"

#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

#import "UserInfoSaveModel.h"
#import "DataModels.h"
#define TIMEOUTSECONDS 30


#import "AFHTTPSessionManager.h"

@interface communcation : NSObject
@property (nonatomic,strong)   AFHTTPSessionManager *manager;

+ (id)sharedInstance;

///颜色创建图片
- (UIImage *) createImageWithColor: (UIColor *) color;
///加密
-(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key;
///检查手机号
- (BOOL)checkTel:(NSString *)str;
///排序和加密
- (NSString*)ArrayCompareAndHMac:(NSArray*)array;
///md5加密
- (NSString *) getmd5:(NSString *)str;


///1获取注册验证码接口
- (Out_RegisterCodeModel*)getRegisterCodeWithModel:(In_RegisterCodeModel*)model;
///2注册账号接口
- (Out_RegisterModel*)registerAccountWithModel:(In_RegisterModel*)model;
///3获取登录验证码接口
- (Out_LoginCodeModel*)getLoginCodeWithModel:(In_LoginCodeModel*)model;
///4用户登录接口
- (Out_LoginModel*)userLoginWithModel:(In_LoginModel*)model;
///5获取小费列表接口
- (Out_TipsModel*)getTipsWithKey:(NSString*)key AndDigest:(NSString*)digest;
///6获取订单类型列表
- (Out_TypeModel*)getTypesWithKey:(NSString*)key AndDigest:(NSString*)digest;
///7获取常用地址列表接口
- (Out_AddressModel*)getAddressWithMode:(In_AddressModel*)model;
///8新增常用地址列表接口
- (Out_AddAddressModel*)addNewAddressWithModel:(In_AddAddressModel*)model;
///9获取培训内容接口
- (Out_TrainModel*)getTrainContentWithKey:(NSString*)key AndDigest:(NSString*)digest;
///10完成培训接口
- (Out_ComPleteTrainModel*)completeTrainContentWithKey:(NSString*)key AndDigest:(NSString*)digest AndBrokerId:(NSString*)Id;
///11获取培训内容接口
- (Out_TestModel*)getTestContentWithKey:(NSString*)key AndDigest:(NSString*)digest;
///12完成测试接口
- (Out_ComPleteTestModel*)completeTestContentWithKey:(NSString*)key AndDigest:(NSString*)digest AndBrokerId:(NSString*)Id;
///13删除常用地址接口
- (Out_DeleteAddressModel*)deleteAddressWithModel:(In_DeleteAddressModel*)model;
///14获取呼单圈内容接口
- (Out_HomeListModel*)getHomeContentWithCity:(NSString*)city AndLastDate:(NSString*)date AndOrderId:(NSString*)orderId;
///15发布订单接口
- (Out_PulishOrderModel*)publishOrderWithModel:(In_PublishOrderModel*)model;
///16认证经纪人接口
- (Out_AuthenBrokerModel*)authenBrokerWithModel:(In_AuthenBrokerModel*)model;
///17获取首页广告内容接口
- (Out_AdvertModel*)getHomeAdvertWithCity:(NSString*)city;
///18修改常用地址接口
- (Out_UpdateAddressModel*)updateAddressWithModel:(In_UpdateAddressModel*)model;
///19获取钱包信息接口
- (Out_MoneyModel*)getMoneyInfoWithKey:(NSString*)key AndDigest:(NSString*)digest;
///20获取钱包密码验证码接口
- (Out_MoneyCodeModel*)getMoneyCodeWithPhone:(NSString*)phone AndKey:(NSString*)key AndDigest:(NSString*)digest;
///21设置或修改支付钱包接口
- (Out_SetMoneyPwdModel*)setMoneyPwdWithModel:(In_SetMoneyPwdModel*)model;
///22获取待接单列表接口
- (Out_WaitOrderListModel*)getWaitOrderListWithModel:(In_WaitOrderListModel*)model;
///23经纪人抢单接口
- (Out_GetOrderModel*)getOrderWithModel:(In_GetOrderModel*)model;
///24获取已抢单经纪人列表接口
- (Out_GetOrderBrokerModel*)getOrderBrokerListWithModel:(In_GetOrderBrokerModel*)model;
///25呼单列表接口
- (Out_OrderIngListModel*)getOrderIngListWithModel:(In_OrderIngListModel*)model;
///26绑定提现账号接口
- (Out_BindingWithdrawAccountModel*)bindingWithdrawAccountWithModel:(In_BindingWithdrawAccountModel*)model;
///27选择经纪人接口
- (Out_ChooseBrokerModel*)chooseBrokerWithKey:(NSString*)key AndDegist:(NSString*)degist AndOrderbrokerid:(NSString*)orderbrokerid;
///28修改用户资料接口
- (Out_UpdateUserInfoModel*)updateUserInfoWithModel:(In_UpdateUserInfoModel*)model;
///29刷新用户信息接口
- (Out_RefreshUserInfoModel*)refreshUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest;
///30编辑江湖口号接口
- (Out_EditUserDeclare*)editUserDeclareWithModel:(In_EditUserDeclare*)model;
///31雇主端确认订单完成接口
- (Out_CustomerConfirmOrderModel*)CustomerConfirmOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///32经纪人代送订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDSOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///33经纪人代办订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDBOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///33经纪人代购订单确认完成接口
- (Out_CustomerConfirmOrderModel*)brokerConfirmDGOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndFee:(NSString*)fee;
///34获取订单详情接口
- (Out_OrderDetailModel*)getOrderDetailWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndType:(NSString*)type;
///35获取评论列表接口
- (Out_CommentListModel*)getCommentListWithModel:(In_CommentListModel*)model;
///36支付前获取订单信息接口
- (Out_ReadyPayDetailModel*)getReadyPayDetailWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///37呼单圈点赞接口
- (Out_OrderPraiseModel*)orderPraiseWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///38获取评价用户信息接口
- (Out_CommentUserModel*)getCommentUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndType:(NSString*)type;
///39评价用户接口
- (Out_UserCommentModel*)userCommentUserWithModel:(In_UserCommentModel*)model;
///40获取订单动态接口
- (Out_OrderDynamicModel*)getOrderDynamicWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///41余额支付接口
- (Out_UserPacketPayModel*)packetPayWithModel:(In_UserPacketPayModel*)model;
///42获取订单详情中的订单状态列表接口
- (Out_OrderDetailStatusModel*)getOrderDetailStatusWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///43获取充值金额列表接口
- (Out_RechargeMoneyModel*)getRechargeMoneyListWithKey:(NSString*)key AndDigest:(NSString*)digest;
///44获取红包列表接口(Type 1：可用的红包2：所有的红包)
- (Out_RedPacketModel*)getRedPacketWithModel:(In_RedPacketModel*)model;
///45获取呼单动态中评论列表接口
- (Out_OrderDynamicCommentModel*)getOrderDynamicCommentListWithModel:(In_OrderDynamicCommentModel*)model;
///46获取提现明细列表接口
- (Out_BillsDetailModel*)getBillsDetailWithModel:(In_BillsDetailModel*)model;
///47获取热线电话接口
- (Out_HotLineModel*)getHotLine;
///48意见反馈接口
- (Out_FeedbackModel*)userFeedBackWithModel:(In_FeedbackModel*)model;
///49获取账单列表接口
- (Out_PacketBillsModel*)getPacketBillsWithModel:(In_BillsDetailModel*)model;
///50接单前取消呼单接口
- (Out_CancelOrderBeforeModel*)cancelOrderBeforeWithWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///51申请取消呼单接口
- (Out_AllSameModel*)applyCancelOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///52同意取消呼单接口
- (Out_AllSameModel*)allowCancelOrderWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId;
///53追加小费接口
- (Out_AllSameModel*)addMoreTipsWithKey:(NSString*)key AndDigest:(NSString*)digest AndOrderId:(NSString*)orderId AndTipsId:(int)tipsId;
///54提现接口
- (Out_AllSameModel*)withdrawCashWithModel:(In_WithdrawCashModel*)model;
///55获取绑定提现账号接口
- (Out_WithdrawBindingModel*)getWithdrawBindingAccountWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId;
///56获取雏燕消息接口
- (Out_HSMessageModel*)getHSMessageWithModel:(In_HSMessageModel*)model;
///57推荐有奖接口
- (Out_InviteModel*)inviteRewardWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserid:(NSString*)userid;
///58用户设置接收推送接口
- (Out_AllSameModel*)setPushNotificationWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId AndType:(NSString*)type;
///59呼单动态添加评论接口
- (Out_AllSameModel*)addCommentToOrderDynamicWithModel:(In_AddDynamicCommentModel*)model;
///60投诉接口
- (Out_AllSameModel*)complainOrderWithModel:(In_ComplainModel*)model;
///61查看个人信息接口
- (Out_CheckUserInfoModel*)checkUserInfoWithKey:(NSString*)key AndDigest:(NSString*)digest AndUserId:(NSString*)userId;
///62订单支付接口
- (Out_OrderPayModel*)OrderPayWithModel:(In_OrderPayModel*)model;

//---------------------------物流接口--------------------------------------
//***************************************************************************
///扫码领货接口
- (Out_LScanGoodsModel*)scanAndGetGoodsWithModel:(In_LScanGoodsModel*)model;

///首页信息获取
- (Out_LogisticsHomeModel*)getLogisticsInfoWith:(NSString*)key andDigest:(NSString*)digest;

///送货列表接口
- (Out_LDeliveringModel*)getDeliveringOrderWithModel:(In_DeliveringGoodsModel*)model;

///获取订单详情
- (Out_LOrderDetailModel*)getLOrderDetailWith:(NSString*)key andDigest:(NSString*)digest andOrder:(NSString*)order;


///获取异常列表
- (Out_LExptreasonModel*)getExptReasonListWith:(NSString*)key andDigest:(NSString*)digest andExpttype:(NSString*)expttype;

///反馈列表
- (Out_FeedbackOrderidWithModel *)getFeedBackWithModel:(In_FeedbackOrderidWithModel *)model;

///获取个人信息
- (Out_LPersonInfoModel*)getPersonInfoWith:(NSString*)key andDigest:(NSString*)digest;

#pragma mark 雏燕对接   帐号绑定
- (NSDictionary *)CertificateVControllerWithModel:(In_QiYeModel *)model;
///获取工作汇总
- (CYNSObject*)getWrokReportWith:(NSString*)key andDigest:(NSString*)digest andTime:(NSString*)time;


///获取通知
- (Out_LNotificationModel*)getNotificationWithModel:(In_LNotificationModel*)model;


///用户反馈
- (Out_AllSameModel*)userLFeedBackWith:(NSString*)key andDigest:(NSString*)digest andcontent:(NSString*)feedcontent;

///发送短信
- (Out_LSendMsgModel*)userSendMsgWithModel:(In_LSendMsgModel*)model;

///订单状态反馈
- (Out_LOrderStatusFeedbackModel*)orderStatusFeedbackWithModel:(In_LOrderStatusFeedbackModel*)model;

///帐号绑定
- (NSDictionary *)QiYeRenZhengWithModel:(In_QiYeModel *)model;

///缴款前调用
- (NSDictionary *)WorkPayBeforeWithModel:(In_WorkPayBefore *)model;
- (Out_WorkPayLater *)WorkPayOverWithModel:(In_WorkPayLater *)model;
//扫描二维码
-(out_ScanModel *)scanErWeiMaWithInModel:(In_ScanModel *)model;

//修改企业认证密码
-(Out_chagnPswModel *)changePswWithInModel:(in_chagnPswModel *)model digest:(NSString *)digest andKey:(NSString *)key;

//************************************************************************
#pragma mark   获取当前版本号
-(void)getVerisonWithMsg:(NSString *)msg  resultDic:(void (^)(NSDictionary *dic))dic;
-(void)getVerisonFromAppStoreWithResultDic:(void (^)(NSDictionary *dic))dic;


#pragma mark 到货
///扫码到货接口
- (Out_LScanGoodsModel*)scanAndDaoGoodsWithModel:(In_LScanGoodsModel*)model;
#pragma mark--------修改手机号------------------
- (out_chagnPhoneNumberModel*)changtelephoneNumberWithModel:(in_chagnPhoneNumberModel*)model;

#pragma mark  AFNetworking  获取送货列表
-(void)sendGoodsListWithMsg:(In_DeliveringGoodsModel *)model  resultDic:(void (^)(NSDictionary *dic))dic;
#pragma mark  生成缴款单
- (Out_jiaoKuanModel*)creacteJiaoKuanWith:(NSString*)key andDigest:(NSString*)digest;
#pragma mark  保存缴款单
- (NSDictionary *)saveJiaoKuanWith:(In_BalanceModel *)inModel;
@end
