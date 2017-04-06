//
//  NetModel.m
//  HSApp
//
//  Created by xc on 15/12/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NetModel.h"

@implementation NetModel

@end

//通用返回model
@implementation Out_AllSameModel

@end

//获取注册验证码
@implementation In_RegisterCodeModel

@end

@implementation Out_RegisterCodeModel

@end
//-------------------------------------------------------------

//注册账号
@implementation In_RegisterModel

@end

@implementation OutRegisterBody

@end

@implementation Out_RegisterModel

@end
//-------------------------------------------------------------


//获取登录验证码
@implementation In_LoginCodeModel

@end

@implementation Out_LoginCodeModel

@end
//-------------------------------------------------------------

//用户登录
@implementation In_LoginModel

@end

@implementation OutLoginBody

@end

@implementation Out_LoginModel

@end
//-------------------------------------------------------------

//获取小费列表
@implementation OutTipsBody

@end

@implementation Out_TipsModel

@end
//-------------------------------------------------------------


//获取订单类型列表
@implementation OutTypeBody

@end

@implementation Out_TypeModel

@end
//-------------------------------------------------------------

//获取常用地址列表
@implementation In_AddressModel

@end

@implementation OutAddressBody

@end

@implementation Out_AddressModel

@end
//-------------------------------------------------------------

//新增常用地址列表
@implementation In_AddAddressModel

@end

@implementation Out_AddAddressModel

@end
//-------------------------------------------------------------

//获取培训内容Model
@implementation OutTrainBody

@end

@implementation Out_TrainModel

@end
//-------------------------------------------------------------
//完成培训model
@implementation In_CompleteTrainModel

@end

@implementation Out_ComPleteTrainModel

@end
//-------------------------------------------------------------

//获取测试内容Model
@implementation OutTestBody

@end

@implementation Out_TestModel

@end
//-------------------------------------------------------------

//完成培训model
@implementation In_CompleteTestModel

@end

@implementation Out_ComPleteTestModel

@end
//-------------------------------------------------------------

//删除常用地址model
@implementation In_DeleteAddressModel

@end

@implementation Out_DeleteAddressModel

@end
//-------------------------------------------------------------

//获取呼单圈内容Model
@implementation OutHomeListBody

@end

@implementation Out_HomeListModel

@end
//-------------------------------------------------------------

//发布订单model
@implementation In_PublishOrderModel

@end

@implementation Out_PulishOrderModel

@end
//-------------------------------------------------------------

//认证经纪人model
@implementation In_AuthenBrokerModel

@end

@implementation Out_AuthenBrokerModel

@end
//-------------------------------------------------------------

//获取首页广告model
@implementation OutAdVertBody

@end

@implementation Out_ADInfoBody

@end

@implementation Out_AdvertModel

@end
//-------------------------------------------------------------

//修改常用地址model
@implementation In_UpdateAddressModel

@end

@implementation Out_UpdateAddressModel

@end


//---------------------------------------------------------------

//获取钱包信息model

@implementation Out_MoneyBody

@end

@implementation Out_MoneyModel

@end

//---------------------------------------------------------------
//支付钱包验证码model
@implementation Out_MoneyCodeModel

@end
//---------------------------------------------------------------
//设置或修改支付钱包model
@implementation In_SetMoneyPwdModel

@end

@implementation Out_SetMoneyPwdModel

@end

//---------------------------------------------------------------

//获取经纪人端待接单列表model
@implementation In_WaitOrderListModel

@end

@implementation OutWaitOrderListBody

@end

@implementation Out_WaitOrderListModel

@end
//---------------------------------------------------------------

//经纪人抢单model
@implementation In_GetOrderModel

@end

@implementation Out_GetOrderModel

@end
//---------------------------------------------------------------
//已抢单经纪人model
@implementation In_GetOrderBrokerModel

@end

@implementation Out_GetOrderBrokerBody

@end

@implementation Out_GetOrderBrokerModel

@end
//---------------------------------------------------------------
//呼单列表model
@implementation In_OrderIngListModel

@end

@implementation Out_OrderIngListBody

@end

@implementation Out_OrderIngListModel

@end
//---------------------------------------------------------------

//绑定提现账号model
@implementation In_BindingWithdrawAccountModel

@end

@implementation Out_BindingWithdrawAccountModel

@end
//---------------------------------------------------------------


//选择经纪人model
@implementation Out_ChooseBrokerModel

@end
//---------------------------------------------------------------

//修改用户资料model
@implementation In_UpdateUserInfoModel

@end

@implementation Out_UpdateUserInfoModel

@end
//---------------------------------------------------------------

//刷新用户信息model
@implementation Out_RefreshUserInfoModel

@end
//---------------------------------------------------------------

//编辑江湖口号model
@implementation In_EditUserDeclare

@end

@implementation Out_EditUserDeclare

@end
//---------------------------------------------------------------

//雇主确认订单model
@implementation Out_CustomerConfirmOrderModel

@end

//---------------------------------------------------------------

//呼单详情model
@implementation Out_OrderDetailBody

@end

@implementation Out_OrderDetailModel

@end
//---------------------------------------------------------------

//获取评价列表model
@implementation In_CommentListModel

@end

@implementation Out_CommentListBody

@end

@implementation Out_CommentListModel


@end
//---------------------------------------------------------------

//支付前订单详细信息model
@implementation Out_ReadyPayDetailBody

@end

@implementation Out_ReadyPayDetailModel

@end
//---------------------------------------------------------------

//呼单圈点赞model
@implementation Out_OrderPraiseBody

@end

@implementation Out_OrderPraiseModel

@end
//---------------------------------------------------------------


//获取评价时用户信息model
@implementation Out_CommentUserBody

@end

@implementation Out_CommentUserModel

@end
//---------------------------------------------------------------

//用户评价model
@implementation In_UserCommentModel

@end

@implementation Out_UserCommentModel

@end
//---------------------------------------------------------------

//呼单圈动态model
@implementation OutZANSBody

@end

@implementation Out_OrderDynamicBody

@end

@implementation Out_OrderDynamicModel

@end
//---------------------------------------------------------------

//用户钱包余额支付model
@implementation In_UserPacketPayModel

@end

@implementation Out_UserPacketPayModel

@end
//---------------------------------------------------------------

//订单状态列表model
@implementation Out_OrderDetailStatusBody

@end

@implementation Out_OrderDetailStatusModel

@end
//---------------------------------------------------------------

//充值金额列表model
@implementation Out_RechargeMoneyBody

@end

@implementation Out_RechargeMoneyModel

@end
//---------------------------------------------------------------

//获取红包列表model
@implementation In_RedPacketModel

@end

@implementation Out_RedPacketBody

@end

@implementation Out_RedPacketModel

@end
//---------------------------------------------------------------

//呼单动态评论列表model
@implementation In_OrderDynamicCommentModel

@end

@implementation Out_OrderDynamicCommentBody

@end

@implementation Out_OrderDynamicCommentModel

@end
//---------------------------------------------------------------

//根据类型查询明细model
@implementation In_BillsDetailModel

@end

@implementation Out_BillsDetailBody

@end

@implementation Out_BillsDetailTotalBody

@end

@implementation Out_BillsDetailModel

@end
//---------------------------------------------------------------

//获取热线电话model
@implementation Out_HotLineBody

@end

@implementation Out_HotLineModel

@end
//---------------------------------------------------------------

//意见反馈model
@implementation In_FeedbackModel

@end

@implementation Out_FeedbackModel

@end
//---------------------------------------------------------------

//钱包账单model
@implementation Out_PacketBillsBody

@end

@implementation Out_PacketBillsModel

@end
//---------------------------------------------------------------

//接单前取消呼单model
@implementation Out_CancelOrderBeforeModel

@end
//---------------------------------------------------------------

//提现model
@implementation In_WithdrawCashModel

@end

//---------------------------------------------------------------


//获取绑定提现账号model
@implementation Out_WithdrawBindingBody

@end

@implementation Out_WithdrawBindingModel

@end

//-----------------------------------------------------------------

//获取消息（通知，动态）model
@implementation In_HSMessageModel

@end

@implementation Out_HSMessageBody

@end

@implementation Out_HSMessageModel

@end
//-----------------------------------------------------------------

//推荐有奖model
@implementation Out_InviteBody

@end

@implementation Out_InviteModel

@end

//-----------------------------------------------------------------
//是否接收推送model
//使用通用返回model
//-----------------------------------------------------------------

//呼单动态评论model
@implementation In_AddDynamicCommentModel

@end

//使用通用返回model
//-----------------------------------------------------------------

//投诉model
@implementation In_ComplainModel

@end

//-----------------------------------------------------------------
//查看用户个人信息model
@implementation Out_CheckUserInfoBody

@end

@implementation Out_CheckUserInfoModel

@end
//-----------------------------------------------------------------

//生成支付订单并支付model
@implementation In_OrderPayModel

@end

@implementation Out_orderPayAliBody

@end

@implementation Out_orderPayWeChatBody

@end

@implementation Out_OrderPayAllBody

@end

@implementation Out_OrderPayModel

@end


//---------------------------物流接口模型--------------------------------------
//***************************************************************************

///扫码领货model
@implementation In_LScanGoodsModel

@end

@implementation Out_LScanFailureBody

@end

@implementation Out_LScanGoodsBody

@end

@implementation Out_LScanGoodsModel

@end


///物流首页model
@implementation Out_LogisticsHomeBody

@end


@implementation Out_LogisticsHomeModel

@end


///送货model
@implementation In_DeliveringGoodsModel

@end

@implementation Out_LOrderListBody

@end

@implementation Out_LDeliveringBody

@end

@implementation Out_LDeliveringModel

@end

///获取订单详情

@implementation Out_LOrderDetailBody

@end

@implementation Out_LOrderDetailModel

@end
///获取异常列表model
@implementation Out_LExptreasonBody

@end

@implementation Out_LExptreasonModel

@end

///个人中心model
@implementation Out_LPersonInfoBody

@end

@implementation Out_LPersonInfoModel

@end

///工作汇总model
@implementation Out_LWorkReportBody

@end

@implementation Out_LWorkReportModel

@end

///通知model
@implementation In_LNotificationModel

@end

@implementation Out_LNotificationBody

@end

@implementation Out_LNotificationModel

@end

///发送短信model
@implementation In_LSendMsgModel

@end

@implementation Out_LSendMsgBody

@end

@implementation Out_LSendMsgModel

@end

///订单状态反馈model
@implementation In_LOrderStatusFeedbackModel

@end

@implementation Out_LOrderStatusFailureBody

@end

@implementation Out_LOrderStatusBody

@end

@implementation Out_LOrderStatusFeedbackModel

@end

///绑定帐号

@implementation In_QiYeModel

@end

@implementation Out_QiYeModel

@end

///缴款前调用
@implementation In_WorkPayBefore
@end
@implementation Out_WorkPayBefore

@end
///缴款后调用
@implementation In_WorkPayLater

@end

@implementation Out_WorkPayLater

@end

///反馈列表
@implementation In_FeedbackOrderidWithModel

@end

@implementation Out_FeedbackOrderidWithModel

@end

@implementation Out_ContantDataWithModel

@end

//扫描二维码÷

@implementation In_ScanModel

@end

@implementation out_ScanModel

@end

//修改企业认证密码
@implementation in_chagnPswModel

@end

@implementation Out_chagnPswModel

@end

//修改手机号码
@implementation in_chagnPhoneNumberModel

@end

@implementation out_chagnPhoneNumberModel

@end
@implementation Out_jiaoKuanModel


@end
@implementation Out_JiaoKuanBody


@end
@implementation In_BalanceModel


@end
